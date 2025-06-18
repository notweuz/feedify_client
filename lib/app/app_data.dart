import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppData {
  static String serverUrl = dotenv.env['SERVER_URL']!;
  static String theme = "ThemeMode.system";
  static String? userToken;
  static Dio dio = Dio(BaseOptions(baseUrl: serverUrl));

  static Future<void> saveData() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString("userToken", AppData.userToken!);
    await prefs.setString("theme", AppData.theme);
  }

  static Future<void> readData() async {
    final prefs = await SharedPreferences.getInstance();

    AppData.userToken = prefs.getString("userToken");
    AppData.theme = prefs.getString("theme") ?? "ThemeMode.system";
  }

  static Dio getDioWithToken() {
    final dioWithToken = dio;
    dioWithToken.options.headers["Authorization"] = "Bearer ${AppData.userToken}";

    return dioWithToken;
  }
}