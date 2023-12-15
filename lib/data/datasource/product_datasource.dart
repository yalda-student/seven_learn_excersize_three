import 'package:dio/dio.dart';
import 'package:seven_learn_exercise_three/common/constants.dart';
import 'package:seven_learn_exercise_three/common/exception.dart';
import 'package:seven_learn_exercise_three/data/product.dart';

abstract class IProductDataSource {
  Future<List<ProductEntity>> getAllProducts(int skip,
      {int limit = Constants.productLimit});

  Future<ProductEntity> addProduct(Map<String, dynamic> product);
}

class RemoteProductDataSource implements IProductDataSource {
  final Dio _dio;

  RemoteProductDataSource(this._dio);

  @override
  Future<ProductEntity> addProduct(Map<String, dynamic> product) async {
    final response = await _dio.post('/products/add', data: product);

    if (response.statusCode! == 200) {
      return ProductEntity.fromJson(response.data);
    } else {
      throw ServerException(
          message: response.statusMessage!, statusCode: response.statusCode!);
    }
  }

  @override
  Future<List<ProductEntity>> getAllProducts(int skip,
      {int limit = Constants.productLimit}) async {
    final response = await _dio
        .get('/products', queryParameters: {'skip': skip, 'limit': limit});
    if (response.statusCode! == 200) {
      List data = response.data['products'];
      return data
          .map<ProductEntity>((json) => ProductEntity.fromJson(json))
          .toList();
    } else {
      throw ServerException(
          message: response.statusMessage!, statusCode: response.statusCode!);
    }
  }
}
