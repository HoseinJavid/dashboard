part of 'login_bloc.dart';

class LoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginLoading extends LoginState {}

class LoginInitial extends LoginState {}

class LoginSuccess extends LoginState {
  final String phoneNumber;

  LoginSuccess({required this.phoneNumber});
}

class LoginError extends LoginState {
  final String errorMessage;

  LoginError({required this.errorMessage});
}

class LoginFildInvalid extends LoginState {
  final String? errorMessage;

  LoginFildInvalid({required this.errorMessage});
}

class LoginFildValid extends LoginState {}
