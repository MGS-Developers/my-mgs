import 'package:flutter/material.dart';

BoxDecoration getCardDecoration(BuildContext context, {
  double borderRadius = 20,
  Color? color,
}) {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(borderRadius),
    color: color ?? Theme.of(context).primaryColorLight,
    boxShadow: [BoxShadow(
      color: color != null ? color.withOpacity(0.2) : Colors.black.withOpacity(0.08),
      blurRadius: 10,
      spreadRadius: 1,
      offset: const Offset(0, 2),
    )]
  );
}