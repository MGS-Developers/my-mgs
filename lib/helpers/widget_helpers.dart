import 'package:flutter/material.dart';

BoxDecoration getCardDecoration(BuildContext context, {
  double borderRadius = 20,
}) {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(borderRadius),
    color: Theme.of(context).primaryColorLight,
    boxShadow: [BoxShadow(
      color: Colors.black.withOpacity(0.08),
      blurRadius: 10,
      spreadRadius: 1,
      offset: const Offset(0, 2),
    )]
  );
}