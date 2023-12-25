import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/exceptions.dart';
import '../../../common/token/Token.dart';
import '../../../data/repositoreis/auth/auth_repository.dart';


part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthRepository repository;
  bool isSave;

  AuthBloc({
    required this.repository,
    this.isSave = false,
  }) : super(AuthInitial(isSave)) {
    on<AuthEvent>((event, emit) async {
      if (event is AuthButtonIsClicked) {
        emit(AuthLoading(isSave));
        //await Future.delayed(const Duration(seconds: 2));
        try {
          var result = await repository.login(username: event.username, password: event.password);
          if (isSave) {
            await Token.savedUser(
                username: event.username, password: event.password);
            await Token.setToken(resultModel: result);
          } else {
            Token.appAuthModel = result;
            await Token.removeUserSaved();
          }

          emit(AuthSuccess(isSave));

        } catch (ex) {
          emit(
            AuthFailed(
              isSave: isSave,
              exception: ex is AppException
                  ? ex : AppException(
                      message: ex.toString(),
                      statusCode: 1,
                    ),
            ),
          );
        }
      } else if (event is AuthIsSave) {
        isSave = !isSave;
        emit(AuthInitial(isSave));
      }
    });
  }
}
