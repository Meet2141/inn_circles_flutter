import 'package:flutter/material.dart';

import '../../../../core/constants/color_constants.dart';
import '../../../../core/constants/size_constants.dart';
import '../../../../core/constants/string_constants.dart';

/// GetStartedBody - Display Body View of the the Get Started Screen
/// like manage sub and more content.
class GetStartedBody extends StatelessWidget {
  const GetStartedBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const Text(
              StringConstants.manageAllYourSub,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: ColorConstants.white,
              ),
              textAlign: TextAlign.center,
            ),
            vSpace(),
            const Text(
              StringConstants.keppRegularExpenses,
              style: TextStyle(
                fontSize: 16,
                color: ColorConstants.secondary,
              ),
              textAlign: TextAlign.center,
            ),
            vSpace(32),
          ],
        ),
      ),
    );
  }
}
