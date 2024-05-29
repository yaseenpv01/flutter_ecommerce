import 'package:ecommerce_motion_flutter/feature/home_products/presentation/pages/search_page.dart';
import 'package:ecommerce_motion_flutter/feature/home_products/presentation/widgets/custom_route_widget.dart';
import 'package:ecommerce_motion_flutter/feature/home_products/presentation/widgets/products_grid_widget.dart';
import 'package:ecommerce_motion_flutter/feature/home_products/presentation/widgets/selected_category_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce_motion_flutter/feature/home_products/presentation/provider/products_provider.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});
  static const routeName = '/home-products';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF292526),
        leadingWidth: 180,
        leading: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello, Welcome - Danat Fz LLC TASK',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                ),
              ),
              Text(
                'Muhammed Yaseen',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(createRoute());
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 20),
              child: Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: FutureBuilder<void>(
        future: Provider.of<ProductsProvider>(context, listen: false)
            .eitherFailureOrTemplate(),
        builder: (context, snapshot) {
          var products = context.watch<ProductsProvider>().productsEntity;
          var failure = context.watch<ProductsProvider>().failure;

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError || failure != null) {
            return const Center(
              // child: Text('Error: ${snapshot.error ?? failure.toString()}'),
              child: Text('Server Error'),
            );
          } else {
            return ListView(
              shrinkWrap: true,
              children: [
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const SearchPage(),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      height: 48,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.search, color: Colors.grey),
                          SizedBox(width: 8),
                          Text('Search', style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ),
                  ),
                ),
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        height: 150,
                        decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    )
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    'Category',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                ),
                const CategorySelector(),
                ProductsGridWidget(
                  products: products,
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
