class LegalChildModel {
  int? id;
  int? legalId;
  int? headerId;
  String? title;
  String? content;
  String? info;
  int? bookmark;
  num? position;
  int? order;
  bool selected = false;

  LegalChildModel({
    this.id,
    this.legalId,
    this.headerId,
    this.title,
    this.content,
    this.info,
    this.bookmark,
    this.position,
    this.order,
    this.selected = false,
  });

  LegalChildModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    legalId = json['legal_id'] ?? 0;
    headerId = json['header_id'] ?? 0;
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
    data['legal_id'] = legalId;
    data['header_id'] = headerId;
    data['title'] = title;
    data['content'] = content;
    data['info'] = info;
    data['bookmark'] = bookmark;
    data['position'] = position;
    data['order'] = order;
    return data;
  }
}

class LegalChildList {
  final List<LegalChildModel> list;

  LegalChildList({required this.list});

  factory LegalChildList.fromJson(List<dynamic> json) {
    return LegalChildList(
        list: json.map((e) => LegalChildModel.fromJson(e)).toList());
  }
}
