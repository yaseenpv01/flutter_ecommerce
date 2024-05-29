import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce_motion_flutter/feature/home_products/presentation/provider/products_provider.dart';
import 'package:ecommerce_motion_flutter/feature/home_products/presentation/widgets/products_grid_widget.dart';

class SearchResultPage extends StatelessWidget {
  final String query;

  const SearchResultPage({required this.query, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = context.watch<ProductsProvider>();

    var results = provider.filteredProducts
        ?.where((product) =>
            product.title.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          autofocus: false,
          onChanged: (value) {
  
            provider.search(value);
          },
          onSubmitted: (value) {
            provider.search(value);
          },
          decoration: const InputDecoration(
            hintText: 'Search for products',
            border: InputBorder.none,
          ),
        ),
      ),
      body: ListView(
        children: [
          if (results != null && results.isNotEmpty)
            ProductsGridWidget(
              products: results,
            ),
          if (results == null || results.isEmpty)
            const Center(
              child: Text('No products found'),
            ),
        ],
      ),
    );
  }
}
