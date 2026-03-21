import 'package:flutter_bloc/flutter_bloc.dart';
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
}
