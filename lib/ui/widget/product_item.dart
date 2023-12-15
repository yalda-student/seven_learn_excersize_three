import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:seven_learn_exercise_three/common/extensions.dart';
import 'package:seven_learn_exercise_three/data/product.dart';
import 'package:seven_learn_exercise_three/ui/product/product_detail_screen.dart';
import 'package:seven_learn_exercise_three/ui/util/page_slide_transition.dart';
import 'package:seven_learn_exercise_three/ui/widget/state/loading_state.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key, required this.productEntity});

  final ProductEntity productEntity;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () => Navigator.of(context).push(PageSlideTransition(
          ProductDetailScreen(productEntity: productEntity))),
      child: Container(
        height: 145,
        margin: const EdgeInsets.only(bottom: 22),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Theme.of(context).colorScheme.background,
            boxShadow: const [
              BoxShadow(
                color: Color(0xffE6E5E5),
                offset: Offset(0, 3),
                blurRadius: 15,
              )
            ]),
        child: Row(
          children: [
            _ProductThumbnail(imageUrl: productEntity.thumbnail),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      flex: 3,
                      child: Text(productEntity.title,
                          style: textTheme.labelLarge)),
                  Expanded(
                      flex: 2,
                      child: Text(
                        productEntity.category,
                        style: textTheme.bodySmall,
                      )),
                  Text(
                    productEntity.price.dollar,
                    style: textTheme.bodySmall,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _ProductThumbnail extends StatelessWidget {
  const _ProductThumbnail({required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: CachedNetworkImage(
        fit: BoxFit.cover,
        imageUrl: imageUrl,
        width: 110,
        height: 110,
        progressIndicatorBuilder: (context, url, progress) =>
            const LoadingState(),
      ),
    );
  }
}
