import 'package:equatable/equatable.dart';
import 'package:news_app/core/enums/request_status_enums.dart';
import 'package:news_app/core/model/user_model.dart';

class AuthState extends Equatable {
  const AuthState({
    this.status = RequestStatusEnum.initial,
    this.errorMessage,
    this.userModel,
  });

  final RequestStatusEnum status;
  final String? errorMessage;
  final UserModel? userModel;

  AuthState copyWith({
    RequestStatusEnum? status,
    String? errorMessage,
    UserModel? userModel,
  }) {
    return AuthState(
      status: status ?? this.status,
      errorMessage: errorMessage,
      userModel: userModel ?? this.userModel,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage, userModel];
}
