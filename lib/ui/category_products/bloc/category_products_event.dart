part of 'category_products_bloc.dart';

abstract class CategoryProductsEvent {}

class CategoryProductsInit extends CategoryProductsEvent {
  final String categoryName;

  CategoryProductsInit(this.categoryName);
}

class CategoryProductsLoadMoreDate extends CategoryProductsEvent {}
