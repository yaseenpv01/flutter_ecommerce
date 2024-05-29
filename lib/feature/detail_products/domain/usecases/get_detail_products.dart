import 'package:dartz/dartz.dart';
import 'package:ecommerce_motion_flutter/errors/failure.dart';
import 'package:ecommerce_motion_flutter/feature/detail_products/domain/entity/detail_products_entity.dart';
import 'package:ecommerce_motion_flutter/feature/detail_products/domain/repository/detail_products_repository.dart';
import '../../../../../core/params/params.dart';

class GetProducts {
  final DetailProductsRepository detailProductsRepository;

  GetProducts(this.detailProductsRepository);

  Future<Either<Failure, DetailProductsEntity>> call({
    required ProductsParams productsParams,
  }) async {
    return await detailProductsRepository.getProducts(
      productsParams: productsParams,
    );
  }
}
