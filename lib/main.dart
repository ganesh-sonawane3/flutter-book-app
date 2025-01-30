import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myapp/features/auth/intro.dart';
import 'package:myapp/features/cart/ui/cart.dart';
import 'package:myapp/features/home/ui/home.dart';
import 'package:myapp/features/homePage.dart';
import 'package:myapp/features/wishlist/ui/wishlist.dart';
import 'package:myapp/resources/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: AppColors.primaryColor),
      home: const SplashScreen(), // Set SplashScreen as home
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(builder: (context) => const LoginSignup()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:AppColors.primaryColor,
      body: Center(
        child: SizedBox(
          width: 271,
          height: 44.5,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            SvgPicture.asset(
              'assets/icons/book.svg', // Use your splash logo or image here
              width: 33.12, // Adjust the width
              height: 28.39, // Adjust the height
            ),
            const Text(
              'BOOK HEAVEN',
              style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 31.25,
                  color: Colors.white,
                  fontWeight: FontWeight.w700),
            )
          ]),
        ),
      ),
    );
  }
}
