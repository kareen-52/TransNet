import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum FieldType { text, email, password, number, multiline }

class AppTextFormField extends StatefulWidget {
  final int? errorMaxLines;
  final String hintText;
  final FieldType fieldType;
  final TextEditingController? controller;
  final Widget? prefixIcon, suffixIcon;
  final bool? obscureText;
  final Color? backgroundColor;
  final double? borderRadius;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? textStyle, hintStyle;
  final String? Function(String?)? validator;
  final int? maxLines;
  final bool? readOnly;
  final ValueChanged<String>? onFieldSubmitted;
  final TextInputAction? textInputAction;
  final bool enabled;

  const AppTextFormField({
    super.key,
    required this.hintText,
    this.fieldType = FieldType.text,
    this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText,
    this.backgroundColor,
    this.borderRadius,
    this.contentPadding,
    this.textStyle,
    this.hintStyle,
    this.validator,
    this.maxLines,
    this.readOnly,
    this.onFieldSubmitted,
    this.textInputAction,
    this.enabled = true,
    this.errorMaxLines,
  });

  @override
  State<AppTextFormField> createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  late bool isObscured;

  @override
  void initState() {
    super.initState();
    isObscured =
        widget.fieldType == FieldType.password || (widget.obscureText ?? false);
  }

  @override
  Widget build(BuildContext context) {
    TextInputType keyboardType;
    switch (widget.fieldType) {
      case FieldType.email:
        keyboardType = TextInputType.emailAddress;
        break;
      case FieldType.password:
        keyboardType = TextInputType.visiblePassword;
        break;
      case FieldType.number:
        keyboardType = TextInputType.number;
        break;
      case FieldType.multiline:
        keyboardType = TextInputType.multiline;
        break;
      default:
        keyboardType = TextInputType.text;
    }

    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      textAlign: TextAlign.right,
      textDirection: TextDirection.rtl,
      enabled: widget.enabled,
      readOnly: widget.readOnly ?? false,
      onFieldSubmitted: widget.onFieldSubmitted,
      keyboardType: keyboardType,
      obscureText: isObscured,
      maxLines:
          widget.maxLines ?? (widget.fieldType == FieldType.multiline ? 3 : 1),
      style: widget.textStyle,
      textInputAction:
          widget.textInputAction ??
          (widget.fieldType == FieldType.multiline
              ? TextInputAction.newline
              : TextInputAction.next),
      decoration: InputDecoration(
        isDense: true,

        errorMaxLines: widget.errorMaxLines,
        contentPadding:
            widget.contentPadding ??
            EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        hintText: widget.hintText,
        hintStyle: widget.hintStyle ?? Theme.of(context).textTheme.bodyMedium,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.fieldType == FieldType.password
            ? IconButton(
                icon: Icon(
                  isObscured
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                ),
                onPressed: () => setState(() => isObscured = !isObscured),
              )
            : widget.suffixIcon,
      ),
    );
  }
}
