import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';
import 'package:ish_top/app/app.dart';
import 'package:ish_top/app/bloc/app_bloc.dart';
import 'package:ish_top/cubits/user/user_cubit.dart';
import 'package:ish_top/data/models/users/user_model.dart';
import 'package:ish_top/ui/sign_up/sign_up.dart';
import 'package:ish_top/utils/style.dart';
import 'package:ish_top/utils/color.dart';

import '../../../utils/my_utils.dart';
import '../../widgets/active_button.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          Navigator.of(context).pop();
        } else if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text(state.errorMessage ?? 'Sign Up Failure')),
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
              "Registration 👍",
              style: MyTextStyle.sfProSemibold.copyWith(fontSize: 26, color: MyColors.C_0D0D26),
            ),
            Text(
              "Let’s Register. Apply to jobs!",
              style: MyTextStyle.sfProRegular.copyWith(fontSize: 15, color: MyColors.C_95969D),
            ),
            const SizedBox(height: 25),
            _UserFullNameInput(),
            const SizedBox(height: 15),

            _EmailInput(),
            const SizedBox(height: 15),

            _PasswordInput(),
            const SizedBox(height: 15),

            _ConfirmPasswordInput(),
            const SizedBox(height: 20),

            _SignUpButton(),
            const SizedBox(height: 12),

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

            Center(child: _SignInButton())
          ],
        ),
      ),
    );
  }
}

class _UserFullNameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.userName != current.userName,
      builder: (context, state) {
        return TextField(
          key: const Key('signUpForm_userNameInput_textField'),
          style: MyTextStyle.sfProRegular.copyWith(color: MyColors.C_0D0D26, fontSize: 16),
          onChanged: (email) => context.read<SignUpCubit>().userNameChanged(email),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.person,
                color: state.userName.isEmpty
                    ? MyColors.C_95969D.withOpacity(0.7)
                    : state.userName.length < 2 && state.userName.isNotEmpty
                        ? Colors.red.withOpacity(0.8)
                        : MyColors.C_0D0D26.withOpacity(0.7)),
            hintText: 'Full Name',
            hintStyle: MyTextStyle.sfProMedium.copyWith(
              fontSize: 16,
              color: state.userName.length < 2 && state.userName.isNotEmpty ? Colors.red.withOpacity(0.8) : MyColors.C_95969D.withOpacity(0.7),
            ),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: MyColors.C_0D0D26.withOpacity(0.7))),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: state.userName.isNotEmpty ? MyColors.C_0D0D26.withOpacity(0.7) : MyColors.C_95969D.withOpacity(0.7))),
            errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.red.withOpacity(0.7))),
            focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.red.withOpacity(0.7))),
            errorText: state.userName.length < 2 && state.userName.isNotEmpty ? 'Invalid Name' : null,
            errorStyle: MyTextStyle.sfProRegular.copyWith(
              color: Colors.red.withOpacity(0.8),
            ),
          ),
        );
      },
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          key: const Key('signUpForm_emailInput_textField'),
          style: MyTextStyle.sfProRegular.copyWith(color: MyColors.C_0D0D26, fontSize: 16),
          onChanged: (email) => context.read<SignUpCubit>().emailChanged(email),
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
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return StatefulBuilder(
          builder: (context, setState) => TextField(
            key: const Key('signUpForm_passwordInput_textField'),
            onChanged: (password) => context.read<SignUpCubit>().passwordChanged(password),
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
              // helperText: '',
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

class _ConfirmPasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isVisibility = true;
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.password != current.password || previous.confirmedPassword != current.confirmedPassword,
      builder: (context, state) {

        return StatefulBuilder(
          builder: (context, setState) => TextField(
            key: const Key('signUpForm_confirmedPasswordInput_textField'),
            onChanged: (confirmPassword) => context.read<SignUpCubit>().confirmedPasswordChanged(confirmPassword),
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
              hintText: 'Confirm Password',

              hintStyle: MyTextStyle.sfProMedium.copyWith(
                fontSize: 16,
                color: state.password.invalid ? Colors.red.withOpacity(0.8) : MyColors.C_95969D.withOpacity(0.7),
              ),
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: MyColors.C_0D0D26.withOpacity(0.7))),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: !state.password.pure ? MyColors.C_0D0D26.withOpacity(0.7) : MyColors.C_95969D.withOpacity(0.7))),
              errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.red.withOpacity(0.7))),
              focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.red.withOpacity(0.7))),
              // helperText: '',
              errorText: state.confirmedPassword.invalid ? 'Passwords do not match' : null,
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

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const Center(child: CircularProgressIndicator())
            : ActiveButton(
                key: const Key('signUpForm_continue_raisedButton'),
                onPressed: state.status.isValidated && state.userName.length >= 2
                    ? () async {
                        await context.read<SignUpCubit>().signUpFormSubmitted();
                        final user = BlocProvider.of<AppBloc>(context).state.user;
                        print("USER ID:${user.id}");
                        if (user.id.isNotEmpty) {
                          UserModel userModel = UserModel(
                            imageUrl: 'https://www.kindpng.com/picc/m/153-1530388_mario-head-png-png-download-people-profile-pic.png',
                            createdAt: DateTime.now(),
                            fullName: state.userName,
                            phoneNumber: '',
                            userId: user.id,
                          );
                          BlocProvider.of<UserCubit>(context).postUser(userModel);
                        }
                      }
                    : () {
                        MyUtils.getMyToast(message: 'Fill all fields');
                      },
                buttonText: 'Register',
              );
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
      onPressed: () => context.read<SignUpCubit>().logInWithGoogle(),
    );
  }
}

class _SignInButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(text: "Have an account? ", style: MyTextStyle.sfProRegular.copyWith(color: MyColors.C_95969D)),
            TextSpan(
              text: "Log in",
              style: MyTextStyle.sfProSemibold.copyWith(color: MyColors.C_356899),
            ),
          ],
        ),
      ),
    );
  }
}
