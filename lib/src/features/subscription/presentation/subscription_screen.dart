import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/color_constants.dart';
import '../../../core/constants/size_constants.dart';
import '../../../core/constants/string_constants.dart';
import '../../../core/extensions/gesture_extensions.dart';
import '../../../core/utils/bottom_sheet_utils.dart';
import '../data/subscription_model.dart';
import 'bloc/subscription_bloc.dart';
import 'bloc/subscription_state.dart';
import 'widgets/subscription_bottomsheet.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SubscriptionBloc, SubscriptionState>(
        buildWhen: (previous, current) {
          return previous != current;
        },
        builder: (context, state) {
          if (state is SubscriptionLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SubscriptionLoaded) {
            return _buildTab(state.subscriptions);
          }
          return const Center(
            child: Text(
              StringConstants.noSubscriptions,
            ),
          );
        },
      ),
    );
  }

  Widget _buildTab(List<SubscriptionModel> subscriptionList) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: MediaQuery.paddingOf(context).top,
        bottom: MediaQuery.paddingOf(context).bottom,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 40,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemCount: subscriptionList.length + 1,
              separatorBuilder: (c, i) => hSpace(10),
              itemBuilder: (c, i) {
                if (i == subscriptionList.length) {
                  return CircleAvatar(
                    backgroundColor: ColorConstants.secondary[800],
                    child: const Icon(Icons.add, color: ColorConstants.white),
                  ).onPressedWithHaptic(() {
                    BottomSheetUtils.showCustomBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) {
                        for (var e in defaultSubList) {
                          e.isSelected = false;
                        }
                        return const SubscriptionBottomSheet();
                      },
                    );
                  });
                }
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: selectedIndex == i ? ColorConstants.primary : ColorConstants.secondary[800],
                  ),
                  child: Text(
                    subscriptionList[i].name,
                    style: const TextStyle(fontSize: 16, color: ColorConstants.white),
                  ),
                ).onPressedWithHaptic(() {
                  setState(() {
                    selectedIndex = i;
                  });
                });
              },
            ),
          ),
          vSpace(20),
          _buildSubList(subscriptionList[selectedIndex].subList),
        ],
      ),
    );
  }

  Widget _buildSubList(List<SubModel> subscriptions) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemCount: subscriptions.length,
        itemBuilder: (c, i) {
          return Transform.translate(
            offset: Offset(0, -i * 20.0),
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 1),
              padding: const EdgeInsets.all(16),
              height: 120,
              decoration: BoxDecoration(
                color: subscriptions[i].color,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        subscriptions[i].name,
                        style: TextStyle(
                          color: subscriptions[i].textColor ?? ColorConstants.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      vSpace(4),
                      Text(
                        subscriptions[i].price,
                        style: TextStyle(
                          color: subscriptions[i].textColor ?? ColorConstants.white.withValues(alpha: 0.8),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorConstants.white,
                        border: Border.all(
                          color: ColorConstants.white,
                        )),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        subscriptions[i].image,
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
