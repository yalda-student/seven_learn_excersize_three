import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:seven_learn_exercise_three/data/datasource/category_datasource.dart';
import 'package:seven_learn_exercise_three/data/datasource/product_datasource.dart';
import 'package:seven_learn_exercise_three/data/product.dart';
import 'package:seven_learn_exercise_three/ui/add_product/add_product_screen.dart';
import 'package:seven_learn_exercise_three/ui/util/page_slide_transition.dart';
import 'package:seven_learn_exercise_three/ui/widget/app_icon_button.dart';
import 'package:seven_learn_exercise_three/ui/widget/category_item.dart';
import 'package:seven_learn_exercise_three/ui/widget/product_item.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {

    RemoteProductDataSource().getAllProducts(2).then((value) => log(value.length.toString()));
    RemoteCategoryDataSource().getAllCategories().then((value) => log(value.toString()));

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Products'),
          leading: AppIconButton(
              onTap: () {}, icon: SvgPicture.asset('assets/images/Menu.svg')),
          actions: [
            AppIconButton(
                onTap: () => Navigator.of(context)
                    .push(PageSlideTransition(const AddProductScreen())),
                icon: SvgPicture.asset('assets/images/Add.svg'))
          ],
        ),
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) =>
              [const SliverToBoxAdapter(child: SizedBox())],
          physics: const BouncingScrollPhysics(),
          body: const Column(
            children: [
              _CategoryList(categories: [
                'fff, #fff',
                'yalda',
                'laptops',
                'laptops',
                'laptops',
                'laptops'
              ]),
              _ProductList(products: [])
            ],
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
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        itemCount: categories.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            //ToDo
          },
          child: CategoryItem(title: categories[index]),
        ),
      ),
    );
  }
}

class _ProductList extends StatelessWidget {
  const _ProductList({required this.products});

  final List<ProductEntity> products;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          physics: const NeverScrollableScrollPhysics(),
          itemCount: products.length,
          itemBuilder: (context, index) => const ProductItem()),
    );
  }
}
