import 'package:news_app/core/data/local_data/user_reposatory.dart';
import 'package:news_app/core/data/remote_data/auth/auth_api_config.dart';
import 'package:news_app/core/data/remote_data/auth/auth_api_servise.dart';
import 'package:news_app/core/model/user_model.dart';

class AuthRepository {
  AuthRepository(this.apiServise);
  final AuthApiServise apiServise;
  Future<UserModel?> login(String username, String password) async {
    final response = await apiServise.post(
      AuthApiConfig.login,
      AuthApiConfig.authBaseUrl,

      body: {"username": username, "password": password, "expiresInMins": 30},
    );
    UserModel model = UserModel.fromAuthResponse(response, username);

    await _saveUser(model);
    return model;
  }

  Future<void> _saveUser(UserModel model) async {
    await UserRepository().saveUser(model);
  }
}
