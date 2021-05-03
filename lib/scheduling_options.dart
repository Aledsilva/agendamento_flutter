import 'package:agendamento_flutter/hours.dart';
import 'package:agendamento_flutter/option_uses.dart';
import 'package:agendamento_flutter/spaces.dart';


class SchedulingOptions {
  List<Spaces> spaces;
  List<Hours> hours;
  List<OptionUses> optionUses;

  SchedulingOptions({this.spaces, this.hours, this.optionUses});

  SchedulingOptions.fromJson(Map<String, dynamic> json) {
    if (json['spaces'] != null) {
      spaces = new List<Spaces>();
      json['spaces'].forEach((v) {
        spaces.add(new Spaces.fromJson(v));
      });
    }
    if (json['hours'] != null) {
      hours = new List<Hours>();
      json['hours'].forEach((v) {
        hours.add(new Hours.fromJson(v));
      });
    }
    if (json['option_uses'] != null) {
      optionUses = new List<OptionUses>();
      json['option_uses'].forEach((v) {
        optionUses.add(new OptionUses.fromJson(v));
      });
    }
  }
}