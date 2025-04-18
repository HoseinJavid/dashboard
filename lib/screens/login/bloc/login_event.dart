part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class PhoneChanged extends LoginEvent {
  final String phone;
  const PhoneChanged(this.phone);
}

class PasswordChanged extends LoginEvent {
  final String password;

  const PasswordChanged({required this.password});
}

class LoginSubmitted extends LoginEvent {}
