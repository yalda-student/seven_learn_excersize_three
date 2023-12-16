import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seven_learn_exercise_three/common/di.dart';
import 'package:seven_learn_exercise_three/data/product.dart';
import 'package:seven_learn_exercise_three/ui/category_products/bloc/category_products_bloc.dart';
import 'package:seven_learn_exercise_three/ui/widget/app_icon_button.dart';
import 'package:seven_learn_exercise_three/ui/widget/product_item.dart';
import 'package:seven_learn_exercise_three/ui/widget/state/linear_loading_state.dart';

class CategoryProductsScreen extends StatelessWidget {
  const CategoryProductsScreen({super.key, required this.categoryName});

  final String categoryName;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(categoryName),
        automaticallyImplyLeading: false,
        leading: AppIconButton(
            onTap: () => Navigator.pop(context),
            icon: const Icon(Icons.keyboard_arrow_left_rounded)),
      ),
      body: BlocProvider<CategoryProductsBloc>(
        create: (context) =>
            CategoryProductsBloc(di())..add(CategoryProductsInit(categoryName)),
        child: BlocBuilder<CategoryProductsBloc, CategoryProductsState>(
          builder: (context, state) {
            if (state is CategoryProductsLoading) {
              return const LinearLoadingState();
            } else if (state is CategoryProductsSuccess) {
              return _ProductList(products: state.productList);
            }
            return const SizedBox();
          },
        ),
      ),
    ));
  }
}

class _ProductList extends StatefulWidget {
  const _ProductList({required this.products});

  final List<ProductEntity> products;

  @override
  State<_ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<_ProductList> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent) {
        context
            .read<CategoryProductsBloc>()
            .add(CategoryProductsLoadMoreDate());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        physics: const BouncingScrollPhysics(),
        itemCount: widget.products.length,
        itemBuilder: (context, index) =>
            ProductItem(productEntity: widget.products[index]));
  }
}
