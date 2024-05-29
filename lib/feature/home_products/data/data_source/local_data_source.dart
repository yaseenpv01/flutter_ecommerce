import 'dart:convert';

import 'package:ecommerce_motion_flutter/errors/exceptions.dart';
import 'package:ecommerce_motion_flutter/feature/home_products/data/models/products_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ProductsLocalDataSource {
  Future<void> cacheProducts({required List<ProductsModel> productsToCache});
  Future<List<ProductsModel>> getLastProducts();
}

const cachedProducts = 'CACHED_PRODUCTS';

class ProductsLocalDataSourceImpl implements ProductsLocalDataSource {
  final SharedPreferences sharedPreferences;

  ProductsLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<ProductsModel>> getLastProducts() {
    final jsonString = sharedPreferences.getString(cachedProducts);

    if (jsonString != null) {
      final List<dynamic> jsonList = json.decode(jsonString);
      return Future.value(ProductsModel.fromJsonList(jsonList));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheProducts(
      {required List<ProductsModel> productsToCache}) async {
    final String jsonString = json
        .encode(productsToCache.map((product) => product.toJson()).toList());
    await sharedPreferences.setString(cachedProducts, jsonString);
  }
}
