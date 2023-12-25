import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../../common/exceptions.dart';
import '../../../common/token/Token.dart';
import '../../../common/version/get_version.dart';
import '../../../data/repositoreis/auth/auth_repository.dart';
import '../../../model/version/app_version_model.dart';

part 'splash_event.dart';

part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final IAuthRepository repository;
  AppVersionModel? version;

  SplashBloc({required this.repository}) : super(const SplashInitial()) {
    on<SplashEvent>((event, emit) async {
      if (event is SplashVersionEvent) {
        emit(const SplashGetVersionState(flag: false));
        //await Future.delayed(const Duration(seconds: 3));
        version = await GetVersion.getVersion();
        emit(SplashGetVersionState(version: version, flag: true));

        // try {
        //   var versionServer = await repository.versionControl();
        //
        //   //===========================version control=====================================
        //   if (versionServer == null) {
        //     emit(AppVersion(versionServer));
        //     return;
        //   } else {
        //     var versionApp = GetVersion.appVersion;
        //     if (versionServer.aPPVERSIONNEW!.trim() !=
        //             versionApp!.version.toString().trim() &&
        //         versionServer.fOURCEUPDATE == true) {
        //       emit(AppVersion(versionServer));
        //       return;
        //     }
        //   }
        // } catch (ex) {
        //   emit(AppVersionError(
        //       exception: ex is AppException ? ex : AppException()));
        //   return;
        // }

        //================================================================

        var (username, password) = await Token.checkUserSaved();
        if (username == null || password == null) {
          emit(SplashLoginState(flag: false, version: version));
        } else {
          try {
            var auth = await repository.login(
                username: username, password: password);
            await Token.savedUser(username: username, password: password);
            await Token.setToken(resultModel: auth);

            emit(SplashLoginState(flag: true, version: version));
          } catch (ex) {
            emit(SplashLoginErrorState(
                flag: true,
                version: version,
                exception: ex is AppException ? ex : AppException()));
          }
        }
      }
    });
  }
}
