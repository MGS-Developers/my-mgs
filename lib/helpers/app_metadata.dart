// a central place to define the app's public-facing name.
// never hard-code this anywhere in the app — always refer to this variable.
// as a compile-time constant ('const'), the end result will be the same as hard-coding.
// remember that this only applies to Dart-based app name references — the app/play store listings and OS app registration requires platform-specific code so are independent of this variable
const appName = "MyMGS";

// the app's current version. must be updated between releases.
const appVersion = "0.7.1";

const appLegalese = """
This app is part of a family of co-curricular sites run by students and staff of the Manchester Grammar School. The main school website is at mgs.org.

Copyright © 2020-2021, The $appName Authors.
Source code available under MIT license at https://github.com/MGS-School-Council/my-mgs.
""";

const appSourceUrl = "https://github.com/MGS-School-Council/my-mgs";

const appContributors = {
  "Code": [
    "P Kerecsenyi",
    "J Waide",
    "S Pottage",
    "G Kerecsenyi",
    "J Santiago",
  ],
  "Design": [
    "P Kerecsenyi",
    "B Khan",
    "X Mills",
  ],
  "Data": [
    "P Kerecsenyi",
    "X Mills",
    "M Naylor",
    "K Vadera",
  ],
  "Concept & testing": [
    "The MGS School Council",
  ],
};

const appPrivacyLink = "https://docs.google.com/document/d/1t73ulBdv2QC7vgtMRjyxAWr9H3kKfwINGwLyJ-T-8E0";
