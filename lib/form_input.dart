import 'package:debertz_app/dialog_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';

class DecimalTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final regEx = RegExp(r'[\d]+', caseSensitive: false, multiLine: false);
    String newString = regEx.stringMatch(newValue.text) ?? '';
    return newString == newValue.text ? newValue : oldValue;
  }
}

class DebertzFormInput extends StatelessWidget {
  const DebertzFormInput(
      {this.autofocus,
      required this.controller,
      required this.label,
      this.hintText,
      this.withBite = false,
      this.onBitePressed,
      Key? key})
      : super(key: key);
  final TextEditingController controller;
  final String? hintText;
  final String label;
  final bool? autofocus;
  final bool withBite;
  final VoidCallback? onBitePressed;

  Widget _renderBite() {
    return Center(
      child: SizedBox(
        width: 32,
        height: 32,
        child: DialogButton(onPressed: onBitePressed, label: 'B'),
      ),
    );
  }

  List<Widget> _renderChildren() {
    List<Widget> list = [
      Container(
        width: 80,
        margin: const EdgeInsets.only(bottom: 4),
        decoration: BoxDecoration(
            border: Border(
                right: BorderSide(color: AppColors.inputBorder, width: 1))),
        child: Center(
          child: Text(label,
              style: const TextStyle(fontSize: 16, color: Colors.black)),
        ),
      ),
      Expanded(
        child: TextFormField(
          autofocus: autofocus ?? false,
          keyboardType: TextInputType.number,
          controller: controller,
          inputFormatters: [
            DecimalTextInputFormatter(),
          ],
          decoration: InputDecoration(
              hintText: hintText,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(bottom: 16, left: 12)),
        ),
      ),
    ];
    if (withBite) {
      list.add(_renderBite());
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: _renderChildren(),
    );
  }
}
