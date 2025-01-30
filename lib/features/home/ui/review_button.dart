import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myapp/resources/colors.dart';

class StarWidget extends StatefulWidget {
  const StarWidget({super.key});

  @override
  State<StarWidget> createState() => _StarWidgetState();
}

class _StarWidgetState extends State<StarWidget> {
  bool isSelected=false;
  @override
  Widget build(BuildContext context) {
    return  Container(
      height:40,
      
      child: IconButton(
        icon: SvgPicture.asset('assets/icons/star.svg',color: isSelected==true? AppColors.yellow:AppColors.black),onPressed:() {
      if(isSelected==false){
        setState(() {
          isSelected=true;
        });
        
      }else{
        setState(() {
          isSelected=false;
        });
      }
      },),
    );
  }
}