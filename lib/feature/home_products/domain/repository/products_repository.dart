import 'package:dartz/dartz.dart';
import 'package:ecommerce_motion_flutter/errors/failure.dart';
import 'package:ecommerce_motion_flutter/feature/home_products/domain/entity/products_entity.dart';

abstract class ProductsRepository {
  Future<Either<Failure, List<ProductsEntity>>> getAllProducts();
}
