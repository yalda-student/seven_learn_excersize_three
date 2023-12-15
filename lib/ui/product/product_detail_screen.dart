import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:seven_learn_exercise_three/common/extensions.dart';
import 'package:seven_learn_exercise_three/data/product.dart';
import 'package:seven_learn_exercise_three/ui/widget/category_item.dart';
import 'package:seven_learn_exercise_three/ui/widget/state/loading_state.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, required this.productEntity});

  final ProductEntity productEntity;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  flexibleSpace: _AppBar(imageList: productEntity.images),
                  expandedHeight: 250,
                  automaticallyImplyLeading: false,
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        Row(
                          children: [
                            Text(
                              productEntity.title,
                              style: GoogleFonts.montserrat(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 10)
                          ],
                        ),
                        const SizedBox(height: 19),
                        Text(
                          productEntity.price.dollar,
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodySmall,
                        ),
                        const SizedBox(height: 29),
                        Text(
                          productEntity.description,
                          style: GoogleFonts.montserrat(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 63),
                        Row(
                          children: [
                            CategoryItem(title: productEntity.category),
                            CategoryItem(title: productEntity.brand),
                          ],
                        )
                      ])),
                )
              ],
            )));
  }
}

class _AppBar extends StatefulWidget {
  final List<String> imageList;

  const _AppBar({required this.imageList});

  @override
  State<_AppBar> createState() => _AppBarState();
}

class _AppBarState extends State<_AppBar> {
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme
        .of(context)
        .colorScheme;

    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.expand,
      alignment: Alignment.center,
      children: [
        CarouselSlider.builder(
          itemCount: widget.imageList.length,
          itemBuilder: (context, index, realIndex) =>
              CachedNetworkImage(
                imageUrl: widget.imageList[realIndex],
                fit: BoxFit.cover,
                progressIndicatorBuilder: (context, url, progress) =>
                const LoadingState(),
              ),
          options: CarouselOptions(
              viewportFraction: 1,
              enableInfiniteScroll: false,
              enlargeCenterPage: true,
              initialPage: activeIndex,
              enlargeStrategy: CenterPageEnlargeStrategy.zoom,
              onPageChanged: (index, reason) => _changeSlide(index)),
        ),
        Positioned(
          bottom: 2,
          child: widget.imageList.length > 1
              ? _Indicator(
              colorScheme: colorScheme,
              activeIndex: activeIndex,
              imageCount: widget.imageList.length)
              : const SizedBox(),
        )
      ],
    );
  }

  void _changeSlide(int index) => setState(() => activeIndex = index);
}

class _Indicator extends StatelessWidget {
  const _Indicator({
    required this.colorScheme,
    required this.activeIndex,
    required this.imageCount,
  });

  final ColorScheme colorScheme;
  final int activeIndex;
  final int imageCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
          color: colorScheme.onPrimary,
          boxShadow: const [
            BoxShadow(
              color: Color(0xffEDEBF4),
              offset: Offset(0, 3),
              blurRadius: 3,
            )
          ],
          borderRadius: BorderRadius.circular(8)),
      child: AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: imageCount,
        duration: const Duration(milliseconds: 750),
        effect: ScaleEffect(
            scale: 1.4,
            dotColor: const Color(0xffB4BEDF),
            activeDotColor: colorScheme.primary,
            spacing: 5,
            dotHeight: 5,
            dotWidth: 5),
      ),
    );
  }
}
