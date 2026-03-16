import 'package:hive_ce_flutter/adapters.dart';
import 'package:news_app/core/constants/constants.dart';
import 'package:news_app/core/model/user_mdel.dart';

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

  void init() async {
    await Hive.initFlutter();
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(UseerModelAdapter());
    }

    _userBox = await Hive.openBox(Constants.userBox);
  }

  Future<void> saveUser(UseerModel user) async {
    userBox.put(Constants.currentUser, user);
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
      return "No account found please register first";
    }
    if (user.email != email || user.password != password) {
      return 'Incorrect email or password';
    }
    return null;
  }

  Future<String?> singUp({
    required String email,
    required String password,
    required String userName,
  }) async {
    final user = getUser();
    if (user != null) {
      return 'User already exists please login' ;
    }
    final newUser = UseerModel(email: email, password: password , name: userName);
    await saveUser(newUser);
    return null;
  }
}
