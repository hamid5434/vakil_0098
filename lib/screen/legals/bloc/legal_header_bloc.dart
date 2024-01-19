import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../common/exceptions.dart';
import '../../../data/repositoreis/legal/legal_repository.dart';
import '../../../model/legal/legal_child_model.dart';
import '../../../model/legal/legal_header_model.dart';
import '../../../model/legal/legal_madeh_model.dart';
import '../../../model/legal/legal_model.dart';

part 'legal_header_event.dart';

part 'legal_header_state.dart';

class LegalHeaderBloc extends Bloc<LegalHeaderEvent, LegalHeaderState> {
  final ILegalRepository repository;
  List<LegalHeaderModel> listHeader = [];
  LegalHeaderModel? selectedHeader;
  List<LegalsModel> listLegals = [];
  List<LegalChildModel> listChild = [];
  List<LegalMadehModel> listMadeh = [];

  LegalHeaderBloc({required this.repository}) : super(LegalHeaderInitial()) {
    on<LegalHeaderEvent>((event, emit) async {
      if (event is LegalHeaderGetEvent) {
        emit(LegalHeaderGetLoading());
        try {
          listHeader = await repository.legalHeader();
          selectedHeader = listHeader[0];
          selectedHeader!.selected = true;
          emit(LegalHeaderGetSuccess(
              listHeader: listHeader, id: selectedHeader!.id!));
        } catch (ex) {
          emit(LegalHeaderGetFailed(
              exception: ex is AppException ? ex : AppException()));
        }
      } else if (event is LegalHeaderSelectedEvent) {
        for (int i = 0; i < listHeader.length; i++) {
          listHeader[i].selected = false;
        }
        int index = listHeader.indexWhere((element) => element.id == event.id);
        listHeader[index].selected = true;
        selectedHeader = listHeader[index];
        emit(LegalHeaderGetSuccess(
            listHeader: listHeader, id: selectedHeader!.id!));
      } else if (event is LegalsGetEvent) {
        emit(LegalsGetLoading());
        try {
          listLegals = await repository.legals(
              where: 'WHERE header_id = ${event.headerId} ');
          emit(LegalsGetSuccess(listLegals: listLegals));
        } catch (ex) {
          emit(LegalsGetFailed(
              exception: ex is AppException ? ex : AppException()));
        }
      } else if (event is LegalChildsGetEvent) {
        emit(LegalChildGetLoading());
        try {
          listChild = await repository.legalChild(
              where: 'WHERE legal_id = ${event.legalId} ');
          emit(LegalChildGetSuccess(listLegalChild: listChild,id: listChild.isNotEmpty ? listChild[0].id! : 0));
        } catch (ex) {
          emit(LegalChildGetFailed(
              exception: ex is AppException ? ex : AppException()));
        }
      } else if (event is LegalChildSelectedEvent) {
        for (int i = 0; i < listChild.length; i++) {
          listChild[i].selected = false;
        }
        int index = listChild.indexWhere((element) => element.id == event.id);
        listChild[index].selected = true;
        emit(LegalChildGetSuccess(
            listLegalChild: listChild, id: listChild[index].id!));
      } else if (event is LegalMadehGetEvent) {
        emit(LegalMadehGetLoading());
        try {
          listMadeh = await repository.legalMadeh(
              where: 'WHERE legalnumber = ${event.legalnumber} ');
          listMadeh[0].selected = true;
          emit(LegalMadehGetSuccess(listMadeh: listMadeh,id: listMadeh[0].id!));
        } catch (ex) {
          emit(LegalMadehGetFailed(
              exception: ex is AppException ? ex : AppException()));
        }
      } else if (event is LegalMadehSelectedEvent) {
        for (int i = 0; i < listMadeh.length; i++) {
          listMadeh[i].selected = false;
        }
        int index = listMadeh.indexWhere((element) => element.id == event.id);
        listMadeh[index].selected = true;
        emit(LegalMadehGetSuccess(
            listMadeh: listMadeh, id: listMadeh[index].id!));
      }
    });
  }
}
