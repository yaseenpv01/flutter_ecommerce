import 'package:dartz/dartz.dart';
import 'package:ecommerce_motion_flutter/core/params/params.dart';
import 'package:ecommerce_motion_flutter/errors/failure.dart';
import 'package:ecommerce_motion_flutter/feature/detail_products/domain/entity/detail_products_entity.dart';

abstract class DetailProductsRepository {
  Future<Either<Failure, DetailProductsEntity>> getProducts(
      {required ProductsParams productsParams});
}
