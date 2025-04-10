import 'package:dashboard/screens/login/bloc/login_bloc.dart';
import 'package:dashboard/utils/phone_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

int widthField = 336;
int heightField = 57;
ThemeData? themeData;

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              children: [
                const Text(
                  'ورود',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 12,
                ),
                const Text(
                  '۳.۲۳.۰(۱۰۰۶۶۲)',
                  style: TextStyle(fontSize: 12, color: Color(0xffC1C7D0)),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text('لطفا شماره موبایل و رمزعبورخودراواردکنید',
                    style: TextStyle(fontSize: 16, color: Color(0xff5E6C84))),
                const SizedBox(
                  height: 32,
                ),
                _PhoneInput(),
                const SizedBox(height: 12),
                const _PasswordInput(),
                const Expanded(child: SizedBox()),
                const _LoginButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PhoneInput extends StatefulWidget {
  @override
  State<_PhoneInput> createState() => _PhoneInputState();
}

class _PhoneInputState extends State<_PhoneInput> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        final hasError = state.status == LoginStatus.invalid;
        final isValid = state.status == LoginStatus.valid;

        return MouseRegion(
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          child: SizedBox(
            width: widthField.toDouble(),
            height:
                hasError ? heightField.toDouble() + 20 : heightField.toDouble(),
            child: TextField(
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'شماره موبایل',
                errorText: hasError ? state.errorMessage : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide(
                    color: isValid
                        ? themeData!.colorScheme.secondary
                        : hasError
                            ? Colors.red
                            : Colors.grey,
                    width: 1,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide(
                    color: isValid
                        ? themeData!.colorScheme.secondary
                        : hasError
                            ? Colors.red
                            : Colors.grey,
                    width: _isHovered ? 2 : 1,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(
                    color: Colors.red,
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide(
                    color: isValid ? themeData!.primaryColor : Colors.red,
                    width: 2,
                  ),
                ),
                focusedErrorBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(14)),
                  borderSide: BorderSide(color: Colors.red, width: 2),
                ),
              ),
              onChanged: (value) =>
                  context.read<LoginBloc>().add(PhoneChanged(value)),
            ),
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widthField.toDouble(),
      height: heightField.toDouble(),
      child: const TextField(
        obscureText: true,
        decoration: InputDecoration(labelText: 'رمز عبور'),
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status == LoginStatus.success) {
          context.go('/dashboard?phone=${state.phone}');
        }
      },
      builder: (context, state) {
        final isValid = PhoneValidator.isValid(state.phone);
        return SizedBox(
          width: 335,
          height: 50,
          child: ElevatedButton(
            onPressed: state.status == LoginStatus.loading || !isValid
                ? null
                : () => context.read<LoginBloc>().add(LoginSubmitted()),
            style: ElevatedButton.styleFrom(
              disabledBackgroundColor:
                  state.status == LoginStatus.invalid ? Colors.grey : null,
            ),
            child: state.status == LoginStatus.loading
                ? const CircularProgressIndicator()
                : const Text('ورود'),
          ),
        );
      },
    );
  }
}
