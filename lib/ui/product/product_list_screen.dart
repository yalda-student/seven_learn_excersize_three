import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:seven_learn_exercise_three/common/di.dart';
import 'package:seven_learn_exercise_three/data/product.dart';
import 'package:seven_learn_exercise_three/ui/add_product/add_product_screen.dart';
import 'package:seven_learn_exercise_three/ui/category_products/category_products_screen.dart';
import 'package:seven_learn_exercise_three/ui/product/bloc/product_list_bloc.dart';
import 'package:seven_learn_exercise_three/ui/util/page_slide_transition.dart';
import 'package:seven_learn_exercise_three/ui/widget/app_icon_button.dart';
import 'package:seven_learn_exercise_three/ui/widget/category_item.dart';
import 'package:seven_learn_exercise_three/ui/widget/product_item.dart';
import 'package:seven_learn_exercise_three/ui/widget/state/error_state.dart';
import 'package:seven_learn_exercise_three/ui/widget/state/linear_loading_state.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Products'),
          leading: AppIconButton(
              onTap: () {}, icon: SvgPicture.asset('assets/images/Menu.svg')),
          actions: [
            AppIconButton(
                onTap: () => Navigator.of(context)
                    .push(PageSlideTransition(AddProductScreen())),
                icon: SvgPicture.asset('assets/images/Add.svg'))
          ],
        ),
        body: BlocProvider(
          create: (context) =>
              ProductListBloc(di(), di())..add(ProductListInit()),
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) =>
                [const SliverToBoxAdapter(child: SizedBox())],
            physics: const BouncingScrollPhysics(),
            body: Column(
              children: [
                BlocBuilder<ProductListBloc, ProductListState>(
                  builder: (context, state) => Visibility(
                    visible: state is ProductListLoading,
                    child: const LinearLoadingState(),
                  ),
                ),
                BlocBuilder<ProductListBloc, ProductListState>(
                  buildWhen: (previous, current) =>
                      current is! ProductListLoading &&
                      current is! ProductListSuccessProduct &&
                      current is! ProductListErrorProduct,
                  builder: (context, state) {
                    if (state is ProductListSuccessCategory) {
                      return _CategoryList(categories: state.categoryList);
                    } else if (state is ProductListErrorCategory) {
                      return ErrorState(errorMessage: state.errorMessage);
                    } else if (state is ProductListLoading) {
                      return const SizedBox();
                    }
                    return const ErrorState(errorMessage: 'Invalid State');
                  },
                ),
                BlocBuilder<ProductListBloc, ProductListState>(
                  buildWhen: (previous, current) =>
                      current is! ProductListSuccessCategory &&
                      current is! ProductListLoading &&
                      current is! ProductListErrorCategory,
                  builder: (context, state) {
                    if (state is ProductListSuccessProduct) {
                      return _ProductList(products: state.productList);
                    } else if (state is ProductListErrorProduct) {
                      return ErrorState(errorMessage: state.errorMessage);
                    } else if (state is ProductListLoading) {
                      return const SizedBox();
                    }
                    return const ErrorState(errorMessage: 'Invalid State');
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CategoryList extends StatelessWidget {
  const _CategoryList({required this.categories});

  final List<String> categories;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: categories.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () => Navigator.of(context).push(PageSlideTransition(
              CategoryProductsScreen(categoryName: categories[index]))),
          child: CategoryItem(title: categories[index]),
        ),
      ),
    );
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
        context.read<ProductListBloc>().add(ProductListLoadMoreData());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          controller: _scrollController,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          physics: const ClampingScrollPhysics(),
          itemCount: widget.products.length,
          itemBuilder: (context, index) =>
              ProductItem(productEntity: widget.products[index])),
    );
  }
}
