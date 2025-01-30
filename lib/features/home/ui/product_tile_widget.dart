import 'package:flutter/material.dart';
import 'package:myapp/features/home/bloc/home_bloc.dart';
import 'package:myapp/features/home/models/home_product_data_model.dart';
import 'package:myapp/features/home/ui/product_details.dart';
import 'package:myapp/resources/colors.dart';

class ProductListWidget extends StatelessWidget {
  final List<ProductDataModel> products;
  final HomeBloc homeBloc;

  const ProductListWidget({
    super.key,
    required this.products,
    required this.homeBloc,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: products.length,
      itemBuilder: (context, index) {
        final productDataModel = products[index];
        return GestureDetector(
       onTap: () {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true, // Makes it full-screen if needed
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) => SizedBox(
      height: MediaQuery.of(context).size.height * 0.9, // Adjust height
      child: ProductDetailsWidget(
        productDataModel: productDataModel,
        initialQuantity: 1,
        initialPrice: productDataModel.price,
      ),
    ),
  );
},


          child: Container(
            width: 127.32,
            height: 198,
           margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
           
            // decoration: BoxDecoration(
            //   color: Colors.white,
            //   borderRadius: BorderRadius.circular(15),
            //   border: Border.all(
            //     color: Colors.grey.shade300,
            //     width: 2,
            //   ),
            // ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 127.32,
            height: 150,
            padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white70,
                    image: DecorationImage(
                      fit: BoxFit.contain,
                      image: AssetImage(productDataModel.imageUrl),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  productDataModel.name,
                  style: const TextStyle(
                     fontSize: 14, fontWeight: FontWeight.w500,fontFamily: 'Roboto'),
                ),
                Text(
                      "\$${productDataModel.price.toString()}",
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w500,fontFamily: 'Roboto',color: AppColors.colorPrimary),
                    ),
              //   Text(
              //     productDataModel.description,
              //     style: TextStyle(color: Colors.grey.shade600),
              //   ),
              //   const SizedBox(height: 10),
              //   Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Text(
              //         "\$${productDataModel.price.toString()}",
              //         style: const TextStyle(
              //             fontSize: 18, fontWeight: FontWeight.w700),
              //       ),
              //       Container(
              //         decoration: BoxDecoration(
              //           color: const Color.fromRGBO(83, 177, 117, 1),
              //           borderRadius: BorderRadius.circular(20),
              //         ),
              //         child: IconButton(
              //           onPressed: () {
              //             homeBloc.add(HomeProductCartButtonClickedEvent(
              //                 clickedProduct: productDataModel));
              //           },
              //           color: Colors.white,
              //           icon: const Icon(Icons.add, weight: 30),
              //         ),
              //       ),
              //     ],
              //   ),
               ],
            ),
          ),
        );
      },
    );
  }
}
