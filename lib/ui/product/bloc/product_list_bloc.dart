import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:seven_learn_exercise_three/common/constants.dart';
import 'package:seven_learn_exercise_three/common/exception.dart';
import 'package:seven_learn_exercise_three/data/product.dart';
import 'package:seven_learn_exercise_three/data/repository/category_repository.dart';
import 'package:seven_learn_exercise_three/data/repository/product_repository.dart';

part 'product_list_event.dart';
part 'product_list_state.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  final IProductRepository productRepository;
  final ICategoryRepository categoryRepository;

  int productSkipNumber = 0;
  List<ProductEntity> productList = [];

  ProductListBloc(this.productRepository, this.categoryRepository)
      : super(ProductListLoading()) {
    on<ProductListEvent>((event, emit) async {
      if (event is ProductListInit) {
        emit(ProductListLoading());
        //get category list
        final categoryResult = await categoryRepository.getAllCategories();
        try {
          emit(ProductListSuccessCategory(categoryResult));
        } on ServerException catch (e) {
          log(e.toString());
          emit(ProductListErrorCategory(e.message));
        }
        emit(ProductListLoading());
        //get product list
        productList = await productRepository.getAllProducts(productSkipNumber);
        try {
          emit(ProductListSuccessProduct(productList));
        } on ServerException catch (e) {
          log(e.toString());
        }
      } else if (event is ProductListLoadMoreData) {
        productSkipNumber += Constants.productLimit;
        productList
            .addAll(await productRepository.getAllProducts(productSkipNumber));
        try {
          emit(ProductListSuccessProduct(productList));
        } on ServerException catch (e) {
          log(e.toString());
        }
      } else if (event is ProductListAddNewProduct) {
        productList.insert(0, event.product);
        emit(ProductListSuccessProduct(productList));
      }
    });
  }
}
