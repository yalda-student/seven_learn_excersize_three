import 'package:bloc/bloc.dart';
import 'package:seven_learn_exercise_three/common/constants.dart';
import 'package:seven_learn_exercise_three/data/product.dart';
import 'package:seven_learn_exercise_three/data/repository/category_repository.dart';

part 'category_products_event.dart';
part 'category_products_state.dart';

class CategoryProductsBloc
    extends Bloc<CategoryProductsEvent, CategoryProductsState> {
  final ICategoryRepository categoryRepository;

  int productSkipNumber = 0;
  List<ProductEntity> productList = [];

  CategoryProductsBloc(this.categoryRepository)
      : super(CategoryProductsLoading()) {
    on<CategoryProductsEvent>((event, emit) async {
      if (event is CategoryProductsInit) {
        productList.clear();
        productList.addAll(await categoryRepository.getProductsOfCategory(
            event.categoryName,
            skip: productSkipNumber));
        emit(CategoryProductsSuccess(productList));
      } else if (event is CategoryProductsLoadMoreDate) {
        productSkipNumber += Constants.productLimit;
      }
    });
  }
}
