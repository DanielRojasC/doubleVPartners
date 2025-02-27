import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:toastification/toastification.dart';
import 'package:uuid/uuid.dart';

class Utils {
  static DateFormat dateFormat = DateFormat("dd/MM/yyyy");

  static String formatDate(DateTime pickedDate) =>
      dateFormat.format(pickedDate);

  static String generateId() {
    return Uuid().v4().substring(0, 8);
  }

  static void showToast(BuildContext context, String message) =>
      toastification.show(
        context: context,
        title: Text(message),
        autoCloseDuration: const Duration(seconds: 5),
        alignment: Alignment.bottomCenter,
      );
}
