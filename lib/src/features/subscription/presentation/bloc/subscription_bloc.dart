// ignore_for_file: prefer_single_quotes

import 'package:bloc/bloc.dart';

import '../../data/subscription_model.dart';
import 'subscription_event.dart';
import 'subscription_state.dart';

class SubscriptionBloc extends Bloc<SubscriptionEvent, SubscriptionState> {
  SubscriptionBloc() : super(SubscriptionInitial()) {
    on<LoadSubscriptions>(_onLoadSubscriptions);
    on<AddSubscription>(_onAddSubscription);
  }

  Future<void> _onLoadSubscriptions(LoadSubscriptions event, Emitter<SubscriptionState> emit) async {
    emit(SubscriptionLoading());
    try {
      final subscriptions = defaultSubscriptionList;
      emit(SubscriptionLoaded(subscriptions));
    } catch (e) {
      emit(const SubscriptionError('Failed to load subscriptions.'));
    }
  }

  Future<void> _onAddSubscription(AddSubscription event, Emitter<SubscriptionState> emit) async {
    if (state is SubscriptionLoaded) {
      final currentState = state as SubscriptionLoaded;
      final updatedList = List<SubscriptionModel>.from(currentState.subscriptions)..add(event.subscription);

      emit(SubscriptionLoaded(updatedList));
    } else {
      add(LoadSubscriptions());
    }
  }
}
