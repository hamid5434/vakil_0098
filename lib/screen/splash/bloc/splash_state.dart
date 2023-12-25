part of 'splash_bloc.dart';

abstract class SplashState {
  const SplashState();
}

class SplashInitial extends SplashState {
  const SplashInitial();
}

class SplashGetVersionState extends SplashState {
  final AppVersionModel? version;
  final bool flag;

  const SplashGetVersionState({
    this.version,
    required this.flag,
  });
}

class SplashLoginState extends SplashState {
  final bool flag;
  final AppVersionModel? version;

  const SplashLoginState({
    required this.flag,
    this.version,
  });
}

class SplashLoginErrorState extends SplashState {
  final bool flag;
  final AppVersionModel? version;
  final AppException exception;

  const SplashLoginErrorState({
    required this.flag,
    required this.exception,
    this.version,
  });
}

class AppVersion extends SplashState {
  final AppVersionModel? version;

  const AppVersion(this.version);
}

class AppVersionError extends SplashState {
  final AppException exception;

  const AppVersionError({required this.exception});
}
