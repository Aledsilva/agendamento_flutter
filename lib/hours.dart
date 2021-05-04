class Hours {
  String hour;
  bool active;
  bool hasBeenPressed = true;

  Hours({this.hour, this.active, this.hasBeenPressed});

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