class AuthModel {
  String? accessToken;
  String? tokenType;
  List<User>? user;

  AuthModel({this.accessToken, this.tokenType, this.user});

  AuthModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    if (json['user'] != null) {
      user = <User>[];
      json['user'].forEach((v) {
        user!.add( User.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['access_token'] = accessToken;
    data['token_type'] = tokenType;
    if (user != null) {
      data['user'] = user!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class User {
  int? id;
  String? firstName;
  String? lastName;
  String? birthDay;
  String? education;
  String? active;
  String? phoneNumber;
  String? email;
  String? updatedAt;
  String? createdAt;

  User(
      {this.id,
        this.firstName,
        this.lastName,
        this.birthDay,
        this.education,
        this.active,
        this.phoneNumber,
        this.email,
        this.updatedAt,
        this.createdAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    birthDay = json['birth_day'];
    education = json['education'];
    active = json['active'];
    phoneNumber = json['phone_number'];
    email = json['email'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['birth_day'] = birthDay;
    data['education'] = education;
    data['active'] = active;
    data['phone_number'] = phoneNumber;
    data['email'] = email;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    return data;
  }
}
