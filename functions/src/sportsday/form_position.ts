import {Form, FormWithPoints} from "./types";
import * as admin from "firebase-admin";
import {groupBy} from "lodash";
import {runCompetition} from "./position";

enum CompetitionScope {
    Year,
    School,
}

const batchUpdateForms = (
    forms: FormWithPoints[],
    scope: CompetitionScope,
    batch: admin.firestore.WriteBatch
): void => {
    for (const form of forms) {
        let updateObject: {
            [key: string]: number | undefined;
        } = {};
        if (scope === CompetitionScope.Year) {
            updateObject['points.yearPosition'] = form.points.yearPosition;
        } else {
            updateObject['points.schoolPosition'] = form.points.schoolPosition;
        }

        batch.update(
            admin.firestore().collection('sd_forms').doc(form.id),
            updateObject,
        );
    }
}

const rankAndUpdateForms = (
    unrankedForms: FormWithPoints[],
    scope: CompetitionScope,
    batch: admin.firestore.WriteBatch,
): void => {
    const rankedForms = runCompetition(
        unrankedForms,
        (e) => e.points.total,
        (e, rank) => {
            if (scope === CompetitionScope.Year) {
                e.points.yearPosition = rank;
            } else {
                e.points.schoolPosition = rank;
            }
        }
    );

    batchUpdateForms(rankedForms, scope, batch);
}

// If onlyYearGroup is undefined, will run intra-year competitions an all year groups and a whole-school competition
// If onlyYearGroup is defined, will run a single intra-year competition on specified year group and a whole-school competition
export const reassignFormPositions = async (onlyYearGroup?: number): Promise<void> => {
    const allFormsResponse = await admin.firestore()
        .collection('sd_forms')
        .get();

    const allForms = allFormsResponse.docs.map(e => ({
        ...e.data() as Form,
        id: e.id,
    })).filter(e => e.points) as FormWithPoints[];

    const batch = admin.firestore().batch();
    rankAndUpdateForms(allForms, CompetitionScope.School, batch);

    if (onlyYearGroup) {
        const yearGroupForms = allForms.filter(e => e.yearGroup === onlyYearGroup);
        rankAndUpdateForms(yearGroupForms, CompetitionScope.Year, batch);
    } else {
        const byYearGroup = groupBy(allForms, e => e.yearGroup);
        for (const yearGroup of Object.keys(byYearGroup)) {
            rankAndUpdateForms(byYearGroup[yearGroup], CompetitionScope.Year, batch);
        }
    }

    await batch.commit();
}
