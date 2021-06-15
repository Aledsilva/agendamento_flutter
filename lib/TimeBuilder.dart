
import 'package:flutter/material.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:intl/intl.dart';


class SampleApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SampleAppState();
  }
}

class SampleAppState extends State<SampleApp> {
  DateTime alert;
  String captura = "Que horas são?";

  //BOBAGEM DAQUI ATÉÉÉ...
  String botaoNome = "BOOORA";
  dynamic estiloMisterio = TextStyle(fontSize: 18);
  dynamic estiloPokemon = TextStyle(fontSize: 30, fontWeight: FontWeight.bold,color: Colors.blue);
  dynamic corSim = Colors.yellow;
  dynamic corNao = Colors.grey;
  //AQUI

  String getSystemTime() {
    var now = new DateTime.now();
    return new DateFormat("HH:mm:ss").format(now);
  }

  @override
  void initState() {
    super.initState();
    alert = DateTime.now().add(Duration(seconds: 10));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Sample App'),
        ),
        body: TimerBuilder.scheduled([alert], builder: (context) {
          // This function will be called once the alert time is reached
          var now = DateTime.now();
          var reached = now.compareTo(alert) >= 0;
          final textStyle = Theme.of(context).textTheme.title;
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                TimerBuilder.periodic(Duration(seconds: 1), builder: (context) {
                  print("${getSystemTime()}");
                  return Text(
                    "${getSystemTime()}",
                    style: TextStyle(
                        color: Color(0xff2d386b),
                        fontSize: 30,
                        fontWeight: FontWeight.w700),
                  );
                }),
                SizedBox(height: 30),
                Text(captura,
                style: estiloMisterio,
                textAlign: TextAlign.center),
                SizedBox(height: 30),
                SizedBox(
                  height: 60,
                  width: 300,
                  child: RaisedButton(
                    child: Text(botaoNome,
                    style: TextStyle(fontSize: 25,color: corSim,
                    fontWeight: FontWeight.bold)),
                    color: corNao,
                    onPressed: (){
                      setState(() {
                        estiloMisterio = estiloPokemon;
                        captura = "Hora do show P**@!! \n \n-> ${getSystemTime().toString()} <-";
                        botaoNome = "BIRRLL!!";
                        corSim = Colors.red;
                        corNao = Colors.black;
                      });
                    },
                  ),
                )
              ],
            ),
          );
        }),
      ),
      theme: ThemeData(backgroundColor: Colors.white),
    );
  }
}

String formatDuration(Duration d) {
  String f(int n) {
    return n.toString().padLeft(2, '0');
  }

  // We want to round up the remaining time to the nearest second
  d += Duration(microseconds: 999999);
  return "${f(d.inMinutes)}:${f(d.inSeconds % 60)}";
}