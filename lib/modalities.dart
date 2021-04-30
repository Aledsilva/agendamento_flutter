import 'option_uses.dart';

class Modalities {
  List<OptionUses> optionUses;

  Modalities({this.optionUses});

  Modalities.fromJson(Map<String, dynamic> json) {
    if (json['option_uses'] != null) {
      optionUses = new List<OptionUses>();
      json['option_uses'].forEach((v) {
        optionUses.add(new OptionUses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.optionUses != null) {
      data['option_uses'] = this.optionUses.map((v) => v.toJson()).toList();
    }
    return data;
  }
}