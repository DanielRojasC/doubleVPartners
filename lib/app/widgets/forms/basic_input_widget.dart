import 'package:double_v_partners/app/utils/styles.dart';
import 'package:flutter/material.dart';

class BasicTextInputWidget extends StatelessWidget {
  final TextEditingController controller;
  final FormFieldValidator validator;
  final String inputTitle, hintText;
  final EdgeInsets padding;
  final int? maxLines;
  final TextInputType inputType;

  const BasicTextInputWidget({
    required this.controller,
    required this.validator,
    required this.inputTitle,
    required this.hintText,
    this.padding = EdgeInsets.zero,
    this.inputType = TextInputType.text,
    this.maxLines,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 2.0, bottom: 5),
            child: Text(
              inputTitle,
              style: inputLabelTextStyle(),
            ),
          ),
          TextFormField(
            textCapitalization: TextCapitalization.words,
            controller: controller,
            keyboardType: inputType,
            autofocus: false,
            maxLines: maxLines,
            cursorColor: accentColor,
            style: inputTextStyle(),
            textAlignVertical: TextAlignVertical.center,
            decoration: InputStyles.basicInputDecoration(hintText),
            validator: validator,
          ),
        ],
      ),
    );
  }
}
