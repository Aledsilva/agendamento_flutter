import 'package:agendamento_flutter/home_screen.dart';
import 'package:agendamento_flutter/maskTeste.dart';
import 'package:agendamento_flutter/mercado_pago.dart';
import 'package:agendamento_flutter/reserve_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

void main(){

  Intl.defaultLocale = 'pt_BR';
  initializeDateFormatting();
  runApp(MaterialApp(
    home: MaskTeste()
  ));

}