import 'package:ecommerce_motion_flutter/feature/carts_feature/presentation/pages/carts_pages.dart';
import 'package:ecommerce_motion_flutter/feature/carts_feature/presentation/providers/carts_provider.dart';
import 'package:ecommerce_motion_flutter/feature/detail_products/presentation/pages/detail_products_page.dart';
import 'package:ecommerce_motion_flutter/feature/detail_products/presentation/provider/detail_products_provider.dart';
import 'package:ecommerce_motion_flutter/feature/home_products/presentation/pages/products_page.dart';
import 'package:ecommerce_motion_flutter/feature/home_products/presentation/provider/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => DetailProductsProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProductsProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartsProvider(),
        )
      ],
      child: MaterialApp(
        home: const ProductsPage(),
        debugShowCheckedModeBanner: false,
        routes: {
          DetailProductsPage.routeName: (context) => const DetailProductsPage(),
          CartsPage.routeName: (context) => const CartsPage(),
          ProductsPage.routeName: (context) => const ProductsPage(),
        },
        theme: ThemeData(
          pageTransitionsTheme: const PageTransitionsTheme(
            builders: {
              TargetPlatform.android: CupertinoPageTransitionsBuilder(),
              TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            },
          ),
        ),
      ),
    );
  }
}
