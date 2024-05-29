import 'package:dartz/dartz.dart';
import 'package:ecommerce_motion_flutter/connection/network_info.dart';
import 'package:ecommerce_motion_flutter/core/params/params.dart';
import 'package:ecommerce_motion_flutter/errors/exceptions.dart';
import 'package:ecommerce_motion_flutter/errors/failure.dart';
import 'package:ecommerce_motion_flutter/feature/detail_products/data/data_source/local_data_source.dart';
import 'package:ecommerce_motion_flutter/feature/detail_products/data/data_source/remote_data_source.dart';
import 'package:ecommerce_motion_flutter/feature/detail_products/data/models/detail_products.dart';
import 'package:ecommerce_motion_flutter/feature/detail_products/domain/repository/detail_products_repository.dart';

class DetailProductsRepositoryImpl implements DetailProductsRepository {
  final DetailProductsRemoteDataSourceImpl remoteDataSource;
  final DetailProductsLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  DetailProductsRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, DetailProductsModel>> getProducts(
      {required ProductsParams productsParams}) async {
    if (await networkInfo.isConnected!) {
      try {
        DetailProductsModel remoteTemplate =
            await remoteDataSource.getProducts(params: productsParams);

        localDataSource.cacheProducts(productsToCache: remoteTemplate);

        return Right(remoteTemplate);
      } on ServerException {
        return Left(ServerFailure(errorMessage: 'This is a server exception'));
      }
    } else {
      try {
        DetailProductsModel localTemplate =
            await localDataSource.getLastProducts();
        return Right(localTemplate);
      } on CacheException {
        return Left(CacheFailure(errorMessage: 'This is a cache exception'));
      }
    }
  }
}
