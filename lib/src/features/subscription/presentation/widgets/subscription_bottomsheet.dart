import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/color_constants.dart';
import '../../../../core/constants/size_constants.dart';
import '../../../../core/constants/string_constants.dart';
import '../../../../core/extensions/gesture_extensions.dart';
import '../../../../core/shared/image_viewer.dart';
import '../../../../core/utils/enums.dart';
import '../../../../core/utils/toast_utils.dart';
import '../../../../core/widgets/button/primary_button.dart';
import '../../../../core/widgets/textfield/primary_input_text.dart';
import '../../data/subscription_model.dart';
import '../bloc/subscription_bloc.dart';
import '../bloc/subscription_event.dart';

class SubscriptionBottomSheet extends StatefulWidget {
  const SubscriptionBottomSheet({super.key});

  @override
  SubscriptionBottomSheetState createState() => SubscriptionBottomSheetState();
}

class SubscriptionBottomSheetState extends State<SubscriptionBottomSheet> {
  final TextEditingController _controller = TextEditingController();
  final Map<int, bool> _isAnimating = {};

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: constraints.maxHeight * 0.8),
            child: ColoredBox(
              color: ColorConstants.black,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        StringConstants.addACategory,
                        style: TextStyle(color: ColorConstants.white, fontSize: 18),
                      ),
                    ),
                    vSpace(10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: PrimaryInputText(
                        hintText: StringConstants.enterAName,
                        controller: _controller,
                        fillColor: ColorConstants.secondary[900],
                        onChanged: (value) {},
                      ),
                    ),
                    vSpace(20),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        StringConstants.selectSubscription,
                        style: TextStyle(color: ColorConstants.white, fontSize: 16),
                      ),
                    ),
                    vSpace(10),
                    Expanded(
                      child: ListView.builder(
                        itemCount: defaultSubList.length,
                        itemBuilder: (context, index) {
                          final subscription = defaultSubList[index];

                          return TweenAnimationBuilder<double>(
                            duration: const Duration(milliseconds: 150),
                            tween: Tween<double>(
                              begin: 1.0,
                              end: _isAnimating[index] == true ? 0.95 : 1.0,
                            ),
                            curve: Curves.easeOut,
                            builder: (context, scale, child) {
                              return Transform.scale(
                                scale: scale,
                                child: child,
                              );
                            },
                            child: GestureDetector(
                              onTapDown: (_) {
                                setState(() => _isAnimating[index] = true);
                              },
                              onTapUp: (_) {
                                Future.delayed(const Duration(milliseconds: 150), () {
                                  setState(() {
                                    _isAnimating[index] = false;
                                    subscription.isSelected = !subscription.isSelected;
                                  });
                                });
                              },
                              onTapCancel: () => setState(() => _isAnimating[index] = false),
                              child: ListTile(
                                leading: Container(
                                  height: 40,
                                  width: 40,
                                  padding: const EdgeInsets.all(4),
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: ColorConstants.white,
                                  ),
                                  child: ImageViewer(
                                    imageData: ImageData(
                                      type: ImageType.asset,
                                      src: subscription.image,
                                    ),
                                    height: 40,
                                    width: 40,
                                  ),
                                ),
                                title: Text(
                                  subscription.name,
                                  style: const TextStyle(color: ColorConstants.white),
                                ),
                                trailing: Transform.scale(
                                  scale: 1.2,
                                  child: Checkbox(
                                    shape: const CircleBorder(),
                                    value: subscription.isSelected,
                                    activeColor: ColorConstants.blue,
                                    onChanged: (_) =>
                                        setState(() => subscription.isSelected = !subscription.isSelected),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: PrimaryButton(
                        horizontallyExpanded: true,
                        onPressed: () {
                          final selectedSubs = defaultSubList.where((e) => e.isSelected).toList();
                          if (_controller.text.isEmpty) {
                            ToastUtils.showFailed(message: 'Please enter name');
                          } else if (selectedSubs.isEmpty) {
                            ToastUtils.showFailed(message: 'Please select subscription');
                          } else {
                            context.read<SubscriptionBloc>().add(AddSubscription(
                                  SubscriptionModel(name: _controller.text, subList: selectedSubs),
                                ));
                            context.pop();
                          }
                        },
                        text: StringConstants.save,
                      ),
                    ),
                  ],
                ).onPressedWithHaptic(() => FocusScope.of(context).unfocus()),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
