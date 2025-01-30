import 'package:flutter/material.dart';
import 'package:myapp/features/auth/ui/login.dart';
import 'package:myapp/resources/colors.dart';
import 'package:myapp/widgets/app_button.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Map<String, dynamic>> cartItems = [
    {
      'name': 'The Da Vinci Code',
      'price': 19.00,
      'quantity': 1,
      'image': 'assets/images/book1.png'
    },
    {
      'name': 'Carrie Fisher',
      'price': 25.00,
      'quantity': 1,
      'image': 'assets/images/book2.png'
    },
    {
      'name': 'Bright Young',
      'price': 15.00,
      'quantity': 1,
      'image': 'assets/images/book3.png'
    },
  ];

  double get subtotal => cartItems.fold(
      0, (sum, item) => sum + (item['price'] * item['quantity']));

  void updateQuantity(int index, int change) {
    setState(() {
      cartItems[index]['quantity'] += change;
      if (cartItems[index]['quantity'] <= 0) {
        cartItems.removeAt(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "My Bag",
          style: TextStyle(
              color: AppColors.black,
              fontFamily: 'Open Sans',
              fontSize: 20,
              fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 400,
              child: Expanded(
                child: ListView.separated(
                  itemCount: cartItems.length,
                  separatorBuilder: (context, index) => const Divider(
                    color: Color.fromARGB(255, 218, 212, 212),
                  ),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(cartItems[index]['image'],
                              width: 50, height: 50),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  cartItems[index]['name'],
                                  style: const TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height:10),
                                Container(
                                  width: 120,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      color: AppColors.lightBlueBackgroundColor,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      IconButton(
                                        icon: Image.asset(
                                          'assets/images/minus_color.png',
                                          height: 25,
                                        ),
                                        onPressed: () =>
                                            updateQuantity(index, -1),
                                      ),
                                      Text(
                                        "${cartItems[index]['quantity']}",
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                      IconButton(
                                        icon: Image.asset(
                                          'assets/images/plus.png',
                                          height: 25,
                                        ),
                                        onPressed: () => updateQuantity(index, 1),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            
                          ),
                          
                          Column(
                            children: [
                              Text(
                                "\$${(cartItems[index]['price'] * cartItems[index]['quantity']).toStringAsFixed(2)}",
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.colorPrimary),
                              ),
                              TextButton(
                                onPressed: () => updateQuantity(
                                    index, -cartItems[index]['quantity']),
                                child: const Text("Remove",
                                    style: TextStyle(color: Colors.red)),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            const Divider(
              color: Color.fromARGB(255, 218, 212, 212),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  for (var item in cartItems) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(item['name'],
                            style: const TextStyle(fontSize: 16)),
                        Text(
                          "\$${(item['price'] * item['quantity']).toStringAsFixed(2)}",
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    const Divider(
                      color: Color.fromARGB(255, 218, 212, 212),
                    ),
                  ],
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Subtotal",
                         style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Roboto',
                          )),
                      Text("\$${subtotal.toStringAsFixed(2)}",
                         style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Roboto',
                          )),
                    ],
                  ),
                  const Divider(
                    color: Color.fromARGB(255, 218, 212, 212),
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("Shipping",
                         style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Roboto',
                          )),
                      Text("\$2",
                         style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Roboto',
                          )),
                    ],
                  ),
                  const Divider(
                    color: Color.fromARGB(255, 218, 212, 212),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Total payment",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Roboto',
                          )),
                      Text("\$${(subtotal + 2).toStringAsFixed(2)}",
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.colorPrimary)),
                    ],
                  ),
                 
                  const SizedBox(height: 20),
                  AppButton(
                    borderRadius: 48,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()));
                    },
                    text: 'Pay Now',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
