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
        return MouseRegion(
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          child: SizedBox(
            width: widthField.toDouble(),
            height: state is LoginFildInvalid
                ? heightField.toDouble() + 20
                : heightField.toDouble(),
            child: TextField(
              textDirection: TextDirection.ltr,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'شماره موبایل',
                errorText:
                    state is LoginFildInvalid ? state.errorMessage : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide(
                    color: state is LoginFildInvalid
                        ? Colors.red
                        : themeData!.colorScheme.secondary,
                    width: 1,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide(
                    color: state is LoginFildInvalid
                        ? Colors.red
                        : themeData!.colorScheme.secondary,
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
                    color: state is LoginFildInvalid
                        ? Colors.red
                        : themeData!.colorScheme.primary,
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
        textDirection: TextDirection.ltr,
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
        if (state is LoginSuccess) {
          context.go('/dashboard?phone=${state.phoneNumber}');
        }
      },
      builder: (context, state) {
        return SizedBox(
          width: 335,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              if (state is LoginInitial || state is LoginFildInvalid) {
                return;
              } else {
                return context.read<LoginBloc>().add(LoginSubmitted());
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  state is LoginFildInvalid || state is LoginInitial
                      ? Colors.grey
                      : themeData!.colorScheme.primary,
            ),
            child: state is LoginLoading || state is LoginSuccess
                ? const CircularProgressIndicator(color: Colors.white,)
                : const Text('ورود'),
          ),
        );
      },
    );
  }
}
