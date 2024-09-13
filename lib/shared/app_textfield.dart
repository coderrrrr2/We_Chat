import 'package:flutter/material.dart';
import 'package:practice_chat_app/shared/shared_widgets.dart';
import 'package:practice_chat_app/shared/utils/app_color.dart';

class AppTextField extends StatelessWidget {
  final EdgeInsetsGeometry padding;
  final int? maxLines;
  final bool isGradientBorder;
  final BorderRadius? borderRadius;
  final String? header;
  final TextStyle? hintStyle;
  final double headerFontSize;
  final String hintText;
  final Widget? suffixWidget;
  final Widget? prefixWidget;
  final FontWeight? headerFontWeight;
  final Color? fillColor;
  final Color? borderColor;
  final bool isReadOnly;
  final VoidCallback? ontap;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final TextEditingController controller;

  const AppTextField({
    super.key,
    this.isGradientBorder = false,
    this.maxLines,
    this.borderColor,
    this.padding = const EdgeInsets.symmetric(vertical: 10.0),
    this.header,
    this.borderRadius,
    this.keyboardType,
    this.headerFontSize = 17.0,
    this.hintStyle,
    this.hintText = '',
    this.suffixWidget,
    this.prefixWidget,
    this.headerFontWeight,
    this.fillColor,
    this.isReadOnly = false,
    this.ontap,
    this.validator,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (header != null) ...[
            Text(
              header!,
              style: TextStyle(
                fontSize: headerFontSize,
                fontWeight: headerFontWeight ?? FontWeight.w600,
              ),
            ),
            addHeight(13),
          ],
          TextFormField(
            onTap: ontap,
            readOnly: isReadOnly,
            validator: validator,
            maxLines: maxLines,
            minLines: null,
            keyboardType: keyboardType,
            style: const TextStyle(color: blackColor),
            decoration: InputDecoration(
              hintText: hintText,
              prefixIcon: prefixWidget,
              suffixIcon: suffixWidget,
              hintStyle:
                  hintStyle ?? const TextStyle(color: lightGrey, fontSize: 18),
              fillColor: fillColor ?? whiteColor, // Example default color
              filled: true,

              border: OutlineInputBorder(
                borderSide:
                    BorderSide(color: borderColor ?? extraLightGreyColor),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            controller: controller,
          ),
        ],
      ),
    );
  }
}
