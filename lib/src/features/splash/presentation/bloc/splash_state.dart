part of 'splash_bloc.dart';

sealed class SplashState {
  const SplashState();
}

final class SplashInitial extends SplashState {}

final class SplashToGetStarted extends SplashState {}

final class SplashToSubscription extends SplashState {}

final class SplashFailure extends SplashState {}
