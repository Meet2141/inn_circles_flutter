import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/string_constants.dart';
import 'bloc/subscription_bloc.dart';
import 'bloc/subscription_state.dart';
import 'widgets/subscription_tab.dart';

/// SubscriptionScreen - Display Subscription Screen
class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

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
            return SubscriptionTab(
              subscriptionList: state.subscriptions,
            );
          } else {
            return const Center(
              child: Text(
                StringConstants.noSubscriptions,
              ),
            );
          }
        },
      ),
    );
  }
}
