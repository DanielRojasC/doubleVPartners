import 'package:double_v_partners/app/utils/styles.dart';
import 'package:flutter/material.dart';

class PrimaryButtonWidget extends StatelessWidget {
  final VoidCallback onClick;
  final String buttonText;
  final EdgeInsets padding;
  const PrimaryButtonWidget({
    super.key,
    required this.onClick,
    required this.buttonText,
    this.padding = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: SizedBox(
        width: deviceWidth(context) * 0.35,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            backgroundColor: lightBackground,
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
          ),
          onPressed: onClick,
          child: Text(
            buttonText,
            style: TextStyle(fontSize: 15),
          ),
        ),
      ),
    );
  }
}
