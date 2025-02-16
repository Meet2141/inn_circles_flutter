import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/get_started/presentation/get_started.dart';
import '../../features/splash/presentation/screens/splash_screen.dart';
import '../../features/subscription/presentation/subscription_screen.dart';
import '../constants/routing_constants.dart';

///RoutingConfig - Handle Routing of application
class RoutingConfiguration {
  static GoRouter router = GoRouter(
    initialLocation: RoutingConstants.initial,
    routes: <GoRoute>[
      GoRoute(
        path: RoutingConstants.initial,
        name: RoutingConstants.splash,
        builder: (context, state) {
          return const SplashScreen();
        },
      ),
      GoRoute(
        path: RoutingConstants.initial + RoutingConstants.getStarted,
        name: RoutingConstants.getStarted,
        builder: (context, state) {
          return const GetStarted();
        },
      ),
      GoRoute(
        path: RoutingConstants.initial + RoutingConstants.subscription,
        name: RoutingConstants.subscription,
        builder: (context, state) {
          return const SubscriptionScreen();
        },
      ),
    ],
    observers: <NavigatorObserver>[
      BotToastNavigatorObserver(),
    ],
  );
}
