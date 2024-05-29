import 'package:dio/dio.dart';
import 'package:ecommerce_motion_flutter/connection/network_info.dart';
import 'package:ecommerce_motion_flutter/core/params/params.dart';
import 'package:ecommerce_motion_flutter/errors/failure.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:ecommerce_motion_flutter/feature/detail_products/data/data_source/local_data_source.dart';
import 'package:ecommerce_motion_flutter/feature/detail_products/data/data_source/remote_data_source.dart';
import 'package:ecommerce_motion_flutter/feature/detail_products/data/models/detail_products.dart';
import 'package:ecommerce_motion_flutter/feature/detail_products/data/models/sub_models.dart';
import 'package:ecommerce_motion_flutter/feature/detail_products/data/repository/detail_products_repository_implementation.dart';
import 'package:ecommerce_motion_flutter/feature/detail_products/domain/entity/detail_products_entity.dart';
import 'package:ecommerce_motion_flutter/feature/detail_products/domain/usecases/get_detail_products.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailProductsProvider extends ChangeNotifier {
  DetailProductsEntity? productsModel;
  Failure? failure;
  int totalQuantity = 1;

  DetailProductsProvider({
    this.productsModel,
    this.failure,
  });

  void incrementQuantity() {
    totalQuantity++;
    notifyListeners();
  }

  void decrementQuantity() {
    if (totalQuantity > 1) {
      totalQuantity--;
      notifyListeners();
    }
  }

  void resetQuantity() {
    totalQuantity = 1;
    notifyListeners();
  }

  Future<DetailProductsEntity> eitherFailureOrTemplate(
      {required int value}) async {
    DetailProductsRepositoryImpl repository = DetailProductsRepositoryImpl(
      remoteDataSource: DetailProductsRemoteDataSourceImpl(
        dio: Dio(),
      ),
      localDataSource: DetailProductsLocalDataSourceImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
      networkInfo: NetworkInfoImpl(
        DataConnectionChecker(),
      ),
    );

    final failureOrTemplate = await GetProducts(repository).call(
      productsParams: ProductsParams(id: value),
    );

    return failureOrTemplate.fold(
      (Failure newFailure) {
        failure = newFailure;
        productsModel = DetailProductsModel(
          id: 0,
          title: 'Default Product',
          description: 'This is a default product description.',
          price: 0.0,
          image: 'default_image_url',
          category: 'default_category',
          rating: const RatingModel(count: 0, rate: 0),
          quantity: 0,
        );

        notifyListeners();
        return productsModel!;
      },
      (DetailProductsEntity newTemplate) {
        productsModel = newTemplate;
        failure = null;
        notifyListeners();
        return productsModel!;
      },
    );
  }

  int _selectedIndex = 0;
  final List<String> _categories = [
    'All Items',
    'Women\'s Clothing',
    'Men\'s Clothing',
    'Jewelery',
    'Electronics'
  ];

  int get selectedIndex => _selectedIndex;
  List<String> get categories => _categories;

  void setIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}
