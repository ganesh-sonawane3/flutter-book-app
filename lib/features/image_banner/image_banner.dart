import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:myapp/resources/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CustomCarousel extends StatefulWidget {
  final List<Map<String, String>> imageList;

  const CustomCarousel({super.key, required this.imageList});

  @override
  _CustomCarouselState createState() => _CustomCarouselState();
}

class _CustomCarouselState extends State<CustomCarousel> {
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      
      children: [
        CarouselSlider.builder(
          itemCount: widget.imageList.length,
          itemBuilder: (context, index, realIndex) {
            final imageItem = widget.imageList[index];
            return Stack(
              children: [
                Container(
                  height: 146,
                  padding: EdgeInsets.all(10),
                  margin: const EdgeInsets.symmetric(horizontal: 8.0),
                  decoration: BoxDecoration(
                    
                    borderRadius: BorderRadius.circular(10),
                  
                    image: DecorationImage(
                      fit: BoxFit.contain,
                      image: AssetImage(imageItem['imageUrl']!),
                    ),
                  ),
                
                ),
          
                
              ],
            );
          },
          options: CarouselOptions(
            height: 162,
            viewportFraction: 1.0,
            onPageChanged: (index, reason) => setState(() {
              activeIndex = index;
            }),
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
          ),
        ),
        const SizedBox(height: 10.0),
        buildIndicator(),
      ],
    );
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: widget.imageList.length,
        effect: const ScrollingDotsEffect(
          dotHeight: 10,
          dotWidth: 10,
          activeDotColor:AppColors.colorPrimary,
          dotColor: Colors.grey,
        ),
      );
}
