import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:mymgs/data_classes/club.dart';
import 'package:mymgs/widgets/text_icon.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:mymgs/helpers/animation.dart';

class ClubCard extends StatelessWidget {
  final Club club;
  const ClubCard({
    @required this.club,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Card(
        child: InkWell(
          onTap: () {
            //Sam, add constructor for your page below in builder: (replacing null), and pass in 'club'
            //Obviously comment the code below back in. You can remove the debug print as well
                Navigator.of(context).push(platformPageRoute(
                context: context,
                builder: (BuildContext context) {
                return Scaffold(
                appBar: AppBar(
                toolbarHeight: 70,
                title: Text('Club Information',
                style: TextStyle(fontSize: 30))),
                body: SizedBox.expand(
                child: SingleChildScrollView(
                child: Column(
                children: <Widget>[
                Container(
                padding: EdgeInsets.all(20),
                height: 1000,
                child: Column(children: [
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.0),
                          ),
                          color: Theme.of(context).primaryColorLight,
                          border: Border.all(
                            color: Theme.of(context).accentColor,
                          width: 0.7),
                      ),
                      child: Center(
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: Text(
                          club.name,
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 35,
                          ),),
                      )
                      )
                ),
                Spacer(flex: 1),
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.0),
                          ),
                          color: Theme.of(context).primaryColorLight,
                          border: Border.all(
                              color: Theme.of(context).accentColor,
                          width: 0.7)
                      ),
                      child: Center(
                        child: Container(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: Column(
                          children: [
                            Text('TIME AND LOCATION',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                                textAlign: TextAlign.center),
                            Text(club.time.getDisplayTime(),
                            style: TextStyle(fontSize: 30),
                            textAlign: TextAlign.center),
                            Text(club.location,
                                style: TextStyle(fontSize: 30),
                                textAlign: TextAlign.center),

                          ]
                        )
                      )
                      )
                  ),
                Spacer(flex: 1),
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.0),
                          ),
                          color: Theme.of(context).primaryColorLight,
                          border: Border.all(
                              color: Theme.of(context).accentColor,
                          width: 0.7)
                      ),
                      child: Center(
                          child: Container(
                              padding: EdgeInsets.symmetric(vertical: 15),
                              child: Column(
                                  children: [
                                    Text('DESCRIPTION',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                        textAlign: TextAlign.center),
                                    Text(club.description,
                                        style: TextStyle(fontSize: 30),
                                        textAlign: TextAlign.center),
                                  ]
                              )
                          )
                      )
                  ),
                Spacer(flex: 1),
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.0),
                          ),
                          color: Theme.of(context).primaryColorLight,
                          border: Border.all(
                              color: Theme.of(context).accentColor,
                            width: 0.7)
                      ),
                      child: Center(
                          child: Container(
                              padding: EdgeInsets.symmetric(vertical: 15),
                              child: Column(
                                  children: [
                                    Text('RAN BY',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                        textAlign: TextAlign.center),
                                    Text(club.staffName,
                                        style: TextStyle(fontSize: 30),
                                        textAlign: TextAlign.center),
                                    Text(club.staffEmail,
                                        style: TextStyle(fontSize: 30),
                                        textAlign: TextAlign.center),

                                  ]
                              )
                          )
                      )
                  ),
                Spacer(flex: 7),

                ]
                )
                )
                ]
                )
                )
                )
                );
                }

                ),
                );
            print("Button pressed! club:" + club.name);
          },
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  club.name,
                  style: Theme.of(context).textTheme.headline6,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  club.description,
                  style: Theme.of(context).textTheme.bodyText1,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    TextIcon(icon: PlatformIcons(context).time),
                    const SizedBox(width: 5),
                    Text(
                      club.time.getDisplayTime(),
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
                Row(
                  children: [
                    TextIcon(icon: PlatformIcons(context).person),
                    const SizedBox(width: 5),
                    Text(
                      club.staffName,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}