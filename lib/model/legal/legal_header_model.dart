class LegalHeaderModel {
  int? id;
  String? title;
  int? order;
  bool selected = false;

  LegalHeaderModel({this.id, this.title, this.order,this.selected = false});

  LegalHeaderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    title = json['title'] ?? '';
    order = json['order'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['order'] = order;
    return data;
  }
}

class LegalHeaderList {
  final List<LegalHeaderModel> list;

  LegalHeaderList({required this.list});

  factory LegalHeaderList.fromJson(List<dynamic> json) {
    return LegalHeaderList(
        list: json.map((e) => LegalHeaderModel.fromJson(e)).toList());
  }
}
