import 'package:feedify/app/app_data.dart';
import 'package:feedify/repositories/auth/models/auth.dart';
import 'package:feedify/repositories/auth/models/auth_status.dart';
import 'package:feedify/repositories/auth/models/login.dart';
import 'package:feedify/repositories/auth/models/register.dart';

class AuthRepository {
  static Future<Auth> register(Register register) async {
    final response = await AppData.dio.post(
      "${AppData.serverUrl}auth/signup",
      data: register.toJson(),
    );
    final auth = Auth.fromJson(response.data);
    return auth;
  }

  static Future<Auth> login(Login login) async {
    final response = await AppData.dio.post(
      "${AppData.serverUrl}auth/login",
      data: login.toJson(),
    );
    final auth = Auth.fromJson(response.data);
    return auth;
  }

  static Future<AuthStatus> validate(Auth auth) async {
    final response = await AppData.dio.post(
      "${AppData.serverUrl}auth/validate",
      data: auth.toJson(),
    );
    final authStatus = AuthStatus.fromJson(response.data);
    return authStatus;
  }
}
