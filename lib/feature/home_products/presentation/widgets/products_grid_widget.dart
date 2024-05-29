import 'package:ecommerce_motion_flutter/feature/home_products/domain/entity/products_entity.dart';
import 'package:ecommerce_motion_flutter/feature/home_products/presentation/provider/products_provider.dart';
import 'package:ecommerce_motion_flutter/feature/home_products/presentation/widgets/card_product_widget.dart';
import 'package:ecommerce_motion_flutter/utils/string_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class ProductsGridWidget extends StatefulWidget {
  const ProductsGridWidget({super.key, required this.products});

  final List<ProductsEntity>? products;

  @override
  State<ProductsGridWidget> createState() => _ProductsGridWidgetState();
}

class _ProductsGridWidgetState extends State<ProductsGridWidget> {
  @override
  Widget build(BuildContext context) {
    final selectedCategory = context
        .watch<ProductsProvider>()
        .categories[context.watch<ProductsProvider>().selectedIndex];

    List<ProductsEntity> filteredProducts = [];
    final loadedProducts = context.watch<ProductsProvider>().productsEntity;

    if (loadedProducts != null) {
      if (selectedCategory == 'All Items') {
        filteredProducts = loadedProducts;
      } else {
        filteredProducts = loadedProducts.where((product) {
          final productCategory = product.category.toLowerCase();
          final selectedCategoryLower = selectedCategory.toLowerCase();

          if (selectedCategoryLower == 'women\'s clothing') {
            return productCategory == 'women\'s clothing';
          } else if (selectedCategoryLower == 'men\'s clothing') {
            return productCategory == 'men\'s clothing';
          } else if (selectedCategoryLower == 'jewelery') {
            return productCategory == 'jewelery';
          } else if (selectedCategoryLower == 'electronics') {
            return productCategory == 'electronics';
          }
          return false;
        }).toList();
      }
    }

    return MasonryGridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      mainAxisSpacing: 20,
      crossAxisSpacing: 20,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: filteredProducts.length,
      gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemBuilder: (context, i) {
        final product = filteredProducts[i];
        final capitalizedCategory =
            capitalize(product.category.toString().split('.').last);

        return CardProductsWidget(
          product: product,
          capitalizedCategory: capitalizedCategory,
        );
      },
    );
  }
}
