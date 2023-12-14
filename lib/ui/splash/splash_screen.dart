import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:seven_learn_exercise_three/common/constants.dart';
import 'package:seven_learn_exercise_three/ui/product/product_list_screen.dart';
import 'package:seven_learn_exercise_three/ui/util/page_slide_transition.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => Future.delayed(
        const Duration(seconds: Constants.splashSecond),
        () => Navigator.of(context)
            .pushReplacement(PageSlideTransition(const ProductListScreen())),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var primary = Theme.of(context).colorScheme.primary;
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: SpinKitWaveSpinner(
          size: 100,
          color: primary,
          duration: const Duration(seconds: Constants.splashSecond),
          waveColor: primary.withOpacity(.5),
        ),
      ),
    ));
  }
}
