import 'package:flutter/material.dart';
import 'package:mymgs/data_classes/club.dart';

class ClubCard extends StatelessWidget {
  final Club club;
  const ClubCard({
    @required this.club,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: Theme.of(context).primaryColor,
        ),
        child: OutlinedButton(
          onPressed: () {
            //Sam, add constructor for your page below in builder: (replacing null), and pass in 'club'
            //Obviously comment the code below back in. You can remove the debug print as well
            /**
                Navigator.of(context).push(platformPageRoute(
                context: context,
                builder: null
                ),
                );
             **/
            print("Button pressed! club:" + club.name);
          },
          child: Column(
            children: [
              Text(
                club.name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color:
                  Theme.of(context).primaryColorLight,
                  fontSize: 20,
                ),
              ),
              Text(
                club.time.getDisplayTime(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color:
                  Theme.of(context).primaryColorLight,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}