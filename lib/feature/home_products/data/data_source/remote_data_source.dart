import 'package:dio/dio.dart';
import 'package:ecommerce_motion_flutter/core/util/logging.dart';
import 'package:ecommerce_motion_flutter/errors/exceptions.dart';
import 'package:ecommerce_motion_flutter/feature/home_products/data/models/products_model.dart';

abstract class ProductsRemoteDataSource {
  Future<List<ProductsModel>> getAllProducts();
}

class ProductsRemoteDataSourceImpl implements ProductsRemoteDataSource {
  final Dio dio;

  ProductsRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<ProductsModel>> getAllProducts() async {
    try {
      final response = await dio.get(
        'https://fakestoreapi.com/products/',
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = response.data;
        return ProductsModel.fromJsonList(jsonList);
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      log.i('DioError: ${e.message}');
      throw ServerException();
    } catch (e) {
      // Handle any other errors
      log.i('Unexpected error: $e');
      throw ServerException();
    }
  }
}
