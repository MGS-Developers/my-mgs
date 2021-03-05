import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:mymgs/data_classes/club.dart';
import 'package:mymgs/widgets/text_icon.dart';

class ClubCard extends StatelessWidget {
  final Club club;
  const ClubCard({
    required this.club,
  });

  @override
  Widget build(BuildContext context) {
    final description = club.description;
    final staffName = club.staffName;

    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Card(
        child: InkWell(
          onTap: () {
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
                if (description != null) Text(
                  description,
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
                if (staffName != null) Row(
                  children: [
                    TextIcon(icon: PlatformIcons(context).person),
                    const SizedBox(width: 5),
                    Text(
                      staffName,
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