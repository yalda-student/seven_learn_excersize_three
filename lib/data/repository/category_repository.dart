import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:seven_learn_exercise_three/common/di.dart';
import 'package:seven_learn_exercise_three/common/exception.dart';
import 'package:seven_learn_exercise_three/data/datasource/category_datasource.dart';
import 'package:seven_learn_exercise_three/data/product.dart';

abstract class ICategoryRepository {
  Future<List<String>> getAllCategories();

  Future<List<ProductEntity>> getProductsOfCategory(String category,
      {int skip = 0, int limit = 10});
}

class CategoryRepository implements ICategoryRepository {
  final ICategoryDataSource _dataSource;

  CategoryRepository(this._dataSource);

  @override
  Future<List<String>> getAllCategories() => _dataSource.getAllCategories();

  @override
  Future<List<ProductEntity>> getProductsOfCategory(String category,
          {int skip = 0, int limit = 10}) =>
      _dataSource.getProductsOfCategory(category, skip: skip, limit: limit);
}
