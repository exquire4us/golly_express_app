import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:golly_express_app/utils/constants.dart';

typedef OnTextChanged = void Function(String);
typedef TextValidator = String? Function(String?);
typedef OnEditComplete = void Function();

class GollyTextField extends StatefulWidget {
  final OnTextChanged onTextChanged;
  final bool obscureText;
  final String? hintText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextValidator? validator;
  final FocusNode? focusNode;
  final OnEditComplete? editComplete;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatter;

  const GollyTextField(
      {Key? key,
      required this.onTextChanged,
      required this.obscureText,
      this.hintText,
      this.keyboardType,
      this.textInputAction,
      this.validator,
      this.focusNode,
      this.editComplete,
      this.prefixIcon,
      this.suffixIcon,
      this.maxLength,
      this.inputFormatter})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _GollyTextFieldState();
}

class _GollyTextFieldState extends State<GollyTextField> {
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      widget.onTextChanged(controller.text);
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextFormField(
        inputFormatters: widget.inputFormatter,
        maxLength: widget.maxLength,
        focusNode: widget.focusNode,
        onEditingComplete: widget.editComplete,
        maxLines: 1,
        controller: controller,
        textInputAction: widget.textInputAction,
        style: const TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w400,
          fontFamily: GollyFonts.dmSans,
          color: GollyColors.blackShade100,
        ),
        decoration: InputDecoration(
          focusColor: GollyColors.greenShade1100,
          focusedBorder: const OutlineInputBorder(
              borderSide:
                  BorderSide(width: 2.0, color: GollyColors.greenShade1100),
              borderRadius: BorderRadius.all(Radius.circular(8)),
              gapPadding: 4.0),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: GollyColors.greyShade200),
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          hintText: widget.hintText,
          hintStyle: const TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w400,
              fontFamily: GollyFonts.dmSans,
              color: GollyColors.greyShade100,
              leadingDistribution: TextLeadingDistribution.even),
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.suffixIcon,
        ),
        obscureText: widget.obscureText,
        keyboardType: widget.keyboardType,
        validator: widget.validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
      ),
    );
  }
}
