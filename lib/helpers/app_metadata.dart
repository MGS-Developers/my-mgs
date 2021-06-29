// a central place to define the app's public-facing name.
// never hard-code this anywhere in the app — always refer to this variable.
// as a compile-time constant ('const'), the end result will be the same as hard-coding.
// remember that this only applies to Dart-based app name references — the app/play store listings and OS app registration requires platform-specific code so are independent of this variable
const appName = "MyMGS";

// the app's current version. must be updated between releases.
const appVersion = "0.4.0";

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
  ],
  "Design": [
    "P Kerecsenyi",
    "B Khan",
    "G Kerecsenyi",
    "X Mills",
  ],
  "Data": [
    "P Kerecsenyi",
    "X Mills",
    "M Naylor",
    "K Vadera",
  ],
  "Sports Day coverage": [
    "P Kerecsenyi",
    "G Kerecsenyi",
    "E Aspen",
  ],
  "Concept & testing": [
    "The MGS School Council",
  ],
};
