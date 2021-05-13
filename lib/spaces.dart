class Spaces {
  int id;
  String name;
  String code;
  String typeSpace;
  String description;
  Null optionUse;
  Null infra;
  Null addressId;
  bool active;
  int accountId;
  String createdAt;
  String updatedAt;
  bool expanded;

  Spaces({this.id,
    this.name,
    this.code,
    this.typeSpace,
    this.description,
    this.optionUse,
    this.infra,
    this.addressId,
    this.active,
    this.accountId,
    this.createdAt,
    this.updatedAt});

  Spaces.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    typeSpace = json['type_space'];
    description = json['description'];
    optionUse = json['option_use'];
    infra = json['infra'];
    addressId = json['address_id'];
    active = json['active'];
    accountId = json['account_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}