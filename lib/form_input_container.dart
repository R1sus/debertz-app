import 'package:flutter/material.dart';
import 'app_colors.dart';

class FormInputContianer extends StatelessWidget {
  const FormInputContianer({Key? key, required this.child}) : super(key: key);
  final StatelessWidget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: AppColors.inputBorder, width: 1))),
      child: child,
    );
  }
}
