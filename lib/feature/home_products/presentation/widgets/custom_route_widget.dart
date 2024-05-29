import 'package:ecommerce_motion_flutter/feature/carts_feature/presentation/pages/carts_pages.dart';
import 'package:ecommerce_motion_flutter/feature/home_products/presentation/pages/products_page.dart';
import 'package:flutter/material.dart';

Route createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const CartsPage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

Route createRouteBack() {
  return PageRouteBuilder(
    
    pageBuilder: (context, animation, secondaryAnimation) =>
        const ProductsPage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset.zero;
      const end = Offset(0.0, 1.0);
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
