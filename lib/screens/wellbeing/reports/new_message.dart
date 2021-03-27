import 'package:flutter/material.dart';
import 'package:mymgs/data/safeguarding.dart';
import 'package:mymgs/data_classes/safeguarding_case.dart';

class NewMessage extends StatefulWidget {
  final SafeguardingCase safeguardingCase;
  const NewMessage({
    required this.safeguardingCase,
  });

  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  bool sending = false;
  final _controller = TextEditingController();

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    if (_controller.text == "") return;

    setState(() {
      sending = true;
    });

    await sendSafeguardingMessage(widget.safeguardingCase.id, _controller.text);

    setState(() {
      sending = false;
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              enabled: !sending,
              textCapitalization: TextCapitalization.sentences,
              textInputAction: TextInputAction.newline,
              decoration: InputDecoration(
                hintText: "Enter your message...",
                hintStyle: Theme.of(context).textTheme.bodyText1,
              ),
              maxLines: null,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15),
            child: ElevatedButton(
              onPressed: sending ? null : _send,
              child: Icon(Icons.send),
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                padding: EdgeInsets.all(20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
