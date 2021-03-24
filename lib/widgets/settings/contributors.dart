import 'package:flutter/material.dart';
import 'package:mymgs/helpers/app_metadata.dart';

class Contributors extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contributors"),
      ),
      body: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ...appContributors.keys.map((category) => Column(
                children: [
                  Text(
                    category,
                    style: Theme.of(context).textTheme.bodyText1,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 5),
                  ...appContributors[category]!.map((name) => Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text(
                      name,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )),
                  const SizedBox(height: 15),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}
