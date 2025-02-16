import 'package:equatable/equatable.dart';

import '../../data/subscription_model.dart';

abstract class SubscriptionState extends Equatable {
  const SubscriptionState();

  @override
  List<Object?> get props => [];
}

class SubscriptionInitial extends SubscriptionState {}

class SubscriptionLoading extends SubscriptionState {}

class SubscriptionLoaded extends SubscriptionState {
  const SubscriptionLoaded(this.subscriptions);

  final List<SubscriptionModel> subscriptions;

  @override
  List<Object?> get props => [subscriptions];
}

class SubscriptionError extends SubscriptionState {
  const SubscriptionError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
