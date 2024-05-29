import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce_motion_flutter/feature/home_products/presentation/provider/products_provider.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var controller = context.watch<ProductsProvider>();

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          autofocus: true,
          onChanged: (value) {
            controller.search(value);
          },
          onSubmitted: (value) {
            controller.search(value);
          },
          decoration: const InputDecoration(
            hintText: 'Search for products',
            border: InputBorder.none,
          ),
        ),
      ),

      body: Consumer<ProductsProvider>(
        builder: (context, provider, child) {
          var suggestions = provider.filteredProducts;
          var searchText = provider.searchText;

          if (searchText.isEmpty) {
            return const Center(
              child: Text('Type something to search'),
            );
          }

          if (suggestions == null || suggestions.isEmpty) {
            return const Center(
              child: Text('No suggestions available'),
            );
          }

          return ListView.builder(
            itemCount: suggestions.length,
            itemBuilder: (context, index) {
              var product = suggestions[index];
              return ListTile(
                leading: SizedBox(
                  height: 50,
                  width: 50,
                  child: Image.network(
                    product.image,
                  ),
                ),
                title: Text(product.title),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/detail-products',
                    arguments: product.id,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
