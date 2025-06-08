import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../core/constants.dart';
import '../../../core/widgets/main_button.dart';
import '../../home/screens/home_screen.dart';
import '../data/onboard_repository.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({super.key});

  static const routePath = '/OnboardScreen';

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  int index = 0;

  final pageController = PageController();

  void onNext() async {
    if (index == 2) {
      await context.read<OnboardRepository>().removeOnboard();
      if (mounted) {
        context.go(HomeScreen.routePath);
      }
    } else {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() {
        index++;
      });
    }
  }

  void onPageChanged(int value) {
    setState(() {
      index = value;
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).viewPadding.top,
          ),
          SizedBox(
            height: 44,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: SmoothPageIndicator(
                    controller: pageController,
                    count: 3,
                    effect: const SwapEffect(
                      dotHeight: 6,
                      dotWidth: 80,
                      spacing: 12,
                      dotColor: Color(0xffD5D5D5),
                      activeDotColor: Color(0xff095EF1),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: PageView(
              controller: pageController,
              onPageChanged: onPageChanged,
              children: const [
                Center(child: Text('1')),
                Center(child: Text('2')),
                Center(child: Text('3')),
              ],
            ),
          ),
          Container(
            height: 254,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            color: const Color(0xffF2F5F8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Center(
                  child: SmoothPageIndicator(
                    controller: pageController,
                    count: 3,
                    effect: const ExpandingDotsEffect(
                      dotHeight: 8,
                      dotWidth: 8,
                      spacing: 4,
                      dotColor: Color(0xffD5D5D5),
                      activeDotColor: Color(0xff095EF1),
                    ),
                  ),
                ),
                Text(
                  index == 0
                      ? 'Aaa'
                      : index == 1
                          ? 'Bbb'
                          : 'Ccc',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontFamily: AppFonts.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  index == 0
                      ? 'Aaaaaa'
                      : index == 1
                          ? 'Bbbbbb'
                          : 'Cccccc',
                  style: const TextStyle(
                    color: Color(0xff96A0A9),
                    fontSize: 14,
                    fontFamily: AppFonts.w500,
                  ),
                ),
                const Spacer(),
                MainButton(
                  title: 'Continue',
                  onPressed: onNext,
                ),
                const SizedBox(height: 44),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
