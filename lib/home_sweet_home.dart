import 'package:agendamento_flutter/TimeBuilder.dart';
import 'package:agendamento_flutter/clock_teste.dart';
import 'package:agendamento_flutter/eventos/eventos_replica.dart';
import 'package:agendamento_flutter/maskTeste.dart';
import 'package:flutter/material.dart';

class HomeSweetHome extends StatefulWidget {
  @override
  _HomeSweetHomeState createState() => _HomeSweetHomeState();
}

class _HomeSweetHomeState extends State<HomeSweetHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(height: 200,),
                  RaisedButton(
                    child: Text("Relógio Clock"),
                    onPressed: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Clock()));
                    },
                  ),
                  RaisedButton(
                    child: Text("Relógio TimeBuilder"),
                    onPressed: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  TimeClock()));
                    },
                  ),
                  RaisedButton(
                    child: Text("Mascára"),
                    onPressed: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  MaskTeste()));
                    },
                  ),
                  RaisedButton(
                    child: Text("Réplica Eventos"),
                    onPressed: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  EventosReplica()));
                    },
                  ),
                ],
              ),
            ),
        ),
      ),
    );
  }
}
