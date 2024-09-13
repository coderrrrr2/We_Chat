import 'package:flutter/material.dart';
import 'package:practice_chat_app/shared/utils/app_color.dart';

class AppText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final Locale? locale;
  final bool? softWrap;
  final TextOverflow? overflow;
  final double? textScaleFactor;
  final int? maxLines;
  final String? semanticsLabel;
  final TextWidthBasis? textWidthBasis;
  final TextHeightBehavior? textHeightBehavior;
  final StrutStyle? strutStyle;

  const AppText({
    super.key,
    required this.text,
    this.style,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
    this.strutStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style,
      textAlign: textAlign,
      textDirection: textDirection,
      locale: locale,
      softWrap: softWrap,
      overflow: overflow,
      // textScaleFactor: textScaleFactor,
      maxLines: maxLines,
      semanticsLabel: semanticsLabel,
      textWidthBasis: textWidthBasis,
      textHeightBehavior: textHeightBehavior,
      strutStyle: strutStyle,
    );
  }
}

class LeadingText extends StatelessWidget {
  final String text;
  const LeadingText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
          fontSize: 27, fontWeight: FontWeight.bold, color: Colors.black),
    );
  }
}

class TrailingText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontSize;
  const TrailingText(
      {super.key, required this.text, this.color, this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            text,
            style: TextStyle(
                fontSize: fontSize ?? 17,
                fontWeight: FontWeight.bold,
                color: color ?? lightGrey),
          ),
        ),
      ],
    );
  }
}

class ClickableText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final Widget? content;
  final Color? color;
  final VoidCallback? onTap;
  final bool centered;

  const ClickableText({
    super.key,
    this.content,
    this.color,
    this.text = "",
    this.style,
    this.onTap,
    this.centered = false, // Default value is false
  });

  @override
  Widget build(BuildContext context) {
    Widget textWidget = content ??
        Text(
          text,
          style: style ?? TextStyle(color: color ?? orangeColor),
        );

    return GestureDetector(
      onTap: onTap,
      child: centered ? Center(child: textWidget) : textWidget,
    );
  }
}

class CenteredText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final VoidCallback? onTap;

  const CenteredText({
    super.key,
    required this.text,
    this.style,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: style,
        ),
      ),
    );
  }
}
