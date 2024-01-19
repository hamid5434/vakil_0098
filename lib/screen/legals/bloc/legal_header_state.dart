part of 'legal_header_bloc.dart';

@immutable
abstract class LegalHeaderState {}

class LegalHeaderInitial extends LegalHeaderState {}

class LegalHeaderGetLoading extends LegalHeaderState {}

class LegalHeaderGetSuccess extends LegalHeaderState {
  final List<LegalHeaderModel> listHeader;
  int id = 0;

  LegalHeaderGetSuccess({required this.listHeader, this.id = 0});
}

class LegalHeaderGetFailed extends LegalHeaderState {
  final AppException exception;

  LegalHeaderGetFailed({required this.exception});
}

//===================================================
class LegalsGetLoading extends LegalHeaderState {}

class LegalsGetSuccess extends LegalHeaderState {
  final List<LegalsModel> listLegals;

  LegalsGetSuccess({required this.listLegals});
}

class LegalsGetFailed extends LegalHeaderState {
  final AppException exception;

  LegalsGetFailed({required this.exception});
}

//===================================================
class LegalChildGetLoading extends LegalHeaderState {}

class LegalChildGetSuccess extends LegalHeaderState {
  final List<LegalChildModel> listLegalChild;
  int id = 0;

  LegalChildGetSuccess({required this.listLegalChild, this.id = 0});
}

class LegalChildGetFailed extends LegalHeaderState {
  final AppException exception;

  LegalChildGetFailed({required this.exception});
}

//===================================================
class LegalMadehGetLoading extends LegalHeaderState {}

class LegalMadehGetSuccess extends LegalHeaderState {
  final List<LegalMadehModel> listMadeh;
  int id = 0;

  LegalMadehGetSuccess({required this.listMadeh, this.id = 0});
}

class LegalMadehGetFailed extends LegalHeaderState {
  final AppException exception;

  LegalMadehGetFailed({required this.exception});
}
