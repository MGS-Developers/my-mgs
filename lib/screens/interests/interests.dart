import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:mymgs/data/interests.dart';
import 'package:mymgs/screens/interests/about.dart';

class InterestsScreen extends StatefulWidget {
  const InterestsScreen();
  _InterestsScreenState createState() => _InterestsScreenState();
}

class _InterestsScreenState extends State<InterestsScreen> {
  final _stream = InterestsManager().watchInterests();
  final _search = TextEditingController();
  String query = '';

  void _searchListener() {
    setState(() {
      query = _search.text.toLowerCase();
    });
  }

  @override
  void initState() {
    super.initState();
    _search.addListener(_searchListener);
  }

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Interests"),
        actions: [
          PlatformIconButton(
            icon: Icon(PlatformIcons(context).info),
            onPressed: () {
              Navigator.of(context).push(platformPageRoute(
                context: context,
                builder: (_) => const InterestsAbout(),
              ));
            },
          ),
        ],
      ),
      body: StreamBuilder<List<Interest>>(
        stream: _stream,
        builder: (context, snapshot) {
          final _interests = snapshot.data ?? [];
          final filteredInterests = _interests.where((i) => i.name.toLowerCase().startsWith(query));

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: PlatformTextField(
                  controller: _search,
                  hintText: "Search...",
                  textCapitalization: TextCapitalization.words,
                  autofocus: true,
                ),
              ),

              SingleChildScrollView(
                padding: const EdgeInsets.all(15),
                child: Wrap(
                  spacing: 6,
                  children: filteredInterests.map((interest) => InputChip(
                    label: Text(interest.name),
                    onSelected: (_) => InterestsManager().toggleInterest(interest),
                    selected: interest.interested,
                  )).toList(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
