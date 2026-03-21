import 'package:news_app/core/data/local_data/user_reposatory.dart';
import 'package:news_app/core/data/remote_data/api_config.dart';
import 'package:news_app/core/data/remote_data/api_servise.dart';
import 'package:news_app/core/model/user_model.dart';

class AuthRepository {
  AuthRepository(this.apiServise);
  final ApiService apiServise;
  Future<UserModel?> login(String username, String password) async {
    final response = await apiServise.post(
      ApiConfig.login,
      ApiConfig.authBaseUrl,

      body: {"username": username, "password": password, "expiresInMins": 30},
    );
    UserModel model = UserModel.fromAuthResponse(response, username);

    await _saveUser(model);
    print(model);
    return model;
  }

  Future<void> _saveUser(UserModel model) async {
    await UserRepository().saveUser(model);
  }
}
