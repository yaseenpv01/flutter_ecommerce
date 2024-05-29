import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce_motion_flutter/connection/network_info.dart';
import 'package:ecommerce_motion_flutter/errors/failure.dart';
import 'package:ecommerce_motion_flutter/feature/home_products/data/data_source/local_data_source.dart';
import 'package:ecommerce_motion_flutter/feature/home_products/data/data_source/remote_data_source.dart';
import 'package:ecommerce_motion_flutter/feature/home_products/data/repository/products_repository_implementation.dart';
import 'package:ecommerce_motion_flutter/feature/home_products/domain/entity/products_entity.dart';
import 'package:ecommerce_motion_flutter/feature/home_products/domain/usecases/get_products.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductsProvider extends ChangeNotifier {
  List<ProductsEntity>? productsEntity;
  List<ProductsEntity>? filteredProducts;

  Failure? failure;

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

  ProductsProvider({
    this.productsEntity,
    this.failure,
  });

  String searchText = '';
  double? minPrice;
  double? maxPrice;
  double? minRating;
  String? selectedCategory;

  void updateData() {
    if (searchText.isEmpty) {
      filteredProducts = productsEntity;
    } else {
      filteredProducts = productsEntity?.where((product) {
        return product.title.toLowerCase().startsWith(searchText.toLowerCase());
      }).toList();
    }
    notifyListeners();
  }

  void search(String query) {
    searchText = query;
    updateData();
  }

  void setPriceRange(double? min, double? max) {
    minPrice = min;
    maxPrice = max;
    updateData();
  }

  void setRating(double? rating) {
    minRating = rating;
    updateData();
  }

  void setCategory(String? category) {
    selectedCategory = category;
    updateData();
  }

  void setIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  Future<void> eitherFailureOrTemplate() async {
    ProductsRepositoryImpl repository = ProductsRepositoryImpl(
      remoteDataSource: ProductsRemoteDataSourceImpl(
        dio: Dio(),
      ),
      localDataSource: ProductsLocalDataSourceImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
      networkInfo: NetworkInfoImpl(
        DataConnectionChecker(),
      ),
    );

    final failureOrTemplate = await GetAllProducts(repository).call();

    failureOrTemplate.fold(
      (Failure newFailure) {
        productsEntity = null;
        filteredProducts = null;
        failure = newFailure;
      },
      (List<ProductsEntity> newTemplate) {
        productsEntity = newTemplate;
        filteredProducts = [];
        failure = null;
      },
    );

    notifyListeners();
  }
}
