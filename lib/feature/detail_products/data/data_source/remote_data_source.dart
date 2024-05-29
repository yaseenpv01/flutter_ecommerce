import 'package:dio/dio.dart';
import 'package:ecommerce_motion_flutter/core/params/params.dart';
import 'package:ecommerce_motion_flutter/errors/exceptions.dart';
import 'package:ecommerce_motion_flutter/feature/detail_products/data/models/detail_products.dart';

abstract class DetailProductsRemoteDataSource {
  Future<DetailProductsModel> getProducts({required ProductsParams params});
}

class DetailProductsRemoteDataSourceImpl implements DetailProductsRemoteDataSource {
  final Dio dio;

  DetailProductsRemoteDataSourceImpl({required this.dio});

  @override
  Future<DetailProductsModel> getProducts(
      {required ProductsParams params}) async {
    try {
      final response = await dio.get(
        'https://fakestoreapi.com/products/${params.id}',
      );

      if (response.statusCode == 200) {
        return DetailProductsModel.fromJson(response.data);
      } else {

        throw ServerException();
      }
    } on DioException {
      throw ServerException();
    } catch (e) {
      throw ServerException();
    }
  }
}
