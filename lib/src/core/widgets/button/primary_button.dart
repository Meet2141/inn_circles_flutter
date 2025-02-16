import 'package:flutter/material.dart';

import '../../constants/color_constants.dart';
import '../../constants/size_constants.dart';
import '../../shared/image_viewer.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.imageData,
    this.style,
    this.backgroundColor,
    this.foregroundColor,
    this.fontSize,
    this.iconSize = 16,
    this.padding,
    this.iconAlignment = IconAlignment.start,
    this.expanded = false,
    this.verticallyExpanded = false,
    this.horizontallyExpanded = false,
  });

  final VoidCallback onPressed;
  final String text;
  final ImageData? imageData;
  final IconAlignment iconAlignment;
  final ButtonStyle? style;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? fontSize;
  final double? iconSize;
  final EdgeInsets? padding;
  final bool expanded;
  final bool verticallyExpanded;
  final bool horizontallyExpanded;

  @override
  Widget build(BuildContext context) {
    Widget child = ElevatedButton.icon(
      onPressed: onPressed,
      style: style ??
          ElevatedButton.styleFrom(
            backgroundColor: backgroundColor ?? ColorConstants.primary,
            foregroundColor: foregroundColor ?? ColorConstants.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(SizeConstants.extraSmall / 2),
            ),
            padding: padding,
          ),
      label: Builder(
        builder: (context) {
          final child = Padding(
            padding: imageData != null ? const EdgeInsets.only(left: SizeConstants.medium / 2) : EdgeInsets.zero,
            child: Text(
              text,
              style: TextStyle(
                fontSize: fontSize,
              ),
            ),
          );
          if (expanded) {
            return Row(
              children: [
                hSpace(12),
                Expanded(child: child),
              ],
            );
          }
          return child;
        },
      ),
      icon: imageData == null
          ? null
          : ImageViewer(
              imageData: imageData!,
              height: SizeConstants.large,
              width: SizeConstants.large,
            ),
      iconAlignment: iconAlignment,
    );
    if (verticallyExpanded) {
      return Column(
        children: [
          Expanded(child: child),
        ],
      );
    } else if (horizontallyExpanded) {
      return Row(
        children: [
          Expanded(child: child),
        ],
      );
    }
    return child;
  }
}
