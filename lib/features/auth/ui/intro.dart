import 'package:flutter/material.dart';
import 'package:myapp/features/auth/ui/login.dart';
import 'package:myapp/features/auth/ui/signup.dart';
import 'package:myapp/resources/colors.dart';
import 'package:myapp/widgets/app_button.dart';

class LoginSignup extends StatefulWidget {
  const LoginSignup({super.key});

  @override
  State<LoginSignup> createState() => _LoginSignupState();
}

class _LoginSignupState extends State<LoginSignup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('skip'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Regular text

            const SizedBox(height: 16), // Space between widgets

            // Image
            Image.asset(
              'assets/images/login.png',
              height: 320,
              width: 320,
            ), // Replace with your image asset

            const SizedBox(height: 16),

            // Bold text
            const Center(
              child: SizedBox(
                width: 251,
                child: Text(
                  'Your Bookish Soulmate Awaits',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Open sans'),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Small paragraph text
        const  Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: const Center(
              child: Text(
                'Let us be your guide to the perfect read. Discover books tailored to your tastes for a truly rewarding experience.',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Roboto',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                ),
                maxLines: 3, // Limits the text to 3 lines
                overflow: TextOverflow.ellipsis, // Adds "..." if the text overflows
              ),
            ),
          ),
            const SizedBox(height: 32),

            AppButton(
                onPressed:(){
                 Navigator.push(
  context,
  MaterialPageRoute(builder: (context) =>const SignUpPage()));  },
                text:'Register',
              ),
                const SizedBox(height: 32),

            AppButton(
              bgColor:AppColors. buttonBackGroundColor,
              textColor: AppColors.colorPrimary,
              borderColor: AppColors. buttonBackGroundColor,
                onPressed:(){
                  Navigator.push(
  context,
  MaterialPageRoute(builder: (context) =>const LoginPage()),
);
                },
                text:'Login',
              ),
          ],
        ),
      ),
    );
  }
}
