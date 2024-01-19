class LegalsModel {
  int? id;
  int? headerId;
  String? title;
  String? content;
  String? info;
  int? bookmark;
  num? position;
  int? order;
  bool selected = false;

  LegalsModel(
      {this.id,
      this.headerId,
      this.title,
      this.content,
      this.info,
      this.bookmark,
      this.position,
      this.order,
      this.selected = false});

  LegalsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    headerId = json['headerId'] ?? 0;
    title = json['title'] ?? '';
    content = json['content'] ?? '';
    info = json['info'] ?? '';
    bookmark = json['bookmark'] ?? 0;
    position = json['position'] ?? 0;
    order = json['order'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['headerId'] = headerId;
    data['title'] = title;
    data['content'] = content;
    data['info'] = info;
    data['bookmark'] = bookmark;
    data['position'] = position;
    data['order'] = order;
    return data;
  }
}

class LegalsList {
  final List<LegalsModel> list;

  LegalsList({required this.list});

  factory LegalsList.fromJson(List<dynamic> json) {
    return LegalsList(
        list: json.map((e) => LegalsModel.fromJson(e)).toList());
  }
}
