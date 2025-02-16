import 'package:equatable/equatable.dart';

import '../../data/subscription_model.dart';

abstract class SubscriptionEvent extends Equatable {
  const SubscriptionEvent();

  @override
  List<Object?> get props => [];
}

class LoadSubscriptions extends SubscriptionEvent {}

class AddSubscription extends SubscriptionEvent {
  const AddSubscription(this.subscription);
  final SubscriptionModel subscription;

  @override
  List<Object?> get props => [subscription];
}
