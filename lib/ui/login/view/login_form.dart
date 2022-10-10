import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';
import 'package:ish_top/ui/login/cubit/login_cubit.dart';
import 'package:ish_top/ui/widgets/active_button.dart';
import 'package:ish_top/utils/color.dart';
import 'package:ish_top/utils/constants.dart';
import 'package:ish_top/utils/my_utils.dart';
import 'package:ish_top/utils/style.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Authentication Failure'),
              ),
            );
        }
      },
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TITLE
            Text(
              "Ish Top",
              style: MyTextStyle.sfProSemibold.copyWith(fontSize: 24, color: MyColors.C_356899),
            ),
            Text(
              "Welcome Back 👋",
              style: MyTextStyle.sfProSemibold.copyWith(fontSize: 26, color: MyColors.C_0D0D26),
            ),
            Text(
              "Let’s log in. Apply to jobs!",
              style: MyTextStyle.sfProRegular.copyWith(fontSize: 15, color: MyColors.C_95969D),
            ),
            const SizedBox(height: 25),

            _EmailInput(),
            const SizedBox(height: 8),

            _PasswordInput(),
            const SizedBox(height: 8),

            _LoginButton(),
            const SizedBox(height: 8),

            _ForgotPassword(),
            const SizedBox(height: 4),

            // OR CONTINUE WITH
            Row(
              children: [
                const Expanded(child: Divider(thickness: 1, endIndent: 10)),
                Text(
                  'Or continue with',
                  style: MyTextStyle.sfProLight.copyWith(color: MyColors.C_95969D),
                ),
                const Expanded(child: Divider(thickness: 1, indent: 10)),
              ],
            ),
            const SizedBox(height: 15),

            // APPLE GOOGLE FACEBOOK
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  key: const Key('loginForm_appleLogin_raisedButton'),
                  backgroundColor: MyColors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                  child: const Icon(
                    FontAwesomeIcons.apple,
                    color: Colors.black,
                    size: 32,
                  ),
                  onPressed: () => MyUtils.getMyToast(message: 'Kod yozilmagan'),
                ),
                const SizedBox(width: 25),
                _GoogleLoginButton(),
                const SizedBox(width: 25),
                FloatingActionButton(
                  key: const Key('loginForm_facebookLogin_raisedButton'),
                  backgroundColor: MyColors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                  child: const Icon(
                    FontAwesomeIcons.facebook,
                    size: 32,
                    color: Colors.blue,
                  ),
                  onPressed: () => MyUtils.getMyToast(message: 'Kod yozilmagan'),
                ),
              ],
            ),
            const SizedBox(height: 20),

            Center(child: _SignUpButton()),
          ],
        ),
      ),
    );
  }
}

class _ForgotPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: TextButton(
        key: const Key('forgotPasswordtextButton'),
        onPressed: () {
          MyUtils.getMyToast(message: "Hali forgot password page yozilmagan");
        },
        child: Text(
          'Forgot Password?',
          style: MyTextStyle.sfProRegular.copyWith(color: MyColors.C_356899, fontSize: 18),
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_emailInput_textField'),
          style: MyTextStyle.sfProRegular.copyWith(color: MyColors.C_0D0D26, fontSize: 16),
          onChanged: (email) => context.read<LoginCubit>().emailChanged(email),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.email_outlined,
                color: state.email.pure
                    ? MyColors.C_95969D.withOpacity(0.7)
                    : state.email.invalid
                        ? Colors.red.withOpacity(0.8)
                        : MyColors.C_0D0D26.withOpacity(0.7)),
            hintText: 'E-mail',
            hintStyle: MyTextStyle.sfProMedium.copyWith(
              fontSize: 16,
              color: state.email.invalid ? Colors.red.withOpacity(0.8) : MyColors.C_95969D.withOpacity(0.7),
            ),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: MyColors.C_0D0D26.withOpacity(0.7))),
            enabledBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: !state.email.pure ? MyColors.C_0D0D26.withOpacity(0.7) : MyColors.C_95969D.withOpacity(0.7))),
            errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.red.withOpacity(0.7))),
            focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.red.withOpacity(0.7))),
            helperText: '',
            errorText: state.email.invalid ? 'Invalid email' : null,
            errorStyle: MyTextStyle.sfProRegular.copyWith(
              color: Colors.red.withOpacity(0.8),
            ),
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isVisibility = true;
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return StatefulBuilder(
          builder: (context, setState) => TextField(
            key: const Key('loginForm_passwordInput_textField'),
            onChanged: (password) => context.read<LoginCubit>().passwordChanged(password),
            obscureText: isVisibility,
            decoration: InputDecoration(
              suffixIcon: GestureDetector(
                onTap: () {
                  isVisibility = !isVisibility;
                  setState(() {});
                },
                child: Icon(
                  isVisibility ? Icons.visibility : Icons.visibility_off,
                  color: state.password.pure ? MyColors.C_95969D.withOpacity(0.7) : MyColors.C_0D0D26.withOpacity(0.7),
                ),
              ),
              prefixIcon: Icon(Icons.vpn_key_rounded,
                  color: state.password.pure
                      ? MyColors.C_95969D.withOpacity(0.7)
                      : state.password.invalid
                          ? Colors.red.withOpacity(0.8)
                          : MyColors.C_0D0D26.withOpacity(0.7)),
              hintText: 'Password',
              hintStyle: MyTextStyle.sfProMedium.copyWith(
                fontSize: 16,
                color: state.password.invalid ? Colors.red.withOpacity(0.8) : MyColors.C_95969D.withOpacity(0.7),
              ),
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: MyColors.C_0D0D26.withOpacity(0.7))),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: !state.password.pure ? MyColors.C_0D0D26.withOpacity(0.7) : MyColors.C_95969D.withOpacity(0.7))),
              errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.red.withOpacity(0.7))),
              focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.red.withOpacity(0.7))),
              helperText: '',
              errorText: state.password.invalid ? 'Invalid password' : null,
              errorStyle: MyTextStyle.sfProRegular.copyWith(
                color: Colors.red.withOpacity(0.8),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const Center(child: CircularProgressIndicator())
            : ActiveButton(
                key: const Key('loginForm_continue_raisedButton'),
                buttonText: 'Log in',
                onPressed: () async{
                  state.status.isValidated ? await context.read<LoginCubit>().logInWithCredentials() : MyUtils.getMyToast(message: "Please field currently!");
                },
              );
        // TODO O'ZINING ESKI BUTTONI AGAR ISHLAMASA QAYTARAMIZ
        // ElevatedButton(
        //          key: const Key('loginForm_continue_raisedButton'),
        //         style: ElevatedButton.styleFrom(
        //           shape: RoundedRectangleBorder(
        //             borderRadius: BorderRadius.circular(30),
        //           ),
        //           backgroundColor: const Color(0xFFFFD600),
        //         ),
        //         onPressed: state.status.isValidated ? () => context.read<LoginCubit>().logInWithCredentials() : null,
        //         child: const Text('LOGIN'),
        //       );
      },
    );
  }
}

class _GoogleLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.white,
      key: const Key('loginForm_googleLogin_raisedButton'),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      child: const Icon(
        FontAwesomeIcons.google,
        color: Colors.red,
      ),
      onPressed: () => context.read<LoginCubit>().logInWithGoogle(),
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, signUpPage);
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(text: "Haven’t an account? ", style: MyTextStyle.sfProRegular.copyWith(color: MyColors.C_95969D)),
            TextSpan(
              text: "Register",
              style: MyTextStyle.sfProSemibold.copyWith(color: MyColors.C_356899),
            ),
          ],
        ),
      ),
    );
  }
}
