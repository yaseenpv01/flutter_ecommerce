import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce_motion_flutter/feature/home_products/presentation/provider/products_provider.dart';

class FilterWidget extends StatelessWidget {
  const FilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = context.watch<ProductsProvider>();
    var categories = provider.categories;

    return ListView(
      padding: EdgeInsets.zero,
      children: [
        const DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Text(
            'Filter Products',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
        ListTile(
          title: const Text('Category'),
          trailing: DropdownButton<String>(
            value: provider.selectedCategory,
            onChanged: (value) {
              provider.setCategory(value);
            },
            items: categories.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
        ListTile(
          title: const Text('Minimum Price'),
          trailing: SizedBox(
            width: 100,
            child: TextField(
              keyboardType: TextInputType.number,
              onSubmitted: (value) {
                double? minPrice = double.tryParse(value);
                provider.setPriceRange(minPrice, provider.maxPrice);
              },
              decoration: const InputDecoration(
                hintText: 'Min Price',
              ),
            ),
          ),
        ),
        ListTile(
          title: const Text('Maximum Price'),
          trailing: SizedBox(
            width: 100,
            child: TextField(
              keyboardType: TextInputType.number,
              onSubmitted: (value) {
                double? maxPrice = double.tryParse(value);
                provider.setPriceRange(provider.minPrice, maxPrice);
              },
              decoration: const InputDecoration(
                hintText: 'Max Price',
              ),
            ),
          ),
        ),
        ListTile(
          title: const Text('Minimum Rating'),
          trailing: SizedBox(
            width: 100,
            child: TextField(
              keyboardType: TextInputType.number,
              onSubmitted: (value) {
                double? minRating = double.tryParse(value);
                provider.setRating(minRating);
              },
              decoration: const InputDecoration(
                hintText: 'Min Rating',
              ),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
