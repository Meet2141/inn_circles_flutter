import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../core/constants/color_constants.dart';
import '../../../../core/constants/size_constants.dart';
import '../../data/subscription_model.dart';

/// SubscriptionTabView - Display Tab View on Subscription Screen
class SubscriptionTabView extends StatefulWidget {
  const SubscriptionTabView({
    super.key,
    required this.subscriptions,
  });

  final List<SubModel> subscriptions;

  @override
  State<SubscriptionTabView> createState() => _SubscriptionTabViewState();
}

class _SubscriptionTabViewState extends State<SubscriptionTabView> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final List<SubModel> _animatedSubscriptions = [];

  @override
  void initState() {
    super.initState();
    _resetAndAnimate();
  }

  @override
  void didUpdateWidget(covariant SubscriptionTabView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.subscriptions != widget.subscriptions) {
      _resetAndAnimate();
    }
  }

  void _resetAndAnimate() {
    if (_animatedSubscriptions.isNotEmpty) {
      for (int i = _animatedSubscriptions.length - 1; i >= 0; i--) {
        _listKey.currentState?.removeItem(
          i,
          (context, animation) => _buildAnimatedItem(_animatedSubscriptions[i], animation, i),
          duration: const Duration(milliseconds: 200),
        );
      }
    }

    Future.delayed(const Duration(milliseconds: 300), () {
      _animatedSubscriptions.clear();

      for (int i = 0; i < widget.subscriptions.length; i++) {
        Future.delayed(Duration(milliseconds: i * 200), () {
          if (mounted) {
            setState(() {
              if (i <= _animatedSubscriptions.length) {
                _animatedSubscriptions.add(widget.subscriptions[i]);
                _listKey.currentState?.insertItem(i);
              }
            });
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AnimatedList(
        key: _listKey,
        padding: EdgeInsets.zero,
        initialItemCount: _animatedSubscriptions.length,
        itemBuilder: (context, i, animation) {
          return _buildAnimatedItem(_animatedSubscriptions[i], animation, i);
        },
      ),
    );
  }

  Widget _buildAnimatedItem(SubModel subscription, Animation<double> animation, int index) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(-1, 0),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutExpo,
      )),
      child: FadeTransition(
        opacity: animation,
        child: Transform.translate(
          offset: Offset(0, -index * 20.0),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 1),
            padding: const EdgeInsets.all(16),
            height: 120,
            decoration: BoxDecoration(
              color: Color(subscription.color),
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
                      subscription.name,
                      style: TextStyle(
                        color: subscription.textColor != null
                            ? Color(subscription.textColor!)
                            : ColorConstants.white.withValues(alpha: 0.8),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    vSpace(4),
                    Text(
                      subscription.price,
                      style: TextStyle(
                        color: subscription.textColor != null
                            ? Color(subscription.textColor!)
                            : ColorConstants.white.withValues(alpha: 0.8),
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
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      subscription.image,
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
