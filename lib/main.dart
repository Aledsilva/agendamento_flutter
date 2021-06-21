import 'package:agendamento_flutter/TimeBuilder.dart';
import 'package:agendamento_flutter/clock_teste.dart';
import 'package:agendamento_flutter/eventos/calendario_dario.dart';
import 'package:agendamento_flutter/eventos/schedule_details.dart';
import 'package:agendamento_flutter/home_sweet_home.dart';
import 'eventos/eventos_replica.dart';
import 'package:agendamento_flutter/home_screen.dart';
import 'package:agendamento_flutter/maskTeste.dart';
import 'package:agendamento_flutter/mercado_pago.dart';
import 'package:agendamento_flutter/reserve_screen.dart';
import 'package:agendamento_flutter/teste_camera.dart';
import 'package:agendamento_flutter/teste_home.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

void main(){

  Intl.defaultLocale = 'pt_BR';
  initializeDateFormatting();
  runApp(MaterialApp(
    home: DynamicEvent()
  ));

}