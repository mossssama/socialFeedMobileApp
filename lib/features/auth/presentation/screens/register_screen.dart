import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_feed/core/animations.dart';

import '../../../../core/constants.dart';
import '../../../../core/get_it.dart';
import '../../../../core/routing.dart';
import '../controllers/register_cubit.dart';
import '../controllers/register_state.dart';
import '../widgets/app_banner_widget.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/rounded_corner_colored_button_widget.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const Center(child: CircularProgressIndicator()),
          );
        } else if (state is RegisterFailure) {
          Navigator.of(context).pop();

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        } else if (state is RegisterSuccess) {
          Navigator.of(context).pop();
          Navigator.of(context).pushReplacementNamed(AppRouter.loginScreen);
        }
      },
      child: Scaffold(
        body: SizedBox(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const AppBannerWidget(),

                    /// Future Update
                    // GoogleAuthenticationButtonWidget(
                    //   title: "Sign up with Google",
                    //   onPressed: () {
                    //     // Google sign up logic
                    //   },
                    // ),
                    // const SizedBox(height: 16),
                    // const Text('or'),
                    const SizedBox(height: 16),
                    Form(
                      key: registerFormKey,
                      child: Column(
                        children: [
                          CustomTextField(
                            controller: emailController,
                            label: "Email",
                            regexValidation: const RegexValidation(
                              validationError: "Wrong Email Format",
                              validationValue: emailRegex,
                            ),
                            validationKey: registerFormKey,
                          ),
                          const SizedBox(height: 16),
                          CustomTextField(
                            controller: passwordController,
                            label: "Password",
                            suffixIcon: const Icon(Icons.visibility),
                            obscureText: true,
                            validationKey: registerFormKey,
                          ),
                          const SizedBox(height: 16),
                          CustomTextField(
                            controller: confirmPasswordController,
                            label: 'Confirm Password',
                            suffixIcon: const Icon(Icons.visibility),
                            obscureText: true,
                            listenedController: passwordController,
                            validationKey: registerFormKey,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'By signing up, you agree to the Terms of Service and Privacy Policy, including Cookie Use.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Have account?',
                          style: TextStyle(color: Colors.black),
                        ),
                        const SizedBox(width: 16),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushReplacement(
                              AppRouter.loginScreen.slideFromRight(),
                            );
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    RoundedCornerColoredButtonWidget(
                      title: "Create account",
                      onPressed: () {
                        if (registerFormKey.currentState!.validate()) {
                          getIt<RegisterCubit>().registerUser(emailController.text, passwordController.text);
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
