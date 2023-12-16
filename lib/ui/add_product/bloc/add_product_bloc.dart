import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seven_learn_exercise_three/common/exception.dart';
import 'package:seven_learn_exercise_three/data/create_product.dart';
import 'package:seven_learn_exercise_three/data/product.dart';
import 'package:seven_learn_exercise_three/data/repository/product_repository.dart';

part 'add_product_event.dart';
part 'add_product_state.dart';

class AddProductBloc extends Bloc<AddProductEvent, AddProductState> {
  final IProductRepository productRepository;

  AddProductBloc(this.productRepository) : super(AddProductInitial()) {
    on<AddProductEvent>((event, emit) async {
      if (event is AddProduct) {
        emit(AddProductLoading());

        try {
          final product =
              await productRepository.addProduct(event.product.toMap());
          emit(AddProductSuccess(product));
        } on ServerException catch (error) {
          emit(AddProductError(error.message));
        }
      }
    });
  }
}
