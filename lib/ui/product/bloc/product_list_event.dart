part of 'product_list_bloc.dart';

abstract class ProductListEvent {}

class ProductListInit extends ProductListEvent {}

class ProductListLoadMoreData extends ProductListEvent {}

class ProductListAddNewProduct extends ProductListEvent {
  final ProductEntity product;

  ProductListAddNewProduct(this.product);
}
