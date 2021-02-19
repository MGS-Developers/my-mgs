// a central place to define the app's public-facing name.
// never hard-code this anywhere in the app — always refer to this variable.
// as a compile-time constant ('const'), the end result will be the same as hard-coding.
// remember that this only applies to Dart-based app name references — the app/play store listings and OS app registration requires platform-specific code so are independent of this variable
const appName = "MyMGS";

// the app's current version. must be updated between releases.
const appVersion = "0.0.1";

const appLegalese = """
Copyright © 2020-2021, The """ + appName + """ Authors. All rights reserved.
Source code available under MIT license at https://github.com/My-MGS/my-mgs.
""";

const contributors = [
  "Pal Kerecsenyi",
  "Jude Waide",
];