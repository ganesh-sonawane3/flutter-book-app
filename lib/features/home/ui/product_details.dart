import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myapp/features/cart/shopping_bag.dart';
import 'package:myapp/features/home/models/home_product_data_model.dart';
import 'package:myapp/features/home/ui/review_button.dart';
import 'package:myapp/resources/colors.dart';
import 'package:myapp/widgets/app_button.dart';

class ProductDetailsWidget extends StatefulWidget {
  final ProductDataModel productDataModel;
  final int initialQuantity;
  final double initialPrice;

  const ProductDetailsWidget({
    super.key,
    required this.productDataModel,
    required this.initialQuantity,
    required this.initialPrice,
  });

  @override
  _ProductDetailsWidgetState createState() => _ProductDetailsWidgetState();
}

class _ProductDetailsWidgetState extends State<ProductDetailsWidget> {
  late int quantity;
  late double totalPrice;
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    quantity = widget.initialQuantity;
    totalPrice = widget.initialPrice;
  }

  void incrementQuantity() {
    setState(() {
      quantity++;
      totalPrice = widget.productDataModel.price * quantity;
    });
  }

  void decrementQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
        totalPrice = widget.productDataModel.price * quantity;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Expanded(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 60,
              height: 5,
              decoration: BoxDecoration(
                color: AppColors.disabled,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 10),
            Image.asset(
              widget.productDataModel.imageUrl,
              height: MediaQuery.of(context).size.height * 0.3,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.productDataModel.name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      isFavorite = !isFavorite;
                    });
                  },
                  icon: SvgPicture.asset(
                    "assets/icons/favorite.svg",
                    color: isFavorite
                        ? AppColors.colorPrimary
                        : AppColors.disabled,
                    height: 25,
                    width: 20,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    height: 80,
                    child: Image.asset(
                      'assets/images/vendor3.png',
                      width: 80,
                      height: 80,
                    )),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              widget.productDataModel.moreInfo,
              maxLines: 3,
              
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
              letterSpacing: 0.9
              ),
              textAlign: TextAlign.start,
              
            ),
            const SizedBox(height: 20),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Review",
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        StarWidget(),
                        StarWidget(),
                        StarWidget(),
                        StarWidget(),
                        StarWidget(),
                        Text("(4.0)",
                            style: TextStyle(
                                fontFamily: "Roboto",
                                fontSize: 14,
                                fontWeight: FontWeight.w800))
                      ]),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 250,
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Minus Button with Circular White Background
                      Container(
                        height: 40,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(
                              255, 241, 236, 236), // White background
                          shape: BoxShape.circle, // Circular shape
                        ),
                        child: IconButton(
                          onPressed: decrementQuantity,
                          icon: const Icon(Icons.remove),
                          color: AppColors.disabled, // Icon color
                        ),
                      ),
                      const SizedBox(width: 16), // Space between elements
                      // Quantity Text
                      Text(
                        quantity.toString(),
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 16),
                      Container(
                        height: 40,
                        decoration: const BoxDecoration(
                          color: AppColors.colorPrimary,
                          shape: BoxShape.circle, // Circular shape
                        ),
                        child: IconButton(
                          onPressed: incrementQuantity,
                          icon: const Icon(
                            Icons.add,
                            color: Colors.white,
                            weight: 2,
                          ),
                          color: Colors.black, // Icon color
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "\$${totalPrice.toStringAsFixed(2)}",
                        style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: AppColors.colorPrimary),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 170,
                  height: 50,
                  child: AppButton(
                   
                    borderRadius: 48,
                    onPressed: () {
   Navigator.push(
  context,
  MaterialPageRoute(builder: (context) =>const CartPage()),
);
                    },
                    text: 'Add to bag',
                  ),
                ),
                 SizedBox(
                  width: 150,
                  height: 50,
                  child: AppButton(
                   bgColor: Colors.white,
                    borderRadius: 48,
                    onPressed: () {},
                    text: 'Buy now',
                    textColor: AppColors.colorPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
