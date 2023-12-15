import 'package:seven_learn_exercise_three/data/datasource/product_datasource.dart';
import 'package:seven_learn_exercise_three/data/product.dart';

abstract class IProductRepository {
  Future<List<ProductEntity>> getAllProducts(int skip, {int limit = 10});

  Future<ProductEntity> addProduct(Map<String, dynamic> product);
}

class ProductRepository implements IProductRepository {
  final IProductDataSource _dataSource;

  ProductRepository(this._dataSource);

  @override
  Future<ProductEntity> addProduct(Map<String, dynamic> product) =>
      _dataSource.addProduct(product);

  @override
  Future<List<ProductEntity>> getAllProducts(int skip, {int limit = 10}) =>
      _dataSource.getAllProducts(skip, limit: limit);
}
