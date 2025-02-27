import 'package:double_v_partners/app/app.dart';
import 'package:double_v_partners/app/utils/constants/path_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  Future.value(await WidgetsFlutterBinding.ensureInitialized());

  await dotenv.load(fileName: PathConstants.environmentPath);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.white,
    statusBarBrightness: Brightness.dark,
    statusBarIconBrightness: Brightness.dark,
  ));
  runApp(const MainApp());
}
