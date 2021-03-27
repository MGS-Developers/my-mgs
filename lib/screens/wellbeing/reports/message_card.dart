import 'package:flutter/material.dart';
import 'package:mymgs/data_classes/safeguarding_case.dart';

class SafeguardingMessageCard extends StatelessWidget {
  final DecryptedSafeguardingCaseMessage message;
  final bool extraTopPadding;
  const SafeguardingMessageCard({
    required this.message,
    this.extraTopPadding = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: message.recipientIsStudent ? Alignment.centerLeft : Alignment.centerRight,
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10).copyWith(
        top: extraTopPadding ? 15 : 0,
      ),
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 100,
        ),
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 14),
        decoration: BoxDecoration(
          color: MediaQuery.of(context).platformBrightness == Brightness.dark ? Theme.of(context).cardColor : Color(0xFFf0f0f0),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          message.decryptedMessage,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
