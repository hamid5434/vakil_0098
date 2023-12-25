import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    Key? key,
    required this.hint,
    this.borderRadius,
    this.prefixIcon = Icons.clear,
    this.suffixIcon = Icons.remove_red_eye,
    this.textAlign = TextAlign.right,
    this.backColor,
    this.suffixIconColor,
    this.prefixIconColor,
    this.suffixIconSize = 20,
    this.prefixIconSize = 20,
    this.callbackSuffixIcon,
    this.callbackPrefixIcon,
    this.textChange,
    this.enable = true,
    this.obscureText = false,
    required this.controller,
    this.margin,
    this.isNumber = false,
    this.padding,
    this.isLoading,
    this.prefix,
    this.focusNode,
    this.borderSide = BorderSide.none,
    this.textInputAction,
    this.textAlignVertical,
    this.minLines = 1,
    this.maxLines = 1
  }) : super(key: key);

  final String hint;
  final BorderRadius? borderRadius;
  final IconData prefixIcon;
  final IconData? suffixIcon;
  final TextAlign textAlign;
  final Color? backColor;
  final Color? suffixIconColor;
  final Color? prefixIconColor;
  final double suffixIconSize;
  final TextEditingController controller;
  final Function(String)? textChange;
  final double prefixIconSize;
  final bool obscureText;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  bool isNumber;
  final bool? enable;
  final GestureTapCallback? callbackSuffixIcon;
  final GestureTapCallback? callbackPrefixIcon;
  final bool? isLoading;
  final Widget? prefix;
  final FocusNode? focusNode;
  final BorderSide borderSide;
  final TextInputAction? textInputAction;
  final TextAlignVertical? textAlignVertical;
  final int minLines;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: margin ??
          const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      padding: padding ?? EdgeInsets.zero,
      decoration: BoxDecoration(
          color: backColor ?? theme.colorScheme.surface,
          borderRadius: borderRadius ?? BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.06),
              spreadRadius: 1,
              blurRadius: 5,
            ),
          ]),
      child: TextField(
        textAlignVertical: textAlignVertical,
        focusNode: focusNode,
        textInputAction: textInputAction ?? TextInputAction.done,
        onSubmitted: (value) {},
        controller: controller,
        //initialValue: qty.toString(),
        enabled: enable,
        //autofocus: true,
        maxLines: maxLines,
        minLines: minLines,
        onChanged: textChange ?? (value) {},
        textAlign: textAlign,
        keyboardType:
            isNumber ? TextInputType.number : TextInputType.text,
        inputFormatters: isNumber
            ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]
            : [],
        style: TextStyle(
          fontSize: 16,
          letterSpacing: 0.1,
          fontWeight: FontWeight.w500,
          color: theme.colorScheme.onSecondary,
        ),
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            fontSize: 14,
            letterSpacing: 0.1,
            fontWeight: FontWeight.w500,
            color: theme.colorScheme.secondaryContainer,
          ),
          border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(8.0),
              ),
              borderSide: borderSide),
          enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              ),
              borderSide: BorderSide.none),
          focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              ),
              borderSide: BorderSide.none),
          //filled: true,
          //fillColor: Colors.white,
          prefix: prefix,
          prefixStyle: TextStyle(
            fontSize: 16,
            letterSpacing: 0.1,
            fontWeight: FontWeight.w500,
            color: theme.colorScheme.onSecondary,
          ),
          prefixIcon: callbackPrefixIcon == null
              ? null
              : ClipRRect(
                  borderRadius:
                      borderRadius ?? BorderRadius.circular(15),
                  child: SizedBox(
                    width: 20,
                    child: TextButton(
                      onPressed: callbackPrefixIcon,
                      child: Icon(
                        prefixIcon,
                        color: prefixIconColor ??
                            theme.colorScheme.onSecondary,
                        size: prefixIconSize,
                      ),
                    ),
                  ),
                ),
          suffixIcon: isLoading == null
              ? ClipRRect(
                  borderRadius:
                      borderRadius ?? BorderRadius.circular(15),
                  child: callbackSuffixIcon == null
                      ? Container(
                          width: 1,
                        )
                      : SizedBox(
                          width: 20,
                          child: TextButton(
                            onPressed: callbackSuffixIcon,
                            child: Icon(
                              suffixIcon ?? CupertinoIcons.eye,
                              color: suffixIconColor ??
                                  theme.colorScheme.onSecondary,
                              size: suffixIconSize,
                            ),
                          ),
                        ),
                )
              : CupertinoActivityIndicator(color: theme.primaryColor),
          isDense: true,
          contentPadding: const EdgeInsets.all(0),
        ),
        //autofocus: true,
      ),
    );
  }
}
