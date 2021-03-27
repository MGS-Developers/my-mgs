import 'package:flutter/material.dart';
import 'package:mymgs/data/safeguarding.dart';
import 'package:mymgs/data_classes/safeguarding_case.dart';
import 'package:mymgs/screens/wellbeing/reports/message_card.dart';
import 'package:mymgs/screens/wellbeing/reports/new_message.dart';
import 'package:mymgs/widgets/spinner.dart';

class SafeguardingReportChat extends StatelessWidget {
  final SafeguardingCase safeguardingCase;
  final String passphrase;
  final Stream<List<DecryptedSafeguardingCaseMessage>> _messageStream;
  SafeguardingReportChat({
    required this.safeguardingCase,
    required this.passphrase,
  }) : _messageStream = getSafeguardingMessages(safeguardingCase.id, passphrase);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Case chat"),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<DecryptedSafeguardingCaseMessage>>(
              stream: _messageStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: Spinner(),
                  );
                }

                final data = snapshot.data;
                if (data == null) {
                  return Center(
                    child: Text("Something went wrong."),
                  );
                }

                return ListView.builder(
                  reverse: true,
                  padding: EdgeInsets.symmetric(
                    vertical: 30,
                  ),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final message = data[index];
                    bool extraTopPadding = false;

                    if (index != data.length - 1 && data[index + 1].recipientIsStudent != message.recipientIsStudent) {
                      extraTopPadding = true;
                    }

                    return SafeguardingMessageCard(
                      message: message,
                      extraTopPadding: extraTopPadding,
                    );
                  }
                );
              },
            ),
          ),
          NewMessage(safeguardingCase: safeguardingCase),
        ],
      ),
    );
  }
}
