import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_motion_flutter/feature/carts_feature/presentation/providers/carts_provider.dart';
import 'package:ecommerce_motion_flutter/feature/detail_products/domain/entity/detail_products_entity.dart';
import 'package:ecommerce_motion_flutter/feature/detail_products/presentation/provider/detail_products_provider.dart';
import 'package:ecommerce_motion_flutter/feature/detail_products/presentation/widgets/custom_app_bar.dart';
import 'package:ecommerce_motion_flutter/feature/home_products/presentation/widgets/custom_route_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

class DetailProductsPage extends StatelessWidget {
  static const routeName = '/detail-products';

  const DetailProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)?.settings.arguments as int;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      body: FutureBuilder<void>(
        future: Provider.of<DetailProductsProvider>(context, listen: false)
            .eitherFailureOrTemplate(value: id),
        builder: (context, snapshot) {
          final product = context.watch<DetailProductsProvider>().productsModel;

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: Center(
                child: Container(
                  decoration: const BoxDecoration(color: Colors.white),
                  child: const CircularProgressIndicator(),
                ),
              ),
            );
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Error loading product details'));
          }

          if (product == null) {
            return const Center(child: Text('Product not found'));
          }
          return Stack(
            children: [
              PopScope(
                onPopInvoked: (didPop) {
                  context.read<DetailProductsProvider>().resetQuantity();
                },
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: SafeArea(
                    bottom: false,
                    child: Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height / 2.4,
                          padding: const EdgeInsets.all(16),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: CachedNetworkImage(
                              placeholder: (context, url) => const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                              imageUrl: product.image,
                              width: double.infinity,
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: const BoxDecoration(
                            color: Color(0xFF292526),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Text(
                                      product.title,
                                      maxLines: 3,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        color: Colors.white,
                                        icon: const Icon(
                                          Icons.remove,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {
                                          context
                                              .read<DetailProductsProvider>()
                                              .decrementQuantity();
                                        },
                                      ),
                                      Container(
                                        width: 40,
                                        alignment: Alignment.center,
                                        child: Text(
                                          '${context.watch<DetailProductsProvider>().totalQuantity}',
                                          style: const TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        color: Colors.white,
                                        icon: const Icon(
                                          Icons.add,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {
                                          context
                                              .read<DetailProductsProvider>()
                                              .incrementQuantity();
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    product.category,
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 214, 214, 214),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        const WidgetSpan(
                                          alignment:
                                              PlaceholderAlignment.middle,
                                          child: Icon(
                                            Icons.star,
                                            size: 26,
                                            color: Colors.amber,
                                          ),
                                        ),
                                        const WidgetSpan(
                                          alignment:
                                              PlaceholderAlignment.middle,
                                          child: SizedBox(width: 5),
                                        ),
                                        TextSpan(
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                          ),
                                          text: '${product.rating.rate}',
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(),
                              const SizedBox(height: 10),
                              const Text(
                                'Description',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 10),
                              ReadMoreText(
                                product.description,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                                trimLines: 2,
                                colorClickableText: Colors.white,
                                trimMode: TrimMode.Line,
                                trimCollapsedText: ' Show more',
                                trimExpandedText: ' Show less',
                                moreStyle: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                lessStyle: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              CustomAppBar(
                action: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: () {
                        Navigator.of(context).push(createRoute());
                      },
                      child: Ink(
                        padding: const EdgeInsets.all(7),
                        decoration: const BoxDecoration(
                          color: Color(0xFF292526),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.shopping_cart,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: Consumer<DetailProductsProvider>(
        builder: (context, provider, child) {
          final product = provider.productsModel;
          int quantity = provider.totalQuantity;
          if (product == null) {
            return const SizedBox.shrink(); // or a placeholder if preferred
          }
          return BottomBarTotal(
            product: product,
            quantity: quantity,
          );
        },
      ),
    );
  }
}

class BottomBarTotal extends StatelessWidget {
  const BottomBarTotal({
    super.key,
    required this.product,
    required this.quantity,
  });

  final DetailProductsEntity product;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 0,
        bottom: 20,
      ),
      decoration: const BoxDecoration(
        color: Color(0xFF292526),
      ),
      height: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Total Price',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              Text(
                '\$${product.price}',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Container(
            width: 200,
            height: 50,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(50),
              ),
            ),
            child: InkWell(
              onTap: () {
                context.read<CartsProvider>().addToCart(product, quantity);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    duration: const Duration(seconds: 1),
                    backgroundColor: Colors.black.withOpacity(0.5),
                    // elevation: 10,
                    behavior: SnackBarBehavior.floating,
                    margin: const EdgeInsets.only(
                      bottom: 300.0,
                      left: 70,
                      right: 70,
                    ),

                    // backgroundColor: Colors.grey.withOpacity(0.3),
                    content: Container(
                      alignment: Alignment.center,
                      height: 100,
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.check_circle_outline_rounded,
                            size: 60,
                            color: Colors.white70,
                          ),
                          SizedBox(height: 10),
                          Text('Successfully Added to Cart'),
                        ],
                      ),
                    ),
                  ),
                );
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_checkout,
                    color: Colors.black,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Add to cart',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
