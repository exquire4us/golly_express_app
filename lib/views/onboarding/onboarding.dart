import 'package:flutter/material.dart';
import 'package:golly_express_app/utils/constants.dart';
import 'package:golly_express_app/views/login/login.dart';
import 'package:golly_express_app/widgets/buttons.dart';
import 'package:golly_express_app/widgets/texts.dart';
import 'package:lottie/lottie.dart';

class Onboarding extends StatefulWidget {
  final _pages = [
    _FirstPage(),
    _SecondPage(),
    _ThirdPage(),
  ];

  Onboarding({Key? key}) : super(key: key);

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  var _currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: PageView(
              children: widget._pages
                  .map((page) => _OnboardingPage(
                        title: page.title,
                        description: page.description,
                        backgroundColor: page.backgroundColor,
                        currentPage: _currentPage,
                        pageCount: widget._pages.length,
                        lottieAsset: page.lottieAsset,
                        lottieSize: page.lottieSize,
                      ))
                  .toList(),
              onPageChanged: (value) => setState(() {
                _currentPage = value;
              }),
            ),
          ),
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 32.0,
            ),
            child: SecondaryButton(
                buttonText: StringResource.getStarted,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()));
                }),
          )
        ],
      ),
    );
  }
}

class _OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final Color backgroundColor;
  final String lottieAsset;
  final int currentPage;
  final int pageCount;
  final Size? lottieSize;

  const _OnboardingPage({
    Key? key,
    required this.title,
    required this.description,
    required this.backgroundColor,
    required this.currentPage,
    required this.pageCount,
    required this.lottieAsset,
    Size? lottieSize,
  })  : lottieSize = lottieSize ?? const Size(300, 300),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: backgroundColor,
        child: Column(
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                alignment: Alignment.bottomCenter,
                child: Lottie.asset(
                  lottieAsset,
                  reverse: true,
                  animate: true,
                  repeat: true,
                  height: lottieSize?.height,
                  frameRate: FrameRate(60),
                ),
              ),
            )),
            Container(
                color: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                child: Column(
                  children: [
                    _PageIndicator(
                      currentPage: currentPage,
                      pageCount: pageCount,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextTitleLarge(
                      text: title,
                      textColor: Colors.black,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    TextDescription(
                      text: description,
                      textColor: GollyColors.greyShade100,
                    ),
                  ],
                )),
          ],
        ));
  }
}

class _PageIndicator extends StatefulWidget {
  final int currentPage;
  final int pageCount;

  const _PageIndicator(
      {Key? key, required this.currentPage, required this.pageCount})
      : super(key: key);

  @override
  State<_PageIndicator> createState() => _PageIndicatorState();
}

class _PageIndicatorState extends State<_PageIndicator> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.pageCount, (index) {
        return Container(
          width: widget.currentPage == index ? 26 : 6,
          height: 6,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
              color: widget.currentPage == index
                  ? GollyColors.greenShade1100
                  : GollyColors.greyShade300,
              borderRadius: BorderRadius.circular(4)),
        );
      }),
    );
  }
}

abstract class _PageValues {
  String get title;
  String get description;
  Color get backgroundColor;
  String get lottieAsset;
  Size get lottieSize;
}

class _FirstPage extends _PageValues {
  @override
  final String title = StringResource.seamlessShipping;
  @override
  final String description = StringResource.weSimplify;
  @override
  final Color backgroundColor = GollyColors.greenShade400;
  @override
  final String lottieAsset = GollyLottieResource.shoppingCart;
  @override
  final Size lottieSize = const Size(300, 300);
}

class _SecondPage extends _PageValues {
  @override
  final String title = StringResource.yourPersonalWarehouse;
  @override
  final String description = StringResource.shopFromYourFavorite;
  @override
  final Color backgroundColor = GollyColors.greenShade400;
  @override
  final String lottieAsset = GollyLottieResource.warehouse;
  @override
  final Size lottieSize = const Size(200, 200);
}

class _ThirdPage extends _PageValues {
  @override
  String title = StringResource.deliveryTheWayYouWant;
  @override
  final String description = StringResource.receiveYourPackages;
  @override
  final Color backgroundColor = GollyColors.greenShade400;
  @override
  final String lottieAsset = GollyLottieResource.airCargo;
  @override
  final Size lottieSize = const Size(300, 300);
}
