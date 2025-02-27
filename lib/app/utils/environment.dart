import 'package:flutter_dotenv/flutter_dotenv.dart';

final class Environment {
  static final String departmentsUrl = _get("DEPARTMENTS_URL");
  static final String apiKey = _get("API_KEY");

  static String _get(String key) {
    return dotenv.get(key, fallback: "");
  }
}
