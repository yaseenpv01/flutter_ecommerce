import 'package:ecommerce_motion_flutter/feature/carts_feature/presentation/providers/carts_provider.dart';
import 'package:ecommerce_motion_flutter/feature/detail_products/domain/entity/detail_products_entity.dart';
import 'package:ecommerce_motion_flutter/feature/detail_products/domain/entity/sub_entity.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartsItemWidget extends StatelessWidget {
  final int id;
  final String title;
  final String image;
  final double price;
  final int quantity;
  final String description;

  final String category;

  const CartsItemWidget(this.id, this.title, this.image, this.price,
      this.quantity, this.description, this.category,
      {super.key});

  // bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                image,
                width: 90,
                height: 90,
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.8,
                    child: Text(
                      title,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Text(
                    category,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '\$$price',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        height: 38,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          border: Border.all(strokeAlign: 1),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Row(
                          children: [
                            InkWell(
                              // color: Colors.white,
                              onTap: () {
                                if (context
                                        .read<CartsProvider>()
                                        .getQuantity(id) ==
                                    1) {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        content: const Text(
                                          'Are you sure to delete?',
                                        ),
                                        actions: [
                                          TextButton(
                                            child: const Text('Cancel'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          TextButton(
                                            child: const Text('Ok'),
                                            onPressed: () {
                                              context
                                                  .read<CartsProvider>()
                                                  .removeFromCart(
                                                    DetailProductsEntity(
                                                      id: id,
                                                      category: category,
                                                      description: description,
                                                      image: image,
                                                      price: price,
                                                      title: title,
                                                      rating:
                                                          const RatingEntity(
                                                        count: 0,
                                                        rate: 0,
                                                      ),
                                                    ),
                                                  );

                                              Navigator.of(context).pop();
                                            },
                                          )
                                        ],
                                      );
                                    },
                                  );
                                } else {
                                  context
                                      .read<CartsProvider>()
                                      .decrementQuantity(id);
                                }
                              },
                              child: context
                                          .watch<CartsProvider>()
                                          .getQuantity(id) ==
                                      1
                                  ? const Padding(
                                      padding: EdgeInsets.only(left: 10.0),
                                      child: Icon(
                                        Icons.delete,
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                    )
                                  : const Padding(
                                      padding: EdgeInsets.only(left: 10.0),
                                      child: Icon(
                                        Icons.remove,
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                    ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              // color: Colors.amber,
                              width: 40,
                              child: Text(
                                '${context.watch<CartsProvider>().getQuantity(id)}',
                                // '${context.watch<DetailProductsProvider>().totalQuantity}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                context
                                    .read<CartsProvider>()
                                    .incrementQuantity(id, quantity);
                              },
                              child: const Padding(
                                padding: EdgeInsets.only(right: 10.0),
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
