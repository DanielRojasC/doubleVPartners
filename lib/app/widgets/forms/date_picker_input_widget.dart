import 'package:double_v_partners/app/utils/styles.dart';
import 'package:double_v_partners/app/utils/utils.dart';

import 'package:flutter/material.dart';

class DatePickerInputWidget extends StatefulWidget {
  final TextEditingController controller;
  final FormFieldValidator validator;
  final String inputTitle, hintText;
  final EdgeInsets padding;
  final DateTime? initialDate;

  const DatePickerInputWidget({
    required this.controller,
    required this.validator,
    required this.inputTitle,
    required this.hintText,
    this.padding = EdgeInsets.zero,
    this.initialDate,
    super.key,
  });

  @override
  State<DatePickerInputWidget> createState() => _DatePickerInputWidgetState();
}

class _DatePickerInputWidgetState extends State<DatePickerInputWidget> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> _onClickPicker() async {
    DateTime? pickedDate = await showDatePicker(
      helpText: "Seleccionar fecha",
      confirmText: "Aceptar",
      cancelText: "Cancelar",
      context: context,
      initialDate: widget.initialDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: primaryColor,
              onPrimary: Colors.white,
              onSurface: secondaryColor,
              surface: Colors.white,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: accentColor,
                // textStyle: AppTextStyles.basicAccentColorTextStyle(16),
                padding: const EdgeInsets.only(bottom: 20),
                alignment: Alignment.center,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      String formattedDate = Utils.formatDate(pickedDate);

      widget.controller.text = formattedDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 2.0, bottom: 5),
            child: Text(
              widget.inputTitle,
              style: inputLabelTextStyle(),
            ),
          ),
          GestureDetector(
            onTap: _onClickPicker,
            child: TextFormField(
              enabled: false,
              controller: widget.controller,
              autofocus: false,
              cursorColor: accentColor,
              style: inputTextStyle(),
              textAlignVertical: TextAlignVertical.center,
              decoration: InputStyles.basicInputDecoration(widget.hintText),
              validator: widget.validator,
            ),
          ),
        ],
      ),
    );
  }
}
