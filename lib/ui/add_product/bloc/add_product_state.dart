part of 'add_product_bloc.dart';

abstract class AddProductState {}

class AddProductInitial extends AddProductState {}

class AddProductSuccess extends AddProductState {
  final ProductEntity product;

  AddProductSuccess(this.product);
}

class AddProductError extends AddProductState {
  final String message;

  AddProductError(this.message);
}

class AddProductLoading extends AddProductState {}
