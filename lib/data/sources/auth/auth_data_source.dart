import '../../../common/app_urls.dart';
import '../../services/service.dart';
import 'auth_model.dart';

abstract class IAuthDataSource {
  Future<AuthModel> login({required String username, required String password});

//Future<AppVersionNew?> versionControl();
}

class AuthDataSource implements IAuthDataSource {
  final IServices service;

  AuthDataSource({required this.service});

  @override
  Future<AuthModel> login(
      {required String username, required String password}) async {
    String url = AppUrls.login;
    var result = await service
        .postWithOutToken(url: url, body: {"email": username, "password": password});

    var auth = AuthModel.fromJson(result);

    return auth;
  }
}
