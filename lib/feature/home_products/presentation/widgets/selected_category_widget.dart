import 'package:ecommerce_motion_flutter/feature/home_products/presentation/provider/products_provider.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class CategorySelector extends StatelessWidget {
  const CategorySelector({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SizedBox(
        height: 40,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemBuilder: (context, index) {
            final int selectedIndex =
                context.watch<ProductsProvider>().selectedIndex;

            return GestureDetector(
              onTap: () {
                context.read<ProductsProvider>().setIndex(index);
              },
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: index == selectedIndex
                      ? const Color(0xFF292526)
                      : const Color(0xFFF2F2F2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Icon(Icons.).
                    Text(
                      context.watch<ProductsProvider>().categories[index],
                      style: TextStyle(
                        color: index == selectedIndex
                            ? Colors.white
                            : const Color(0xFF4D4D4D),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => const SizedBox(width: 10),
          itemCount: context.watch<ProductsProvider>().categories.length,
        ),
      ),
    );
  }
}
