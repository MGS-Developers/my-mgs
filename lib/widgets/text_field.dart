import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

typedef StringCallback = void Function(String);

class MGSTextField extends StatelessWidget {
  final TextEditingController? controller;
  final bool? enabled;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final StringCallback? onSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final bool? autofocus;
  final TextCapitalization? textCapitalization;
  final bool? readOnly;
  final VoidCallback? onTap;
  final int? maxLines;
  final bool? obscureText;

  final String? label;
  // Android-only
  final String? hint;
  final String? error;
  const MGSTextField({
    Key? key,
    this.controller,
    this.enabled,
    this.keyboardType,
    this.textInputAction,
    this.onSubmitted,
    this.label,
    this.error,
    this.hint,
    this.inputFormatters,
    this.autofocus,
    this.textCapitalization,
    this.readOnly,
    this.onTap,
    this.maxLines,
    this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return PlatformTextField(
      controller: controller,
      enabled: enabled,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      onSubmitted: onSubmitted,
      inputFormatters: inputFormatters,
      autofocus: autofocus,
      textCapitalization: textCapitalization,
      readOnly: readOnly,
      onTap: onTap,
      maxLines: maxLines,
      obscureText: obscureText,
      material: (_, __) => MaterialTextFieldData(
        decoration: InputDecoration(
          labelText: label,
          errorText: error,
        ),
      ),
      cupertino: (_, __) => CupertinoTextFieldData(
        style: Theme.of(context).textTheme.subtitle1,
        placeholder: label,
      ),
    );
  }
}