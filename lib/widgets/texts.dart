import 'package:flutter/material.dart';

class TextTitleLarge extends StatelessWidget {
  final String text;
  final Color textColor;
  final TextAlign? textAlign;
  final double? fontSize;

  const TextTitleLarge(
      {Key? key,
      required this.text,
      required this.textColor,
      TextAlign? textAlign,
      double? fontSize})
      : textAlign = textAlign ?? TextAlign.center,
        fontSize = fontSize ?? 24,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: textColor,
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          fontFamily: 'Dm Sans'),
      textAlign: textAlign,
    );
  }
}

class TextDescription extends StatelessWidget {
  final String text;
  final Color textColor;
  final TextAlign? textAlign;
  final double? fontSize;

  const TextDescription(
      {Key? key,
      required this.text,
      required this.textColor,
      TextAlign? textAlign,
      double? fontSize})
      : textAlign = textAlign ?? TextAlign.center,
        fontSize = fontSize ?? 12,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: textColor,
        fontSize: fontSize,
        fontFamily: 'Dm Sans',
      ),
      textAlign: textAlign,
    );
  }
}
