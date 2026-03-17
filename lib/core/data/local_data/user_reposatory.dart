import 'package:hive_ce_flutter/adapters.dart';
import 'package:news_app/core/constants/constants.dart';
import 'package:news_app/core/model/user_model.dart';

class UserRepository {
  UserRepository._internal();
  static final UserRepository _instance = UserRepository._internal();
  factory UserRepository() => _instance;
  Box<UseerModel>? _userBox;
  Box<UseerModel> get userBox {
    if (_userBox == null) {
      throw Exception('User box is not initialized.');
    }
    return _userBox!;
  }

Future<void> init() async {
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(UseerModelAdapter());
  }
  _userBox = await Hive.openBox(Constants.userBox);
}
  Future<void> saveUser(UseerModel user) async {
    await userBox.put(Constants.currentUser, user);
  }

  UseerModel? getUser() => userBox.get(Constants.currentUser);
  void updateUser({
    String? name,
    String? email,
    String? password,
    String? countryName,
    String? countryCode,
    String? flagEmoji,
  }) async {
    final UseerModel? user = getUser();
    if (user != null) {
      final updatedUser = user.copyWith(
        name: name,
        email: email,
        password: password,
        countryName: countryName,
        countryCode: countryCode,
        flagEmoji: flagEmoji,
      );
      await saveUser(updatedUser);
    }
  }

  Future<void> delete() async {
    await userBox.delete(Constants.currentUser);
  }

  Future<void> clearAll() async {
    await userBox.clear();
  }

  String? login(String email, String password) {
    final user = getUser();

    if (user == null) {
      return "No Account Found Please Register First";
    }

    if (user.email != email || user.password != password) {
      return "Incorrect Email or Password";
    }
    return null;
  }

  Future<String?> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    final user = getUser();

    if (user != null) {
      return "User Already Exists Please Login";
    }

    final newUser = UseerModel(name: name, email: email, password: password);

    await saveUser(newUser);
    return null;
  }
}
