import 'package:flutter/material.dart';
import 'package:golly_express_app/utils/constants.dart';

class PrimaryButton extends StatefulWidget {
  final String buttonText;
  final VoidCallback? onPressed;
  final ButtonStyle? style;

  PrimaryButton(
      {Key? key, required this.buttonText, this.onPressed, ButtonStyle? style})
      : style = style ??
            ElevatedButton.styleFrom(
                backgroundColor: GollyColors.greenShade1100,
                disabledBackgroundColor: GollyColors.greyShade300,
                disabledForegroundColor: GollyColors.greyShade100,
                foregroundColor: Colors.white,
                textStyle: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Dm Sans'),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                minimumSize: const Size.fromHeight(50.0)),
        super(key: key);

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: widget.style,
        child: Text(widget.buttonText),
      ),
    );
  }
}

class SecondaryButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback? onPressed;
  final ButtonStyle? style;

  SecondaryButton(
      {Key? key, required this.buttonText, this.onPressed, ButtonStyle? style})
      : style = style ??
            ElevatedButton.styleFrom(
                backgroundColor: GollyColors.greenShade1100,
                disabledBackgroundColor: GollyColors.greyShade300,
                disabledForegroundColor: GollyColors.greyShade100,
                foregroundColor: Colors.white,
                textStyle: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Dm Sans'),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                minimumSize: const Size.fromHeight(50.0)),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ElevatedButton(
        onPressed: onPressed,
        style: style,
        child: Text(buttonText),
      ),
    );
  }
}
