import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myapp/features/cart/ui/cart.dart';
import 'package:myapp/features/home/ui/home.dart';
import 'package:myapp/features/wishlist/ui/wishlist.dart';
import 'package:myapp/resources/colors.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
   
    const Home(),
    const Wishlist(),
    const Cart(),
    const Cart(),
    const Wishlist(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: Center(
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: const [
           
          ],
        ),
        margin: const EdgeInsets.only( top: 10),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          items: <BottomNavigationBarItem>[
            
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/home.svg',color: _selectedIndex == 0?AppColors.colorPrimary:AppColors.disabled,),
              label: 'Home',
              
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/category.svg',color: _selectedIndex == 1?AppColors.colorPrimary:AppColors.disabled,),
           
              label: 'Category',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/cart.svg',color: _selectedIndex == 2?AppColors.colorPrimary:AppColors.disabled,),
           
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/profile.svg',color: _selectedIndex == 3?AppColors.colorPrimary:AppColors.disabled,),
           
              label: 'profile',
            ),
           
          ],
        ),
      ),
    );
  }
}
