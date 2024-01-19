class LegalMadehModel {
  int? legalNumber;
  int? legalID;
  String? legalContent;
  int? id;
  bool selected = false;

  LegalMadehModel({
    this.legalNumber,
    this.legalID,
    this.legalContent,
    this.id,
    this.selected = false,
  });

  LegalMadehModel.fromJson(Map<String, dynamic> json) {
    legalNumber = json['legalNumber'] ?? 0;
    legalID = json['legalID'] ?? 0;
    legalContent = json['legalContent'] ?? '';
    id = json['id'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['legalNumber'] = legalNumber;
    data['legalID'] = legalID;
    data['legalContent'] = legalContent;
    data['id'] = id;
    return data;
  }
}

class LegalMadehList {
  final List<LegalMadehModel> list;

  LegalMadehList({required this.list});

  factory LegalMadehList.fromJson(List<dynamic> json) {
    return LegalMadehList(
        list: json.map((e) => LegalMadehModel.fromJson(e)).toList());
  }
}
