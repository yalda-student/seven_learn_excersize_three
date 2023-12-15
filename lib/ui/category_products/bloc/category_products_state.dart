part of 'category_products_bloc.dart';

abstract class CategoryProductsState {}

class CategoryProductsLoading extends CategoryProductsState {}

class CategoryProductsSuccess extends CategoryProductsState {
  final List<ProductEntity> productList;

  CategoryProductsSuccess(this.productList);
}

class CategoryProductsError extends CategoryProductsState {}
