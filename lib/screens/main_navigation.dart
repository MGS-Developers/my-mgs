// stuff gets pretty complicated here, but don't worry!
// this file contains the main navigation frame for our app
// you'll find the code for the fancy sidebar thing (called a 'drawer') here, as well as the code that selects which page to display
// https://flutter.dev/docs/cookbook/design/drawer

import 'package:flutter/material.dart';
import 'package:mymgs/data/setup.dart';
import 'package:mymgs/helpers/app_name.dart';
import 'package:mymgs/screens/clubs.dart';
import 'package:mymgs/screens/dashboard.dart';
import 'package:mymgs/screens/diary.dart';
import 'package:mymgs/screens/setup/setup.dart';
import 'package:mymgs/screens/talks.dart';
import 'package:mymgs/widgets/spinner.dart';

// this is a lil complicated
// basically, we're storing a dynamic reference to our app's main scaffold widget
// we're doing this so that other widgets can call the scaffoldKey.currentState.openDrawer() function
// that means that any widget in our app can open the drawer with just a single function
final GlobalKey<ScaffoldState> scaffoldKey = LabeledGlobalKey('main_scaffold');

// this widget has what's known as a 'state', so it extends StatefulWidget instead of StatelessWidget
// this basically means that we have variable(s) that we need to change, and when they change we want the build() function to be called again
// some widgets made by the build() function may change depending on the value of these variables
// https://flutter.dev/docs/development/ui/interactive#stateful-and-stateless-widgets (the word 'subclasses' on this page means 'extends')
class MainNavigation extends StatefulWidget {
  // explicitly declaring this constructor (even though you don't have to) ensures that the class can be initialised as a compile-time constant
  const MainNavigation();
  _MainNavigationState createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  // our list of screens never changes, so why not make it a compile-time constant?
  // these are just the screens we want to be navigable within our app drawer
  static const List<Widget> screens = [
    Dashboard(),
    Talks(),
    Clubs(),
    Diary(),
  ];

  // aaand here's our state! this variable doesn't have 'final' before it, because we actually need to change it
  // this refers to which member of the 'screens' array we want to be displaying
  // when the user selects a different screen from the drawer, we change the value of this to match what they selected
  // whenever we change this variable, Flutter will call the build() function for us, ensuring that the screen updates
  int currentIndex = 0;

  // this is a convenience method we made for ourselves
  // putting '_' before a method's name means only this class can access it
  // _selectPage is invisible to other classes or pieces of code
  // it's mostly just a memory optimisation
  void _selectPage(int index) {
    setState(() {
      currentIndex = index;
    });
    Navigator.pop(context);
  }

  SetupStatus setupStatus = SetupStatus.Determining;

  // this is a special function that gets called when the widget is initialised
  // in here, we can run any code want to to set the widget up
  // in this case, we want to find out whether the user has set the app up or not
  // if not, we need to show them a setup screen
  @override
  void initState() {
    super.initState();
    getSetupComplete().then((value) {
      setState(() {
        setupStatus = value;
      });
    });
  }

  // our setup screen will call this function when it's finished
  void _completeSetup() {
    setState(() {
      setupStatus = SetupStatus.Complete;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (setupStatus == SetupStatus.Determining) {
      return Scaffold(
        body: Center(
          child: Spinner(),
        ),
      );
    }

    if (setupStatus == SetupStatus.Incomplete) {
      // like with any other programming language, a 'return' statement also ends the function
      // no code runs after this return statement, meaning that the other return statement below won't be run if this is run
      // this way, we return the setup screen, and nothing but the setup screen
      return SetupScreen(
        quitSetup: _completeSetup
      );
    }

    // a scaffold acts as an overlay over our app
    // it can contain an app bar, a drawer, a bottom bar, and many other things!
    // for now, we just need the body and the drawer features
    return Scaffold(
      // here's our key from before
      // Flutter will now populate the 'scaffoldKey' variable with this scaffold's built-in functions, incl. the one to open the drawer
      key: scaffoldKey,
      // here comes our drawer! surprisingly, Drawer is a built-in Flutter widget. it's already made for us!
      drawer: Drawer(
        child: Container(
          // Theme.of(context) lets us access the current theme — when the phone switches between dark/light mode, this will automatically update
          color: Theme.of(context).backgroundColor,
          child: ListView(
            // EdgeInsets.zero ensures that there's no padding — preventing any borders from appearing around the inner edge of our drawer
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                child: const Text(
                  appName,
                  style: TextStyle(color: Colors.white),
                ),
                decoration: BoxDecoration(
                  // here, we're making the drawer's header's background colour be our current theme's primary colour
                  color: Theme.of(context).primaryColor,
                ),
              ),
              ListTile(
                title: const Text('Dashboard'),
                onTap: () => _selectPage(0),
              ),
              ListTile(
                title: const Text('Talks'),
                onTap: () => _selectPage(1),
              ),
              ListTile(
                title: const Text('Clubs'),
                onTap: () => _selectPage(2),
              ),
              ListTile(
                title: const Text('Homework Diary'),
                onTap: () => _selectPage(3),
              )
            ],
          ),
        )
      ),
      // IndexedStack just helps us switch between screens easily, and performs a lot of memory optimisation under the hood
      // children is a list of possible screens/widgets
      // and index is which one of those screens/widgets to show
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
    );
  }
}