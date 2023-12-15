import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seven_learn_exercise_three/data/repository/product_repository.dart';

part 'add_product_event.dart';
part 'add_product_state.dart';

class AddProductBloc extends Bloc<AddProductEvent, AddProductState> {
  final IProductRepository productRepository;

  AddProductBloc(this.productRepository) : super(AddProductInitial()) {
    on<AddProductEvent>((event, emit) {});
  }
}
