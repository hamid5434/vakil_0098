import 'package:flutter/cupertino.dart';
import 'package:vakil_0098/data/services/local_service.dart';

import '../../../model/legal/legal_child_model.dart';
import '../../../model/legal/legal_header_model.dart';
import '../../../model/legal/legal_madeh_model.dart';
import '../../../model/legal/legal_model.dart';

abstract class ILegalDataSource {
  Future<List<LegalHeaderModel>> legalHeader({String? where});

  Future<List<LegalsModel>> legals({String? where});

  Future<List<LegalChildModel>> legalChild({String? where});
  Future<List<LegalMadehModel>> legalMadeh({String? where});
}

class LegalDataSource implements ILegalDataSource {
  final ILocalService service;

  LegalDataSource({required this.service});

  @override
  Future<List<LegalHeaderModel>> legalHeader({String? where}) async {
    String query = 'select * from [legal_headers] ${where ?? ''}';
    var result = await service.select(query: query);
    List<LegalHeaderModel> list = LegalHeaderList.fromJson(result).list;
    return list;
  }

  @override
  Future<List<LegalsModel>> legals({String? where}) async {
    String query = 'select * from [legals] ${where ?? ''}';

    var result = await service.select(query: query);
    List<LegalsModel> list = LegalsList.fromJson(result).list;
    return list;
  }

  @override
  Future<List<LegalChildModel>> legalChild({String? where}) async {
    String query = 'select * from [legal_childs] ${where ?? ''}';
    var result = await service.select(query: query);
    List<LegalChildModel> list = LegalChildList.fromJson(result).list;
    return list;
  }

  @override
  Future<List<LegalMadehModel>> legalMadeh({String? where}) async{
    String query = 'select * from [legalmadeh] ${where ?? ''}';
    var result = await service.select(query: query);
    List<LegalMadehModel> list = LegalMadehList.fromJson(result).list;
    return list;
  }
}
