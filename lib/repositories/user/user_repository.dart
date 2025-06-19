import 'package:feedify/app/app_data.dart';
import 'package:feedify/repositories/user/models/user.dart';

class UserRepository {
  static Future<User> getSelfInfo() async {
    final response = await AppData.getDioWithToken().get(
      "${AppData.serverUrl}users/me",
    );
    User user = User.fromJson(response.data);
    return user;
  }
}
