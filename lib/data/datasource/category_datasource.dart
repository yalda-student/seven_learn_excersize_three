import 'package:dio/dio.dart';
import 'package:seven_learn_exercise_three/common/constants.dart';
import 'package:seven_learn_exercise_three/common/exception.dart';
import 'package:seven_learn_exercise_three/data/product.dart';

abstract class ICategoryDataSource {
  Future<List<String>> getAllCategories();

  Future<List<ProductEntity>> getProductsOfCategory(String category,
      {int skip = 0, int limit = Constants.productLimit});
}

class RemoteCategoryDataSource implements ICategoryDataSource {
  final Dio _dio;

  RemoteCategoryDataSource(this._dio);

  @override
  Future<List<String>> getAllCategories() async {
    final response = await _dio.get('/products/categories');
    if (response.statusCode! == 200) {
      return (response.data as List).map((item) => item as String).toList();
    } else {
      throw ServerException(
          message: response.statusMessage!, statusCode: response.statusCode!);
    }
  }

  @override
  Future<List<ProductEntity>> getProductsOfCategory(String category,
      {int skip = 0, int limit = Constants.productLimit}) async {
    final response =
        await _dio.get('/products/category/$category', queryParameters: {
      'skip': skip,
      'limit': limit,
    });
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
