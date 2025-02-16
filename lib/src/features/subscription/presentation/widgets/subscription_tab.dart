import 'package:flutter/material.dart';

import '../../../../core/constants/color_constants.dart';
import '../../../../core/constants/size_constants.dart';
import '../../../../core/extensions/gesture_extensions.dart';
import '../../../../core/utils/bottom_sheet_utils.dart';
import '../../data/subscription_model.dart';
import 'subscription_bottomsheet.dart';
import 'subscription_tab_view.dart';

/// SubscriptionTab - Display Tab on Subscription screen
class SubscriptionTab extends StatelessWidget {
  SubscriptionTab({
    super.key,
    required this.subscriptionList,
  });

  final List<SubscriptionModel> subscriptionList;

  final selectedIndex = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedIndex,
      builder: (context, value, child) {
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
                        color: selectedIndex.value == i ? ColorConstants.primary : ColorConstants.secondary[800],
                      ),
                      child: Text(
                        subscriptionList[i].name,
                        style: const TextStyle(fontSize: 16, color: ColorConstants.white),
                      ),
                    ).onPressedWithHaptic(() {
                      selectedIndex.value = i;
                    });
                  },
                ),
              ),
              vSpace(20),
              SubscriptionTabView(
                subscriptions: subscriptionList[selectedIndex.value].subList,
              ),
            ],
          ),
        );
      },
    );
  }
}
