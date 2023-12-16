part of 'add_product_bloc.dart';

abstract class AddProductEvent {}

class AddProduct extends AddProductEvent {
  final CreateProduct product;

  AddProduct({required this.product});
}
