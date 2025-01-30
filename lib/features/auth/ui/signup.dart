import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/features/auth/signup/bloc/signup_bloc.dart';
import 'package:myapp/features/auth/signup/bloc/signup_event.dart';
import 'package:myapp/features/auth/signup/bloc/signup_state.dart';
import 'package:myapp/features/auth/ui/login.dart';
import 'package:myapp/repository/user_repository.dart';
import 'package:myapp/resources/colors.dart';
import 'package:myapp/widgets/app_button.dart';
import 'package:myapp/widgets/app_input.dart';
import 'package:myapp/widgets/custom_dropdown.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isChecked = false;
  String? selectedGender;
  String? selectedLanguage;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
     create: (context) => SignUpBloc(userRepository: UserRepository()),

      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: BlocConsumer<SignUpBloc, SignUpState>(
          listener: (context, state) {
            if (state is SignUpSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Signup Successful! Please login.")),
              );
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            } else if (state is SignUpFailure) {
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
                      'Register',
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24),
                    ),
                    const Text(
                      'Create account',
                      style: TextStyle(fontSize: 16, color: Color(0xFFA6A6A6)),
                    ),
                    const SizedBox(height: 40),
                    AppInput(
                      controller: nameController,
                      labelText: 'Name',
                      hintText: 'Your Name',
                    ),
                    const SizedBox(height: 20),
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
                          style: TextStyle(color: AppColors.colorPrimary, fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Gender"),
                        Row(
                          children: [
                            Radio<String>(
                              value: "Male",
                              groupValue: selectedGender,
                              activeColor: AppColors.colorPrimary,
                              onChanged: (value) => setState(() => selectedGender = value),
                            ),
                            const Text("Male"),
                            const SizedBox(width: 20),
                            Radio<String>(
                              value: "Female",
                              groupValue: selectedGender,
                              activeColor: AppColors.colorPrimary,
                              onChanged: (value) => setState(() => selectedGender = value),
                            ),
                            const Text("Female"),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    CustomDropdown(
                      labelText: 'Language',
                      items: const ["Hindi", "English", "Marathi"],
                      hint: "Select",
                      onChanged: (value) => setState(() => selectedLanguage = value),
                    ),
                    const SizedBox(height: 20),
                    AppButton(
                      borderRadius: 48,
                      onPressed: () {
                        final name = nameController.text.trim();
                        final email = emailController.text.trim();
                        final password = passwordController.text.trim();

                        if (name.isNotEmpty && email.isNotEmpty && password.isNotEmpty && selectedGender != null && selectedLanguage != null) {
                          context.read<SignUpBloc>().add(
                                SignUpButtonPressed(
                                  name: name,
                                  email: email,
                                  password: password,
                                  gender: selectedGender!,
                                  language: selectedLanguage!,
                                ),
                              );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Please fill in all fields")),
                          );
                        }
                      },
                      text: state is SignUpLoading ? 'Registering...' : 'Register',
                    
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Have an account?"),
                        TextButton(
                          onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage())),
                          child: const Text('Login', style: TextStyle(color: AppColors.colorPrimary)),
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
