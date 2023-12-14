import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:seven_learn_exercise_three/common/di.dart';
import 'package:seven_learn_exercise_three/common/exception.dart';
import 'package:seven_learn_exercise_three/data/product.dart';

abstract class IProductDataSource {
  Future<List<ProductEntity>> getAllProducts(int skip , {int limit = 10});

  Future<ProductEntity> addProduct(Map<String, dynamic> product);
}

class RemoteProductDataSource implements IProductDataSource {
  final _dio = di.get<Dio>();

  @override
  Future<ProductEntity> addProduct(Map<String, dynamic> product) {
    // TODO: implement addProduct
    throw UnimplementedError();
  }

  @override
  Future<List<ProductEntity>> getAllProducts(int skip , {int limit = 10}) async {
    //ToDo
    final response = await _dio.get('/products', queryParameters: {
      'skip': skip,
      'limit': limit,
    });
    if (response.statusCode! == 200) {
      List data = response.data['products'];
      log(data.toString());
      return data
          .map<ProductEntity>((json) => ProductEntity.fromJson(json))
          .toList();
    } else {
      throw ServerException(
          message: response.statusMessage!, statusCode: response.statusCode!);
    }
  }
}
