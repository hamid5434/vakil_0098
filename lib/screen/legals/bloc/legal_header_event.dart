part of 'legal_header_bloc.dart';

@immutable
abstract class LegalHeaderEvent {}

class LegalHeaderGetEvent extends LegalHeaderEvent {
  String? id;

  LegalHeaderGetEvent({this.id});
}

class LegalHeaderSelectedEvent extends LegalHeaderEvent {
  int? id;

  LegalHeaderSelectedEvent({this.id});
}

//=====================================
class LegalsGetEvent extends LegalHeaderEvent {
  String? headerId;

  LegalsGetEvent({this.headerId});
}

//=====================================
class LegalChildsGetEvent extends LegalHeaderEvent {
  String? legalId;

  LegalChildsGetEvent({this.legalId});
}
class LegalChildSelectedEvent extends LegalHeaderEvent {
  int? id;

  LegalChildSelectedEvent({this.id});
}
//=====================================
class LegalMadehGetEvent extends LegalHeaderEvent {
  String? legalnumber;

  LegalMadehGetEvent({this.legalnumber});
}
class LegalMadehSelectedEvent extends LegalHeaderEvent {
  int? id;

  LegalMadehSelectedEvent({this.id});
}
