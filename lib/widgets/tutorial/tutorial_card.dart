import 'package:flutter/material.dart';

class TutorialCard extends StatelessWidget {
  final VoidCallback onPressed;
  final List<Widget> children;
  final bool enabled;
  const TutorialCard({
    Key? key,
    required this.onPressed,
    required this.children,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Theme.of(context).colorScheme.primary),
      ),
      width: double.infinity,
      child: InkWell(
        onTap: enabled ? onPressed : null,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          ),
        ),
      ),
    );
  }
}