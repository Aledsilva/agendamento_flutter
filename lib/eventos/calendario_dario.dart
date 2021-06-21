import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

class DynamicEvent extends StatefulWidget {
  @override
  _DynamicEventState createState() => _DynamicEventState();
}

class _DynamicEventState extends State<DynamicEvent> {
  CalendarController _controller;
  Map<DateTime, List<dynamic>> _events;
  List<dynamic> _selectedEvents;
  TextEditingController _eventController;
  SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
    _eventController = TextEditingController();
    _events = {};
    _selectedEvents = [];
    prefsData();
  }

  prefsData() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _events = Map<DateTime, List<dynamic>>.from(
          decodeMap(json.decode(prefs.getString("events") ?? "{}")));
    });
  }

  Map<String, dynamic> encodeMap(Map<DateTime, dynamic> map) {
    Map<String, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[key.toString()] = map[key];
    });
    return newMap;
  }
  Map<DateTime, dynamic> decodeMap(Map<String, dynamic> map) {
    Map<DateTime, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[DateTime.parse(key)] = map[key];
    });
    return newMap;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.grey[100],
      body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 6,
                child: TableCalendar(
                  events: _events,
                  initialCalendarFormat: CalendarFormat.month,
                  calendarStyle: CalendarStyle(
                      canEventMarkersOverflow: true,
                      todayColor: Colors.orange,
                      markersColor: Colors.deepOrangeAccent,
                      selectedColor: Colors.black,
                      todayStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: Colors.white)),
                  headerStyle: HeaderStyle(
                    centerHeaderTitle: true,
                    formatButtonDecoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    formatButtonTextStyle: TextStyle(color: Colors.white),
                    formatButtonShowsNext: false,
                  ),
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  onDaySelected: (date, events,holidays) {
                    setState(() {
                      _selectedEvents = events;
                    });
                  },
                  builders: CalendarBuilders(
                    selectedDayBuilder: (context, date, events) => Container(
                        margin: const EdgeInsets.all(4.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Text(
                          date.day.toString(),
                          style: TextStyle(color: Colors.white),
                        )),
                    todayDayBuilder: (context, date, events) => Container(
                        margin: const EdgeInsets.all(4.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Text(
                          date.day.toString(),
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                  calendarController: _controller,
                ),
              ),
              Expanded(
                flex: 4,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ..._selectedEvents.map((event) => Padding(
                        padding: const EdgeInsets.fromLTRB(16, 3, 16, 3),
                        child: Container(
                          height: MediaQuery.of(context).size.height/25,
                          width: MediaQuery.of(context).size.width/2,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              border: Border.all(color: Colors.grey)
                          ),
                          child: Center(
                              child: Text(event,
                                style: TextStyle(color: Colors.blue,
                                    fontWeight: FontWeight.bold,fontSize: 16),)
                          ),
                        ),
                      ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    children: [
                      Center(
                        child: SizedBox(
                          height: 40,
                          child: Card(
                            elevation: 10,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.circle,color: Colors.green, size: 15),Text(" Teste"),
                                SizedBox(width: 20),
                                Icon(Icons.circle,color: Colors.orange, size: 15),Text(" Hoje"),
                                SizedBox(width: 20),
                                Icon(Icons.circle,color: Colors.blue, size: 15),Text(" Selecionado"),
                              ],
                            )
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        child: Icon(Icons.add),
        onPressed: _showAddDialog,
      ),
    );
  }

//Isso aqui vai ser descartado
  _showAddDialog() async {
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.white70,
          title: Text("Add Events"),
          content: TextField(
            controller: _eventController,
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("Save",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),),
              onPressed: () {
                if (_eventController.text.isEmpty) return;
                setState(() {
                  if (_events[_controller.selectedDay] != null) {
                    _events[_controller.selectedDay]
                        .add(_eventController.text);
                  } else {
                    _events[_controller.selectedDay] = [
                      _eventController.text
                    ];
                  }
                  prefs.setString("events", json.encode(encodeMap(_events)));
                  _eventController.clear();
                  Navigator.pop(context);
                });

              },
            )
          ],
        ));
  }
}