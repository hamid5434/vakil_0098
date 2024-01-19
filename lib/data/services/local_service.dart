import 'db_helper.dart';

abstract class ILocalService {
  Future<dynamic> select({required String query});

  Future<int> delete({required String query});

  Future<int> update({required String query});

  Future<int> insert({required String query});
}

class LocalService implements ILocalService {
  @override
  Future<int> delete({required String query}) {
    throw UnimplementedError();
  }

  @override
  Future<int> insert({required String query}) {
    throw UnimplementedError();
  }

  @override
  Future select({required String query}) {
    return DbHelper().select(sql: query);
  }

  @override
  Future<int> update({required String query}) {
    throw UnimplementedError();
  }
}
