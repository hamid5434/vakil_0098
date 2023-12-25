part of 'splash_bloc.dart';

abstract class SplashEvent {
  const SplashEvent();
}

class SplashVersionEvent extends SplashEvent {}

class SplashLoginEvent extends SplashEvent {}
