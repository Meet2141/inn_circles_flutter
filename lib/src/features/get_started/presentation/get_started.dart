import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/color_constants.dart';
import '../../../core/constants/routing_constants.dart';
import '../../../core/constants/size_constants.dart';
import '../../../core/constants/string_constants.dart';
import '../../../core/widgets/button/primary_button.dart';
import 'widgets/get_started_body.dart';
import 'widgets/get_started_header.dart';

/// GetStarted - Display Get Started Screen with animation and buttons
class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.black,
      body: Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: MediaQuery.paddingOf(context).bottom,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            const GetStartedHeader(),
            vSpace(32),
            const GetStartedBody(),
            PrimaryButton(
              onPressed: () {
                context.goNamed(RoutingConstants.subscription);
              },
              text: StringConstants.getStarted,
              horizontallyExpanded: true,
            ),
          ],
        ),
      ),
    );
  }
}
