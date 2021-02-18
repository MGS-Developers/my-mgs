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
              Text(
                "This app was made possible by:",
                style: Theme.of(context).textTheme.bodyText1,
                textAlign: TextAlign.center,
              ),
              ...contributors.map((name) => Padding(
                padding: EdgeInsets.only(top: 15),
                child: Text(
                  name,
                  style: TextStyle(
                    fontSize: 24,
                  ),
                  textAlign: TextAlign.center,
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}