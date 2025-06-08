import 'package:flutter/material.dart';

import '../../../core/constants.dart';
import '../../../core/widgets/main_button.dart';

class NoInternet extends StatelessWidget {
  const NoInternet({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'No Internet Connection',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: AppFonts.w700,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Check your network and tap Retry to try again',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontFamily: AppFonts.w400,
              ),
            ),
            const SizedBox(height: 16),
            MainButton(
              title: 'Retry',
              width: 180,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
