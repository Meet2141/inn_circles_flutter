import 'package:flutter/material.dart';

import '../../../core/constants/color_constants.dart';
import '../../../core/constants/image_constants.dart';

class SubscriptionModel {
  factory SubscriptionModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionModel(
      name: json['name'] ?? '',
      subList:
          (json['subList'] as List<dynamic>?)?.map((sub) => SubModel.fromJson(sub as Map<String, dynamic>)).toList() ??
              [],
    );
  }

  SubscriptionModel({
    required this.name,
    required this.subList,
  });

  final String name;
  final List<SubModel> subList;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'subList': subList.map((sub) => sub.toJson()).toList(),
    };
  }
}

class SubModel {
  factory SubModel.fromJson(Map<String, dynamic> json) {
    return SubModel(
      name: json['name'] ?? '',
      price: json['price'] ?? '',
      color: Color(json['color'] ?? 0xFFFFFFFF),
      textColor: json['textColor'] != null ? Color(json['textColor']) : null,
      image: json['image'] ?? '',
      isSelected: json['isSelected'] ?? false,
    );
  }

  SubModel({
    required this.name,
    required this.price,
    required this.color,
    this.textColor,
    required this.image,
    this.isSelected = false,
  });

  final String name;
  final String price;
  final Color color;
  final Color? textColor;
  final String image;
  bool isSelected;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'color': color.r,
      'textColor': textColor?.r,
      'image': image,
      'isSelected': isSelected,
    };
  }
}

List<SubscriptionModel> defaultSubscriptionList = [
  SubscriptionModel(name: 'All Sub', subList: defaultSubList),
];

final List<SubModel> defaultSubList = [
  SubModel(
    name: 'Figma',
    price: '\$12 / month',
    color: ColorConstants.yellow,
    textColor: ColorConstants.black,
    image: ImageConstants.icIcon3,
  ),
  SubModel(
    name: 'HBO Max',
    price: '\$9.99 / month',
    color: ColorConstants.pink,
    textColor: ColorConstants.white,
    image: ImageConstants.icIcon4,
  ),
  SubModel(
    name: 'Spotify',
    price: '\$8 / month',
    color: ColorConstants.green,
    textColor: ColorConstants.white,
    image: ImageConstants.icIcon5,
  ),
  SubModel(
    name: 'PlayStation Plus',
    price: '\$67.57 / year',
    color: ColorConstants.blue,
    textColor: ColorConstants.white,
    image: ImageConstants.icIcon2,
  ),
  SubModel(
    name: 'YouTube',
    price: '\$11.99 / month',
    color: ColorConstants.red,
    textColor: ColorConstants.white,
    image: ImageConstants.icIcon6,
  ),
];
