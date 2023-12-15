part of 'product_list_bloc.dart';

abstract class ProductListState {}

class ProductListLoading extends ProductListState {}

class ProductListSuccessCategory extends ProductListState {
  final List<String> categoryList;

  ProductListSuccessCategory(this.categoryList);
}

class ProductListSuccessProduct extends ProductListState {
  final List<ProductEntity> productList;

  ProductListSuccessProduct(this.productList);
}

class ProductListErrorCategory extends ProductListState {
  final String errorMessage;

  ProductListErrorCategory(this.errorMessage);
}

class ProductListErrorProduct extends ProductListState {
  final String errorMessage;

  ProductListErrorProduct(this.errorMessage);
}
