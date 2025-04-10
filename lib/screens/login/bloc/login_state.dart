part of 'login_bloc.dart';

enum LoginStatus { initial, loading, success, failure, invalid, valid }

class LoginState extends Equatable {
  final String phone;
  final LoginStatus status;
  final String? errorMessage;

  const LoginState({
    this.phone = '',
    this.status = LoginStatus.initial,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [phone, status, errorMessage];

  LoginState copyWith({
    String? phone,
    LoginStatus? status,
    String? errorMessage,
  }) {
    return LoginState(
      phone: phone ?? this.phone,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
