# MyMGS
An MGS School Council project.

## Important: before making a contribution
Before making a contribution, please read [the contributing guide](https://github.com/My-MGS/my-mgs/blob/master/CONTRIBUTING.md) and follow it.

## About this project
We're making an app to help MGS students navigate school life. This app will eventually include a range of features:

- A list of clubs, talks, societies, and drama performances
- Up-to-date catering menu — and a quick way to see what today's menu is
- Links to well-being charities
- Practical revision resources, sorted by year group and subject
- ...and more!

## Getting started
To get started developing MyMGS, [take a look at Pal's slideshow](https://docs.google.com/presentation/d/1PeUDCDDno2yWrFLfk6lrHQWurxSg167CJwW3c2knNwk/edit?usp=sharing) which contains some handy tips on how to install the Flutter SDK and set up your environment.

Then, clone this repo. If you're on Mac or Linux, Git should already be installed, but on Windows you'll need to [install it yourself](https://git-scm.com/download/win). Once that's done, just open a command line, navigate to your intended parent directory, and run:

```bash
git clone https://github.com/My-MGS/my-mgs mymgs
```

Enter the directory with your command line, and run:

```bash
flutter pub get
```

And you're done! Open Android Studio (or your preferred IDE, but Android Studio definitely gives the best experience) and open the new `mymgs` directory.

## Testing QR code
When you first open the app, you'll be prompted for a QR code. Obviously, don't try to ask your form tutor for one. QR codes are generated using an AES-encrypted version of the [TOTP](https://en.wikipedia.org/wiki/Time-based_One-time_Password_algorithm) algorithm, so the usable QR code changes once every 30 seconds.

To get the currently usable QR code, just visit this page:  [https://europe-west2-my-mgs-app.cloudfunctions.net/getQrCode?password=pythoniscool](https://europe-west2-my-mgs-app.cloudfunctions.net/getQrCode?password=pythoniscool). It may take a few seconds to load, since the function running it is shut down when it hasn't been used for over 30 minutes, and you'll have to wait for it to start up again.