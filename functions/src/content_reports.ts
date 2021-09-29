import * as functions from 'firebase-functions';
import type * as admin from 'firebase-admin';
import {createAppAuth} from "@octokit/auth-app";
import {Octokit} from "@octokit/rest";

export const createIssueForContentReport = functions
    .region("europe-west2")
    .firestore
    .document('content_reports/{report_id}')
    .onCreate(async (snapshot) => {
        const data = snapshot.data() as {
            createdAt: admin.firestore.Timestamp;
            identifier: admin.firestore.DocumentReference;
            message: string;
        }

        const app = new Octokit({
            authStrategy: createAppAuth,
            auth: {
                appId: 141474,
                clientId: "Iv1.da7a9b28ba4d9955",
                clientSecret: functions.config().github.client_secret,
                privateKey: functions.config().github.private_key,
                installationId: 19807843,
            }
        });

        const date = data.createdAt.toDate().toLocaleString('en-GB', {
            timeZone: 'Europe/London',
        });

        const link = `[${data.identifier.path}](https://admin.mymgs.link/${data.identifier.path})`;

        await app.issues.create({
            owner: 'MGS-School-Council',
            repo: 'content-reports',
            title: data.identifier.path,
            body: `
| Data      | Value   |
|-----------|---------|
| Created   | ${date} |
| Reference | ${link} |

### Message
> ${data.message}
            `,
        });
    });