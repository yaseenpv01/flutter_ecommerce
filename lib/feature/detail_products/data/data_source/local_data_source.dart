import 'dart:convert';

import 'package:ecommerce_motion_flutter/errors/exceptions.dart';
import 'package:ecommerce_motion_flutter/feature/detail_products/data/models/detail_products.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class DetailProductsLocalDataSource {
  Future<void> cacheProducts({required DetailProductsModel? productsToCache});
  Future<DetailProductsModel> getLastProducts();
}

const cachedProducts = 'CACHED_Products';

class DetailProductsLocalDataSourceImpl implements DetailProductsLocalDataSource {
  final SharedPreferences sharedPreferences;

  DetailProductsLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<DetailProductsModel> getLastProducts() {
    final jsonString = sharedPreferences.getString(cachedProducts);

    if (jsonString != null) {
      return Future.value(
          DetailProductsModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheProducts(
      {required DetailProductsModel? productsToCache}) async {
    if (productsToCache != null) {
      sharedPreferences.setString(
        cachedProducts,
        json.encode(
          productsToCache.toJson(),
        ),
      );
    } else {
      throw CacheException();
    }
  }
}
