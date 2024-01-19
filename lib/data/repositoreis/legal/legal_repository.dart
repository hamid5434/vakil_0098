import '../../../model/legal/legal_child_model.dart';
import '../../../model/legal/legal_header_model.dart';
import '../../../model/legal/legal_madeh_model.dart';
import '../../../model/legal/legal_model.dart';
import '../../sources/legal/legal_data_source.dart';

abstract class ILegalRepository {
  Future<List<LegalHeaderModel>> legalHeader({String? where});

  Future<List<LegalsModel>> legals({String? where});

  Future<List<LegalChildModel>> legalChild({String? where});

  Future<List<LegalMadehModel>> legalMadeh({String? where});
}

class LegalRepository implements ILegalRepository {
  final ILegalDataSource dataSource;

  LegalRepository({required this.dataSource});

  @override
  Future<List<LegalHeaderModel>> legalHeader({String? where}) async {
    var list = dataSource.legalHeader(where: where);
    return list;
  }

  @override
  Future<List<LegalsModel>> legals({String? where}) async {
    var list = dataSource.legals(where: where);
    return list;
  }

  @override
  Future<List<LegalChildModel>> legalChild({String? where}) async {
    var list = dataSource.legalChild(where: where);
    return list;
  }

  @override
  Future<List<LegalMadehModel>> legalMadeh({String? where})async {
    var list = dataSource.legalMadeh(where: where);
    return list;
  }
}
