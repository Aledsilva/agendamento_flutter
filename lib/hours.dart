class Hours {
  String hour;
  bool active;

  Hours({this.hour, this.active});

  Hours.fromJson(Map<String, dynamic> json) {
    hour = json['hour'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hour'] = this.hour;
    data['active'] = this.active;
    return data;
  }
}