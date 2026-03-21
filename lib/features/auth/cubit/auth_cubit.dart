import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/data/local_data/prefrances_maneger.dart';
import 'package:news_app/core/data/local_data/user_reposatory.dart';
import 'package:news_app/core/enums/request_status_enums.dart';
import 'package:news_app/core/model/user_model.dart';
import 'package:news_app/features/auth/repos/auth_repository.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepository) : super(AuthState());
  final AuthRepository authRepository;
  Future<void> login(String username, String password) async {
    try {
      emit(state.copyWith(status: RequestStatusEnum.loading, errorMessage: null));

      final UserModel? userModel = await authRepository.login(username, password);
      if (userModel != null) {
        emit(state.copyWith(status: RequestStatusEnum.loaded, userModel: userModel));
      }
    } catch (e) {
      emit(state.copyWith(status: RequestStatusEnum.error, errorMessage: e.toString()));
    }
  }

  void register({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(status: RequestStatusEnum.loading, errorMessage: null));

    await Future.delayed(const Duration(seconds: 3));

    final String? error = await UserRepository().signUp(
      name: name,
      email: email,
      password: password,
    );

    if (error != null) {
      emit(state.copyWith(status: RequestStatusEnum.error, errorMessage: error));
      return;
    }
    await PreferencesManager().setBool("is_logged_in", true);
    emit(state.copyWith(status: RequestStatusEnum.loaded, errorMessage: null));
  }
}
