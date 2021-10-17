import 'package:flutter/material.dart';
import 'app_colors.dart';

const buttonTextStyle =
    TextStyle(fontSize: 16, fontFamily: 'Roboto', fontWeight: FontWeight.w600);

final buttonStyle = OutlinedButton.styleFrom(
    padding: EdgeInsets.zero,
    primary: AppColors.primary,
    backgroundColor: AppColors.buttonBg);

class DialogButton extends StatelessWidget {
  const DialogButton({Key? key, required this.onPressed, required this.label})
      : super(key: key);
  final VoidCallback? onPressed;
  final String label;
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        child: Text(label, style: buttonTextStyle),
        style: buttonStyle,
        onPressed: onPressed);
  }
}
