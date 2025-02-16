import 'package:flutter/material.dart';

import '../../../core/constants/color_constants.dart';
import '../../../core/constants/string_constants.dart';
import '../../../core/extensions/scaffold_extension.dart';
import '../../../core/shared/text_widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.paddingOf(context).top,
        bottom: MediaQuery.paddingOf(context).bottom,
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: TextWidgets(
              text: '${StringConstants.welcome} ${StringConstants.developerName}',
              style: TextStyle(fontSize: 16),
            ),
          )
        ],
      ),
    ).baseScaffold(
        appBar: AppBar(
      backgroundColor: ColorConstants.primary,
      title: const TextWidgets(
        text: StringConstants.home,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: ColorConstants.white,
        ),
      ),
    ));
  }
}
