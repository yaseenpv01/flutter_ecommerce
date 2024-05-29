import 'package:dartz/dartz.dart';
import 'package:ecommerce_motion_flutter/connection/network_info.dart';
import 'package:ecommerce_motion_flutter/errors/exceptions.dart';
import 'package:ecommerce_motion_flutter/errors/failure.dart';
import 'package:ecommerce_motion_flutter/feature/home_products/data/data_source/local_data_source.dart';
import 'package:ecommerce_motion_flutter/feature/home_products/data/data_source/remote_data_source.dart';
import 'package:ecommerce_motion_flutter/feature/home_products/data/models/products_model.dart';
import 'package:ecommerce_motion_flutter/feature/home_products/domain/repository/products_repository.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  final ProductsRemoteDataSourceImpl remoteDataSource;
  final ProductsLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  ProductsRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<ProductsModel>>> getAllProducts() async {
    if (await networkInfo.isConnected!) {
      try {
        List<ProductsModel> remoteTemplate =
            await remoteDataSource.getAllProducts();

        localDataSource.cacheProducts(productsToCache: remoteTemplate);

        return Right(remoteTemplate);
      } on ServerException {
        return Left(ServerFailure(errorMessage: 'This is a server exception'));
      }
    } else {
      try {
        List<ProductsModel> localTemplate =
            await localDataSource.getLastProducts();
        return Right(localTemplate);
      } on CacheException {
        return Left(CacheFailure(errorMessage: 'This is a cache exception'));
      }
    }
  }

}
