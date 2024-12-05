import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/animations.dart';
import '../../../../core/constants.dart';
import '../../../../core/get_it.dart';
import '../../../../core/routing.dart';
import '../controllers/login_cubit.dart';
import '../controllers/login_state.dart';
import '../widgets/app_banner_widget.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/rounded_corner_colored_button_widget.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const Center(child: CircularProgressIndicator()),
          );
        } else if (state is LoginFailure) {
          Navigator.of(context).pop();

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        } else if (state is LoginSuccess) {
          Navigator.of(context).pop();
          Navigator.of(context).pushReplacement(
            AppRouter.mainScreen.slideFromRight(),
          );
        }
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const AppBannerWidget(),

              /// Future Update
              // GoogleAuthenticationButtonWidget(
              //   title: "Sign in with Google",
              //   onPressed: () {
              //     // Google Sign in logic
              //   },
              // ),
              // const SizedBox(height: 16),
              // const Text('or'),
              const SizedBox(height: 16),
              Form(
                key: loginFormKey,
                child: Column(
                  children: [
                    CustomTextField(
                      controller: emailController,
                      label: "Email",
                      regexValidation: const RegexValidation(
                        validationError: "Wrong Email Format",
                        validationValue: emailRegex,
                      ),
                      validationKey: loginFormKey,
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      controller: passwordController,
                      label: "Password",
                      suffixIcon: const Icon(Icons.visibility),
                      obscureText: true,
                      validationKey: loginFormKey,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'No account?',
                    style: TextStyle(color: Colors.black),
                  ),
                  const SizedBox(width: 16),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        AppRouter.registerScreen.slideFromLeft(),
                      );
                    },
                    child: const Text(
                      'Register',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              RoundedCornerColoredButtonWidget(
                title: "Sign In",
                onPressed: () {
                  if (loginFormKey.currentState!.validate()) {
                    getIt<LoginCubit>().loginUser(emailController.text, passwordController.text);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
