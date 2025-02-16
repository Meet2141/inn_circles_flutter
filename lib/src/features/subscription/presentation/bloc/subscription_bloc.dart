import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../data/subscription_model.dart';
import 'subscription_event.dart';
import 'subscription_state.dart';

class SubscriptionBloc extends Bloc<SubscriptionEvent, SubscriptionState> {
  SubscriptionBloc() : super(SubscriptionInitial()) {
    on<LoadSubscriptions>(_onLoadSubscriptions);
    on<AddSubscription>(_onAddSubscription);
  }

  static const String hiveBoxName = 'subscriptionsBox';
  late Box<SubscriptionModel> subscriptionBox;

  Future<void> initializeHive() async {
    subscriptionBox = await Hive.openBox<SubscriptionModel>(hiveBoxName);
    if (subscriptionBox.isEmpty) {
      for (var sub in defaultSubscriptionList) {
        subscriptionBox.put(sub.name, sub);
      }
    }
    add(LoadSubscriptions());
  }

  void _onLoadSubscriptions(LoadSubscriptions event, Emitter<SubscriptionState> emit) {
    emit(SubscriptionLoading());
    final subscriptions = subscriptionBox.values.toList();
    emit(SubscriptionLoaded(subscriptions));
  }

  Future<void> _onAddSubscription(AddSubscription event, Emitter<SubscriptionState> emit) async {
    await subscriptionBox.put(event.subscription.name, event.subscription);
    final subscriptions = subscriptionBox.values.toList();
    emit(SubscriptionLoaded(subscriptions));
  }
}
