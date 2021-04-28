import 'package:agendamento_flutter/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/intl.dart';
import 'package:scrolling_day_calendar/scrolling_day_calendar.dart';

void main(){

  //Intl.defaultLocale = 'pt_BR';
  //initializeDateFormatting();

  runApp(MaterialApp(
    home: HomeScreen()
  ));
}