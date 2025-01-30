import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myapp/features/cart/ui/cart.dart';
import 'package:myapp/features/home/bloc/home_bloc.dart';
import 'package:myapp/features/home/models/home_product_data_model.dart';
import 'package:myapp/features/home/ui/product_tile_widget.dart';
import 'package:myapp/features/image_banner/image_banner.dart';
import 'package:myapp/features/wishlist/ui/wishlist.dart';
import 'package:myapp/resources/colors.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeBloc homeBloc = HomeBloc();
  final TextEditingController _searchController = TextEditingController();
  List<ProductDataModel> _filteredProducts = [];
  final List<Map<String, String>> imagesList = [
    {
      'imageUrl': 'assets/images/img1.png',
      'text1': 'First Image - Title',
      'text2': 'First Image - Description',
    },
    {
      'imageUrl': 'assets/images/image1.png',
      'text1': 'Second Image - Title',
      'text2': 'Second Image - Description',
    },
    {
      'imageUrl': 'assets/images/image1.png',
      'text1': 'Third Image - Title',
      'text2': 'Third Image - Description',
    },
    {
      'imageUrl': 'assets/images/image1.png',
      'text1': 'Third1 Image - Title',
      'text2': 'Third1 Image - Description',
    },
    // Add more items as needed
  ];
  @override
  void initState() {
    super.initState();
    homeBloc.add(HomeInitialEvent());
    // _searchController.addListener(_filterProducts);
  }

  // void _filterProducts() {
  //   setState(() {
  //     _filteredProducts = homeBloc.state.products.where((product) {
  //       final query = _searchController.text.toLowerCase();
  //       return product.name.toLowerCase().contains(query);
  //     }).toList();
  //   });
  // }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Widget customRow(String boldText, String seeAll) {
    return SizedBox(
      width: 364,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            boldText,
            style: const TextStyle(
                fontFamily: 'Open Sans',
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.black),
          ),
          Text(
            seeAll,
            style: const TextStyle(
                fontFamily: 'Roboto',
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.colorPrimary),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is HomeNavigateToCartPageActionState) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Cart()),
          );
        } else if (state is HomeNavigateToWishlistPageActionState) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Wishlist()),
          );
        } else if (state is HomeProductItemCartedActionState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Item Carted')),
          );
        } else if (state is HomeProductItemWishlistedActionState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Item Wishlisted')),
          );
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case HomeLoadedSuccessState:
            final successState = state as HomeLoadedSuccessState;
            if (_filteredProducts.isEmpty) {
              _filteredProducts = successState.products;
            }
            return Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  centerTitle: true,
                  title: SizedBox(
                    height: 100,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SvgPicture.asset('assets/icons/search.svg',
                            width: 30, height: 30),
                        const Text(
                          'Home',
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Open Sans',
                              fontWeight: FontWeight.w700,
                              fontSize: 20),
                        ),
                        Image.asset('assets/images/notification.png',
                            width: 24, height: 24)
                      ],
                    ),
                  ),
                  // actions: [
                  //   IconButton(
                  //     onPressed: () {
                  //       homeBloc.add(HomeWishlistButtonNavigateEvent());
                  //     },
                  //     icon: const Icon(Icons.favorite_border),
                  //   ),
                  //   IconButton(
                  //     onPressed: () {
                  //       homeBloc.add(HomeCartButtonNavigateEvent());
                  //     },
                  //     icon: const Icon(Icons.shopping_bag_outlined),
                  //   ),
                  // ],
                ),
                body: SingleChildScrollView(
                  child: Column(children: [
                    CustomCarousel(imageList: imagesList),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        customRow(
                          'Top of week',
                          "see all",
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 250,
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: ProductListWidget(
                            homeBloc: homeBloc,
                            products: _filteredProducts,
                          ),
                        ),
                        customRow(
                          'Best Vendors',
                          "see all",
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 80,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20), // Add padding to ListView
                            children: <Widget>[
                              Container(
                                width: 80,
                                height: 80,
                                margin: const EdgeInsets.only(
                                    right: 20), // Add margin between items
                                child: Center(
                                  child: Image.asset(
                                    'assets/images/vendor1.png',
                                    width: 70,
                                    height: 70,
                                  ),
                                ),
                              ),
                              Container(
                                width: 80,
                                height: 80,
                                margin: const EdgeInsets.only(
                                    right: 20), // Add margin between items
                                child: Center(
                                  child: Image.asset(
                                    'assets/images/vendor2.png',
                                    width: 70,
                                    height: 70,
                                  ),
                                ),
                              ),
                              Container(
                                width: 80,
                                height: 80,
                                margin: const EdgeInsets.only(
                                    right: 20), // Add margin between items
                                child: Center(
                                  child: Image.asset(
                                    'assets/images/vendor3.png',
                                    width: 70,
                                    height: 70,
                                  ),
                                ),
                              ),
                              Container(
                                width: 80,
                                height: 80,
                                margin: const EdgeInsets.only(
                                    right: 20), // Add margin between items
                                child: Center(
                                  child: Image.asset(
                                    'assets/images/vendor4.png',
                                    width: 70,
                                    height: 70,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    customRow(
                      'Authors',
                      "see all",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height:
                          250,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20), 
                        children: <Widget>[
                          Container(
                            width: 130,
                            margin: const EdgeInsets.only(
                                right: 20), // Spacing between items
                            child: Column(
                              mainAxisSize:
                                  MainAxisSize.min, // Prevent overflow
                              crossAxisAlignment:
                                  CrossAxisAlignment.center, // Center items
                              children: [
                                Image.asset(
                                  'assets/images/author1.png',
                                  height: 102,
                                ),
                                const SizedBox(
                                    height: 10), // Space between image and text
                                const Text(
                                  "John Freeman",
                                  style: TextStyle(
                                    fontFamily: "Roboto Medium",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    fontStyle: FontStyle.normal,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 5), // Space between texts
                                const Text(
                                  "Writer",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 130,
                            margin: const EdgeInsets.only(
                                right: 20), 
                            child: Column(
                              mainAxisSize:
                                  MainAxisSize.min,
                              crossAxisAlignment:
                                  CrossAxisAlignment.center, 
                              children: [
                                Image.asset(
                                  'assets/images/author2.png',
                                  height: 102,
                                ),
                                const SizedBox(
                                    height: 10), // Space between image and text
                                const Text(
                                  "Tess Gunty",
                                  style: TextStyle(
                                    fontFamily: "Roboto Medium",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    fontStyle: FontStyle.normal,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 5), // Space between texts
                                const Text(
                                  "Novelist",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        Container(
                            width: 130,
                            margin: const EdgeInsets.only(
                                right: 20), // Spacing between items
                            child: Column(
                              mainAxisSize:
                                  MainAxisSize.min, // Prevent overflow
                              crossAxisAlignment:
                                  CrossAxisAlignment.center, // Center items
                              children: [
                                Image.asset(
                                  'assets/images/author3.png',
                                  height: 102,
                                ),
                                const SizedBox(
                                    height: 10), // Space between image and text
                                const Text(
                                  "Richard Perston",
                                  style: TextStyle(
                                    fontFamily: "Roboto Medium",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    fontStyle: FontStyle.normal,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 5), // Space between texts
                                const Text(
                                  "Writer",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                       // Add more items if needed
                        ],
                      ),
                    ),
                  ]),
                ));
          case HomeErrorState:
            return const Scaffold(
              body: Center(child: Text('Error')),
            );
          default:
            return const SizedBox();
        }
      },
    );
  }
}
