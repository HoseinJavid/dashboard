import 'package:dashboard/utils/phone_validator.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    late String phoneNumber;
    on<LoginEvent>(
      (event, emit) async {
        emit(LoginLoading());
        if (event is PhoneChanged) {
          phoneNumber = event.phone;
          if (PhoneValidator.isValid(event.phone)) {
            emit(LoginFildValid());
          } else {
            if (phoneNumber != '') {
              emit(LoginFildInvalid(errorMessage: 'شماره موبایل معتبر نیست'));
            } else {
              emit(LoginInitial());
            }
          }
        } else if (event is LoginSubmitted) {
          // api call and navigate to dashboard screen
          // if auth is faill emit a error state
          emit(LoginLoading());
          await Future.delayed(const Duration(seconds: 2));
          emit(LoginSuccess(phoneNumber: phoneNumber));
        }
      },
    );
  }
}
