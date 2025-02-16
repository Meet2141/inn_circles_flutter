import 'package:flutter/material.dart';

import '../../../../core/constants/color_constants.dart';
import '../../../../core/constants/image_constants.dart';
import '../../../../core/shared/image_viewer.dart';
import '../../../../core/utils/enums.dart';

/// GetStartedHeader - Display Header/Center View of the the Get Started Screen
class GetStartedHeader extends StatefulWidget {
  const GetStartedHeader({super.key});

  @override
  State<GetStartedHeader> createState() => _GetStartedHeaderState();
}

class _GetStartedHeaderState extends State<GetStartedHeader> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final List<Animation<double>> _fadeAnimations;

  final List<String> icons = [
    ImageConstants.icIcon1,
    ImageConstants.icIcon2,
    ImageConstants.icIcon3,
    ImageConstants.icIcon4,
    ImageConstants.icIcon5,
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _fadeAnimations = List.generate(icons.length, (index) {
      double start = index == 2 ? 0.0 : (index == 1 || index == 3 ? 0.3 : 0.6);
      return Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(start, 1.0, curve: Curves.easeInOut),
        ),
      );
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          child: Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: ColorConstants.green.withValues(alpha: 0.25),
                  blurRadius: 50,
                  spreadRadius: 30,
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: icons.length,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            itemBuilder: (context, index) {
              return AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Transform.scale(
                    scale: index == 2 ? 1.2 : 1,
                    child: Opacity(
                      opacity: _fadeAnimations[index].value,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: ColorConstants.white, width: 1),
                        ),
                        child: CircleAvatar(
                          backgroundColor: ColorConstants.white,
                          radius: 22,
                          child: ImageViewer(
                            imageData: ImageData(
                              type: ImageType.asset,
                              src: icons[index],
                            ),
                            height: 38,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
