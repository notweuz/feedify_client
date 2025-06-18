import 'package:feedify/app/app_data.dart';
import 'package:feedify/repositories/auth/models/auth_dto.dart';
import 'package:feedify/repositories/auth/models/auth_status_dto.dart';
import 'package:feedify/repositories/auth/models/login_dto.dart';
import 'package:feedify/repositories/auth/models/register_dto.dart';

class AuthRepository {
  static Future<AuthDTO> register(RegisterDTO registerDTO) async {
    final response = await AppData.dio.post(
      "${AppData.serverUrl}auth/signup",
      data: registerDTO.toJson(),
    );
    final authDTO = AuthDTO.fromJson(response.data);
    return authDTO;
  }

  static Future<AuthDTO> login(LoginDTO loginDTO) async {
    final response = await AppData.dio.post(
      "${AppData.serverUrl}auth/login",
      data: loginDTO.toJson(),
    );
    final authDTO = AuthDTO.fromJson(response.data);
    return authDTO;
  }

  static Future<AuthStatusDTO> validate(AuthDTO authDTO) async {
    final response = await AppData.dio.post(
      "${AppData.serverUrl}auth/validate",
      data: authDTO.toJson(),
    );
    final authStatusDTO = AuthStatusDTO.fromJson(response.data);
    return authStatusDTO;
  }
}
