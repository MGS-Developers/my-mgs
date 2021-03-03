// Copyright 2021 The MyMGS Authors
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
// WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR
// IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

// Hi there!
// Welcome to MyMGS' source code. This file, main.dart, is the file Dart will automatically open first
// this file needs to contain the 'main' function, which is the starting point for our app. Dart will call this to start our app.

// I (Pal) have put in some helpful comments to try and guide you through what everything here is doing
// unless you're a flutter pro 😎, pls read my comments carefully

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mymgs/notifications/init.dart';
import 'package:mymgs/screens/main_navigation.dart';
import 'package:mymgs/widgets/spinner.dart';
import 'helpers/app_metadata.dart';

// this is the function Dart automatically calls to start the app — it's known as the entrypoint
// trying to run _anything_ before runApp() will cause a fatal error
// for clarity, avoid adding anything else to this function
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());

  setupNotifications();
}

// this is our first class!
// it extends [StatelessWidget], a built-in Flutter class that represents a 'widget'
// a 'widget' is just a visible piece of UI. it can be a button, a specific screen, or in this case, the entire app
// widgets can be nested inside each other. for example, this widget contains multiple screens, which contain text
class App extends StatelessWidget {
  // before we can use Firebase's modules, we need to initialise it
  // initialisation uses a Future, so we need to make sure the app doesn't load until it has completed
  // obviously, this process takes less than a millisecond
  final Future<FirebaseApp> _firebaseInit = Firebase.initializeApp()
    .then((value) {
      // turn on data persistence — allows data to be saved to phone automatically and queried locally if there's no connection
      // https://firebase.flutter.dev/docs/firestore/usage#access-data-offline
      FirebaseFirestore.instance.settings = Settings(persistenceEnabled: false);
      return Future.value(Firebase.apps[0]);
    });

  // Futures play a pretty major role in any Dart-based application, since it's a primarily asynchronous language
  // if you've ever used JavaScript, a Future is the exact same thing as a Promise.
  // if not, read this guide to get an understanding: https://dart.dev/codelabs/async-await

  // base text themes
  // these get copied and modified for dark theme
  static const TextTheme textTheme = TextTheme(
    bodyText1: TextStyle(
      color: Colors.black54,
      fontWeight: FontWeight.normal,
    ),
  );

  static final buttonStyle = ButtonStyle(
    shape: MaterialStateProperty.all(RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    )),
  );
  static final materialStateColorLight = MaterialStateProperty.all(Color(0xFF374b6a));

  // Themes!
  // our app can run in two modes: dark mode and light mode.
  // we don't just support dark mode because it 'looks cool' (but yeah it does)
  // dark mode is a very important accessibility feature, and also helps save battery with OLED/AMOLED devices
  // using Flutter's theme system, we can easily define colours for both light and dark mode, as well as text styles
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    // we define colors using the Color() class
    // we use a hexadecimal number (starting with 0x) and a hex colour code, similar to HTML
    // the first two digits are the alpha value: i.e. how opaque. mostly we use 'FF', i.e. fully opaque
    // it's in the format of ARGB, like this:
    // 0x<alpha 00-FF><red 00-FF><green 00-FF><blue 00-FF>
    // to get a colour you like, type 'colour picker' into google, choose a colour, copy the hex (without the #), and paste like this:
    // Color(0xFF<paste here>)

    // the primaryColor is the colour we use for any interactive components, headers, and basically anything we want to draw attention to or separate
    primaryColor: Color(0xFF374b6a),
    primaryColorLight: Colors.white,
    primaryColorDark: Colors.grey[200],
    primaryColorBrightness: Brightness.dark,
    accentColor: Color(0xFFb4bbc7),
    backgroundColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    textTheme: textTheme,
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: buttonStyle.copyWith(
        foregroundColor: materialStateColorLight,
      )
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: buttonStyle.copyWith(
        backgroundColor: materialStateColorLight,
      ),
    ),
    cardTheme: CardTheme(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    ),
    inputDecorationTheme: InputDecorationTheme(
      alignLabelWithHint: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    )
  );

  // since most of the dark theme will be the same, we can copy the lightTheme and override the things we want to
  static final ThemeData darkTheme = lightTheme.copyWith(
    primaryColor: Color(0xFF061F45),
    primaryColorLight: Colors.blueGrey[900],
    primaryColorDark: Colors.blueGrey[900],
    backgroundColor: Colors.black,
    scaffoldBackgroundColor: Colors.black,
    textTheme: textTheme.copyWith(
      bodyText1: TextStyle(
        color: Colors.white70,
        fontWeight: FontWeight.normal,
      ),
      bodyText2: TextStyle(
        color: Colors.white70,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: lightTheme.outlinedButtonTheme.style.copyWith(
        foregroundColor: MaterialStateProperty.all(Colors.white),
      ),
    ),
    cardColor: Colors.blueGrey[900],
    iconTheme: IconThemeData(
      color: Colors.blueGrey[200],
    ),
    dialogBackgroundColor: Colors.blueGrey[900],
    inputDecorationTheme: lightTheme.inputDecorationTheme.copyWith(
      labelStyle: TextStyle(
        color: Colors.white70,
      ),
    ),
  );

  // the 'build' function needs to be defined for widgets
  // flutter will call this function and expect our UI pieces to be returned
  // if nothing is returned (or if we return something other than widgets), the app will crash :'(
  @override
  Widget build(BuildContext context) {
    // the FutureBuilder widget takes two named parameters (https://dart.dev/codelabs/dart-cheatsheet#optional-named-parameters)
    // the 'future' parameter expects a future, like the one we defined above as a class property (_firebaseInit)
    // the 'builder' parameter expects a function, taking the 'context' and 'snapshot' arguments
    // the FutureBuilder will call the builder function when it's first initialised and will expect to get a widget back immediately
    // it will then call the builder function once again when the future completes
    // if during either call it doesn't return a widget, the app will crash :)
    // https://api.flutter.dev/flutter/widgets/FutureBuilder-class.html
    // FutureBuilder is making a traditionally imperative piece of code be declarative, meaning that we get to write less code
    return FutureBuilder(
      future: _firebaseInit,
      builder: (BuildContext context, snapshot) {
        // if the Future hasn't finished, display a loading spinner thing
        if (snapshot.connectionState != ConnectionState.done) {
          return Center(
            // Spinner is a widget made by pal
            // pro tip: cmd/ctrl+click a function or variable to jump to its definition (in Android Studio)
            child: Spinner(),
          );
        }

        // MaterialApp builds up the basics of our app, like the header bar and the colours, allowing us to use these without rewriting code every time
        return MaterialApp(
          title: appName,
          theme: lightTheme,
          darkTheme: darkTheme,
          // have no clue what ThemeMode.system means? try cmd/ctrl + clicking on 'system' to see where it's defined (in Android Studio)
          // the vast majority of Flutter's definitions come with extensive code comments!
          themeMode: ThemeMode.system,
          home: const MainNavigation(),
        );
      }
    );
  }
}