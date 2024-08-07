import 'package:flutter/material.dart';

class PageSlideTransition extends PageRouteBuilder {
  final dynamic page;

  PageSlideTransition(this.page)
      : super(
            transitionDuration: const Duration(seconds: 1),
            reverseTransitionDuration: const Duration(seconds: 1),
            pageBuilder: (context, animation, secondaryAnimation) => page,
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              var tween =
                  Tween<Offset>(begin: const Offset(-1, 0), end: Offset.zero)
                      .chain(CurveTween(curve: Curves.linear));
              var offsetAnimation = animation.drive(tween);
              return SlideTransition(
                position: offsetAnimation,
                child: child,
              );
            });
}
