import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/features/auth/login/bloc/login_bloc.dart';
import 'package:myapp/features/auth/login/bloc/login_event.dart';
import 'package:myapp/features/auth/login/bloc/login_state.dart';
import 'package:myapp/features/homePage.dart';
import 'package:myapp/repository/user_repository.dart';
import 'package:myapp/resources/colors.dart';
import 'package:myapp/widgets/app_button.dart';
import 'package:myapp/widgets/app_input.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(userRepository: UserRepository()),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const MyHome()),
                (Route<dynamic> route) => false,
              );
            } else if (state is LoginFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Welcome Back 👋',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                        fontFamily: 'Open Sans',
                      ),
                    ),
                    const Text(
                      'Sign in to your account',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Roboto',
                        color: Color(0xFFA6A6A6),
                      ),
                    ),
                    const SizedBox(height: 40),
                    AppInput(
                      controller: emailController,
                      labelText: 'Email',
                      hintText: 'Your email',
                    ),
                    const SizedBox(height: 20),
                    AppInput(
                      encrypt: true,
                      controller: passwordController,
                      labelText: 'Password',
                      hintText: 'Your Password',
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Checkbox(
                          value: isChecked,
                          onChanged: (bool? newValue) {
                            setState(() {
                              isChecked = newValue ?? false;
                            });
                          },
                          activeColor: AppColors.colorPrimary,
                        ),
                        const Text(
                          'Remember Me',
                          style: TextStyle(
                            color: AppColors.colorPrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    AppButton(
                      borderRadius: 48,
                      onPressed: () {
                        final email = emailController.text.trim();
                        final password = passwordController.text.trim();

                        if (email.isNotEmpty && password.isNotEmpty) {
                          context.read<LoginBloc>().add(
                                LoginButtonPressed(email: email, password: password),
                              );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Please fill in all fields")),
                          );
                        }
                      },
                      text: state is LoginLoading ? 'Logging in...' : 'Login',
                     
                    ),
                    const SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account?",
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Color(0xFFA6A6A6),
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Register',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: AppColors.colorPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
