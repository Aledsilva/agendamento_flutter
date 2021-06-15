import 'package:agendamento_flutter/eventos/calendario_dario.dart';
import 'package:agendamento_flutter/eventos/lista_lista.dart';
import 'package:flutter/material.dart';

class EventosReplica extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(child: Text("Tab1")),
                Tab(child: Text("Tab2"))
              ],
            ),
            title: Text('Tabs Demo'),
          ),
          body: TabBarView(
            children: [
              DynamicEvent(),
              Lista()
              //Calendario(title: "Kiko"),
            ],
          ),
        ),
      ),
    );
  }
}