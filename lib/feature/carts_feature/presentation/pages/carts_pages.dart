import 'package:ecommerce_motion_flutter/feature/carts_feature/presentation/providers/carts_provider.dart';
import 'package:ecommerce_motion_flutter/feature/carts_feature/presentation/widgets/carts_item_widget.dart';
import 'package:ecommerce_motion_flutter/feature/detail_products/presentation/widgets/custom_app_bar.dart';
import 'package:ecommerce_motion_flutter/feature/home_products/presentation/pages/products_page.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class CartsPage extends StatelessWidget {
  static const routeName = '/carts-page';
  const CartsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProduct = context.watch<CartsProvider>();
    final getCartProduct = cartProduct.shopCart;

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Your Carts ',
      ),
      body: SafeArea(
        bottom: false,
        child: Container(
          color: const Color.fromARGB(38, 174, 174, 177),
          height: MediaQuery.of(context).size.height,
          child: getCartProduct.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/empty-box.png'),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'No Order',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 20,
                        ),
                      ),
                      const Text(
                        'Your cart is empty, let\'s shop',
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        borderRadius: BorderRadius.circular(50),
                        onTap: () => Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ProductsPage(),
                          ),
                          (route) => false,
                        ),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 20,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 4,
                                // blurStyle: BlurStyle.outer,
                                color: Color.fromARGB(136, 147, 206, 255),
                                offset: Offset(4, 8),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: const Text(
                            'Let\'s go shopping',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              : ListView.builder(
                  itemBuilder: (context, i) {
                    return CartsItemWidget(
                      getCartProduct[i].id,
                      getCartProduct[i].title,
                      getCartProduct[i].image,
                      getCartProduct[i].price,
                      getCartProduct[i].quantity,
                      getCartProduct[i].description,
                      getCartProduct[i].category,
                    );
                  },
                  itemCount: getCartProduct.length,
                ),
        ),
      ),
      bottomNavigationBar: getCartProduct.isNotEmpty
          ? Container(
              padding: const EdgeInsets.all(20),
              color: const Color.fromARGB(255, 114, 114, 114),
              height: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        '\$${cartProduct.getTotalPrice().toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  GestureDetector(
                    onTap: () {

                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 50,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadiusDirectional.all(
                          Radius.circular(50),
                        ),
                      ),
                      child: const Text(
                        'Checkout',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          : null,
    );
  }
}
