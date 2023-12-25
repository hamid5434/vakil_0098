import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vakil_0098/data/repositoreis/auth/auth_repository.dart';
import 'package:vakil_0098/data/services/service.dart';
import 'package:vakil_0098/data/sources/auth/auth_data_source.dart';

import '../../common/common.dart';
import '../../common/token/Token.dart';
import '../auth/login_screen.dart';
import '../root/root_screen.dart';
import 'bloc/splash_bloc.dart';


class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Theme.of(context).colorScheme.background,
      body: RepositoryProvider(
        create: (context) => AuthRepository(
          dataSource: AuthDataSource(
            service: Services(),
          ),
        ),
    child: BlocProvider(
        create: (context) {
          final bloc = SplashBloc(repository: context.read<AuthRepository>());
          bloc.stream.forEach((state) async {
            if (state is SplashLoginState) {
              if (state.flag) {
                //Navigator.pushReplacementNamed(context, AppName.HOME);
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const RootScreen(),
                  ),
                );
              } else {
                // Navigator.pushReplacementNamed(context, AppName.LOGIN);
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              }
            } else if (state is SplashLoginErrorState) {
              await Token.removeUserSaved();
              Common.showToast(msg: state.exception.message, pos: 'top',context: context);
            } else if (state is AppVersion) {
              // Navigator.of(context).pushReplacement(
              //   MaterialPageRoute(
              //     builder: (context) => UpdateAppScreen(
              //       versionServer: state.version,
              //     ),
              //   ),
              // );
            }
            else if(state is AppVersionError){
              Common.showToast(msg: state.exception.message,context: context);
            }
          });
          bloc.add(SplashVersionEvent());
          return bloc;
        },
        child: BlocBuilder<SplashBloc, SplashState>(
          builder: (context, state) {
            if (state is SplashGetVersionState) {
              return _body(context, state);
            } else if (state is SplashGetVersionState) {
              return Center(
                child: OutlinedButton(
                  onPressed: () {
                    BlocProvider.of<SplashBloc>(context).add(
                      SplashVersionEvent(),
                    );
                  },
                  child: Text(
                    'Check App!',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              );
            }
            else if(state is AppVersionError){
              return Center(
                child: Text('خطا در خواندن نسخه سرور\n${state.exception.statusCode}'),
              );
            }
            else if (state is SplashLoginState) {
              return _body(context, state);
            } else if (state is SplashLoginErrorState) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      state.exception.message,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                      child: Text(
                        'سعی مجدد',
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
),
    );
  }

  Widget _body(BuildContext context, SplashState state) {
    return Center(
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 180,
                height: 180,
                child: Image.asset('assets/images/logo_law.png'),
              ),
              Text(
                'لطفا منتظر بمانید...',
                textDirection: TextDirection.rtl,
                style: Theme.of(context).textTheme.headline4!.copyWith(
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SpinKitThreeBounce(
                color: Theme.of(context).colorScheme.onSurface,
                size: 20.0,
              ),
              const SizedBox(
                height: 30,
              ),
              Container()
            ],
          ),
          Positioned(
            bottom: 2,
            left: 5,
            child: (state is SplashLoginState && state.flag == false)
                ? Container(
              width: 20,
              height: 20,
              padding: const EdgeInsets.all(5),
              child: CircularProgressIndicator(
                strokeWidth: 1.5,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            )
                : Text(
              state is SplashLoginState
                  ? '${state.version!.version}-${state.version!.buildNumber}'
                  : '',
              style: Theme.of(context).textTheme.headline6!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface),
            ),
          ),
        ],
      ),
    );
  }
}
