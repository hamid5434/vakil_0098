import '../../sources/auth/auth_data_source.dart';
import '../../../model/auth/auth_model.dart';

abstract class IAuthRepository {
  Future<AuthModel> login({required String username, required String password});
}

class AuthRepository implements IAuthRepository {
  final IAuthDataSource dataSource;

  AuthRepository({required this.dataSource});

  @override
  Future<AuthModel> login(
      {required String username, required String password}) async {
    AuthModel result =
        await dataSource.login(username: username, password: password);
    return result;
  }
}
