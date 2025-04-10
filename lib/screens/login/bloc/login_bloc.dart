import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dashboard/utils/phone_validator.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    on<PhoneChanged>(_onPhoneChanged);
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  FutureOr<void> _onPhoneChanged(
    PhoneChanged event,
    Emitter<LoginState> emit,
  ) {
    final isValid = PhoneValidator.isValid(event.phone);

    emit(state.copyWith(
        phone: event.phone,
        status: isValid ? LoginStatus.valid : LoginStatus.invalid,
        errorMessage: isValid ? null : 'شماره موبایل نامعتبر است'));
  }

  FutureOr<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    if (!PhoneValidator.isValid(state.phone)) {
      //is not valid
      emit(state.copyWith(status: LoginStatus.failure));
      return;
    }
    emit(state.copyWith(status: LoginStatus.loading));
    await Future.delayed(const Duration(seconds: 1));
    emit(state.copyWith(status: LoginStatus.success));
  }
}
