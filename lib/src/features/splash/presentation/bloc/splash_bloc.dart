import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/string_constants.dart';
import '../../../../core/utils/app_utils.dart';
import '../../../subscription/presentation/bloc/subscription_bloc.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc({required this.subscriptionBloc}) : super(SplashInitial()) {
    on<SplashNavigateEvent>(_onNavigate);
  }
  final SubscriptionBloc subscriptionBloc;

  Future<void> _onNavigate(SplashNavigateEvent event, Emitter<SplashState> emit) async {
    appState.getVersionInfo();

    if (appState.isLogin) {
      await subscriptionBloc.initializeHive();
      final hasSubscriptions = _hasStoredSubscriptions();

      await AppUtils.futureDelay(afterDelay: () {
        if (hasSubscriptions) {
          emit(SplashToSubscription());
        } else {
          emit(SplashToGetStarted());
        }
      });
    } else {
      emit(SplashFailure());
    }
  }

  bool _hasStoredSubscriptions() {
    final box = subscriptionBloc.subscriptionBox;
    return box.length > 1;
  }
}
