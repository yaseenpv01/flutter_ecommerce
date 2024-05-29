import 'package:dartz/dartz.dart';
import 'package:ecommerce_motion_flutter/errors/failure.dart';
import 'package:ecommerce_motion_flutter/feature/home_products/domain/entity/products_entity.dart';
import 'package:ecommerce_motion_flutter/feature/home_products/domain/repository/products_repository.dart';

class GetAllProducts {
  final ProductsRepository productRepository;

  GetAllProducts(this.productRepository);

  Future<Either<Failure, List<ProductsEntity>>> call() async {
    return await productRepository.getAllProducts();
  }
}
