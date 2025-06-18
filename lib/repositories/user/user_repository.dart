import 'package:feedify/app/app_data.dart';
import 'package:feedify/repositories/user/models/user_dto.dart';

class UserRepository {
  static Future<UserDTO> getSelfInfo() async {
    final response = await AppData.getDioWithToken().get(
      "${AppData.serverUrl}users/me",
    );
    UserDTO userDTO = UserDTO.fromJson(response.data);
    return userDTO;
  }
}
