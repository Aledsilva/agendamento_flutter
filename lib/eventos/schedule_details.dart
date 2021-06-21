

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScheduleDetails extends StatefulWidget {
  @override
  _ScheduleDetailsState createState() => _ScheduleDetailsState();
}

class _ScheduleDetailsState extends State<ScheduleDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vai ser o nome do evento"),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 230,
              width: 400,
              child: Image.network(
                  "https://i0.wp.com/galaxianerd.com/wp-content/uploads/2018/05/DB-FighterZ_2018_05-21-18_006-750x375.jpg"),
            ),
            Container(
              width: 400,
              height: 50,
              color: Colors.grey[400],
              child: Center(
                child: Text(
                  'Vai ser o nome do evento também',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Container(
                  width: 400,
                  height: 220,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: TextField(
                          decoration: InputDecoration(hintText: "Teste"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: TextField(
                          decoration: InputDecoration(hintText: "Teste"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0, bottom: 16),
                        child: TextField(
                          decoration: InputDecoration(hintText: "Teste"),
                        ),
                      ),
                    ],
                  ),
              ),
            ),
            SizedBox(
              width: 350,
              height: 35,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)
                ),
                child: Text("REMOVER INSCRIÇÃO",
                style: TextStyle(fontSize: 12),),
                color: Colors.red,
                textColor: Colors.white,
                onPressed: (){},
              ),
            ),
            Padding(padding: EdgeInsets.all(16)),
            SizedBox(
              width: 350,
              height: 35,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)
                ),
                child: Text("ARQUIVOS DISPONÍVEIS",
                style: TextStyle(fontSize: 12),),
                color: Colors.orange,
                textColor: Colors.white,
                onPressed: (){},
              ),
            ),
            Padding(padding: EdgeInsets.all(10)),

            Container(
              height: 30,
              color: Colors.white70,
              child:
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Text("12:40",
                        style: TextStyle(fontSize: 18)),
                  ),
                  Container(
                    width: 4,
                    color: Colors.green,
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text("Quadra 3",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
