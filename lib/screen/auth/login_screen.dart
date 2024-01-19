import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vakil_0098/data/repositoreis/auth/auth_repository.dart';
import 'package:vakil_0098/data/services/http_service.dart';
import 'package:vakil_0098/screen/root/root_screen.dart';

import '../../common/common.dart';
import '../../common/theme.dart';
import '../../common/version/get_version.dart';
import '../../data/sources/auth/auth_data_source.dart';
import '../home/home_screen.dart';
import '../widgets/widgets.dart';
import 'bloc/auth_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isShow = false;
  TextEditingController usernameController = TextEditingController(text: 'h_khobani@yahoo.com');
  TextEditingController passwordController = TextEditingController(text: '111');

  late AuthBloc bloc;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    usernameController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthRepository(
        dataSource: AuthDataSource(
          service: HttpServices(),
        ),
      ),
      child: BlocProvider<AuthBloc>(
        create: (context) {
          bloc = AuthBloc(repository: context.read<AuthRepository>());
          return bloc;
        },
        child: SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: BlocListener<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is AuthSuccess) {
                      //Common.showToast(msg: 'ok', pos: 'top', context: context);
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const RootScreen(),
                        ),
                      );
                    }
                    if (state is AuthFailed) {
                      String msg = state.exception.message.toString();
                      if (state.exception.statusCode == 400) {
                        msg = 'نام کاربری یا رمز عبور اشتباه است';
                      }
                      Common.showToast(msg: msg, pos: 'top', context: context);
                    }
                  },
                  child: BlocBuilder<AuthBloc, AuthState>(
                    buildWhen: (previous, current) {
                      return current is AuthLoading ||
                          current is AuthInitial ||
                          current is AuthSuccess ||
                          current is AuthFailed;
                    },
                    builder: (context, state) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        Center(
                                  child: Image.asset(
                                    'assets/images/logo_law.png',
                                   // color: LightThemeColors.primaryColor,
                                    width: 250,
                                    height: 250,
                                  ),
                                ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 8,
                            ),
                            child: Text(
                              'نام کاربری',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 4,
                            ),
                            child: CustomTextField(
                              hint: 'نام کاربری',
                              prefixIcon: Icons.person_outline,
                              suffixIcon: Icons.remove_red_eye_sharp,
                              prefixIconSize: 24,
                              controller: usernameController,
                              textInputAction: TextInputAction.next,
                              callbackPrefixIcon: () {},
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 8,
                            ),
                            child: Text(
                              'رمز عبور',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: PasswordTextField(
                              controller: passwordController,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  borderRadius: BorderRadius.circular(10),
                                  onTap: () {
                                    BlocProvider.of<AuthBloc>(context).add(
                                      const AuthIsSave(),
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        state.isSave
                                            ? Icons.check_box
                                            : Icons.check_box_outline_blank,
                                        color: state.isSave
                                            ? Theme.of(context)
                                                .colorScheme
                                                .primary
                                            : Theme.of(context)
                                                .colorScheme
                                                .secondaryContainer,
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        'بخاطر سپردن',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondaryContainer,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  'فراموشی رمز عبور',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondaryContainer,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 8, right: 8, top: 25, bottom: 8),
                            child: ElevatedButton(
                              onPressed: () {
                                BlocProvider.of<AuthBloc>(context).add(
                                  AuthButtonIsClicked(
                                    username: usernameController.text,
                                    password: passwordController.text,
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size.fromHeight(40),
                                backgroundColor: LightThemeColors.primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                              ),
                              child: state is AuthLoading
                                  ? SizedBox(
                                      width: 30,
                                      height: 30,
                                      child: CircularProgressIndicator(
                                        color:
                                            Theme.of(context).colorScheme.surface,
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : Text(
                                      'ورود',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                            color: LightThemeColors.surface,
                                          ),
                                    ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'قانون تایم',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'نسخه  ',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                      GetVersion.appVersion == null ? const SizedBox():
                                      Text(
                                        '${GetVersion.appVersion!.version}-${GetVersion.appVersion!.buildNumber}',
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                            ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  var radius = 5.0;

  @override
  Path getClip(Size size) {
    // Path path = Path();
    // path.lineTo(size.width , size.height);
    //
    // path.lineTo(size.width , 0.0);
    // return path;

    double radius = 50;
    double pi = 3.14;

    Path path = Path()
      ..lineTo(size.width - radius, 0)
      ..arcTo(
          Rect.fromPoints(
              Offset(size.width - radius, 0), Offset(size.width, radius)),
          // Rect
          1.5 * pi, // Start engle
          0.5 * pi, // Sweep engle
          true) // direction clockwise
      ..lineTo(size.width, size.height - radius)
      ..arcTo(
          Rect.fromCircle(
              center: Offset(size.width - radius, size.height - radius),
              radius: radius),
          0,
          0.5 * pi,
          false)
      ..lineTo(radius, size.height)
      ..arcTo(Rect.fromLTRB(0, size.height - radius, radius, size.height),
          0.5 * pi, 0.5 * pi, false)
      ..lineTo(0, radius)
      ..arcTo(const Rect.fromLTWH(0, 0, 70, 100), 1 * pi, 0.5 * pi, false)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
