import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_module_sports360/screens/my_schedule/schedule_details.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter_module_sports360/models/events-agenda/events_response.dart';
import 'package:flutter_module_sports360/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarEventTab extends StatefulWidget {
  @override
  _CalendarEventTabState createState() => _CalendarEventTabState();
}

class _CalendarEventTabState extends State<CalendarEventTab> {
  CalendarController _controller;
  Map<DateTime, List<Events>> _events;
  SharedPreferences prefs;

  List<Events> eventsList = [];
  List<dynamic> newEvents;
  String spaceCalendar;
  String formattedListDate;
  String formattedHour;
  String formattedSelectedDate;
  String todayDate;

  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
    _events = {};
    newEvents = [];
    prefsData();

    _getEventCalendar().then((value) {
      _loadDynamicEvents();
    });

  }

  Future<void> _getEventCalendar() async {
    Map<String, String> headers = {
      'Authorization': Constants.TOKEN,
      'x-app-id': Constants.APP_ID,
    };

    Uri uri = Uri.http(Constants.baseUrl, Constants.getEvents,);

    final response = await http.get(
        uri,
        headers: headers
    );

    print('params uri: ${uri.toString()}');
    print('HEADERS' + headers.toString());

    if (response.statusCode == 200) {


      setState(() {
        eventsList = EventsResponse.fromJson(json.decode(response.body)).events;
        print("COFCOF" + eventsList[0].schedule);
        eventsList.forEach((element) {
          print(element.schedule);
        });

        /*DateTime dtDate = DateFormat("yyyy-MM-ddTHH:mm:ss.mmmZ").parse(eventsList[0].startAt);
        DateTime dtHour = DateFormat("yyyy-MM-ddTHH:mm:ss.mmmZ").parse(eventsList[0].startAt);

        formattedCalendarDate = DateFormat("dd/MM/yyyy").format(dtDate);
        formattedCalendarHour = DateFormat("HH:mm").format(dtHour);
        spaceCalendar = eventsList[0].name;*/
      });

    } else {
      print('response:' + response.body);
      print('Response Error. Code: ${response.statusCode}');
      throw Exception('Failed to load');
    }
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 6,
            child: TableCalendar(
              events: _events,
              initialCalendarFormat: CalendarFormat.month,
              calendarStyle: CalendarStyle(
                  todayColor: Colors.orange,
                  selectedColor: Theme.of(context).primaryColor,
                  markersColor: Colors.green,
                  todayStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      color: Colors.white)),
              headerStyle: HeaderStyle(
                centerHeaderTitle: true,
                formatButtonDecoration: BoxDecoration(
                  color: Colors.red[500],
                  borderRadius: BorderRadius.circular(20.0),
                ),
                formatButtonTextStyle: TextStyle(color: Colors.white),
                formatButtonShowsNext: false,
              ),
              startingDayOfWeek: StartingDayOfWeek.sunday,
              onDaySelected: (date, events,holidays) {

                setState(() {
                  //Esvazia antes de carregar, assim a lista não se duplica a cada clique
                  newEvents = List();

                  formattedSelectedDate = DateFormat("dd/MM/yyyy").format(date);
                  print("FMT List Date : $formattedListDate");

                  eventsList.forEach((element) {

                    DateTime listDate = DateFormat("yyyy-MM-dd").parse(element.schedule);
                    formattedListDate = DateFormat("dd/MM/yyyy").format(listDate);
                    print("FMT Selec Date : $formattedSelectedDate");

                    DateTime listHour = DateFormat("yyyy-MM-ddTHH:mm:ss.mmmZ").parse(element.schedule);
                    element.formattedHour = DateFormat("HH:mm").format(listHour);


                    if(formattedListDate == formattedSelectedDate){
                      print("FMT List Date : $formattedListDate");
                      print("FMT Selec Date : $formattedSelectedDate");
                      newEvents.add(element);

                      print("NEWEVENTS: $newEvents");

                    }
                  });
                });
              },

              builders: CalendarBuilders(
                selectedDayBuilder: (context, date, events) => Container(
                    margin: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Color(int.parse(Constants.primaryColor)),
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Text(
                      date.day.toString(),
                      style: TextStyle(color: Colors.white),
                    )),
                todayDayBuilder: (context, date, events) => Container(
                    margin: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.deepOrangeAccent,
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
            child: newEvents.isNotEmpty  ? ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                primary: false,
                itemCount: newEvents.length,
                itemBuilder: (BuildContext context, int index) {
                  //newEvents == Map.fromEntries(_events.entries.map((e) => MapEntry(e.value, e.key)));
                  return Padding(
                      padding: const EdgeInsets.only(bottom: 1),
                      child: Container(
                        height: 40,
                        color: Colors.grey,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 1),
                          child: Container(
                              height: 40,
                              color: Colors.white,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.white
                                ),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 12),
                                      child: Text(newEvents[index].formattedHour.toString(),
                                        style: TextStyle(color: Colors.black),),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 16),
                                      child: Container(width: 4, color: Colors.green),
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.only(left: 10),
                                        child: Text(newEvents[index].name.toString(),
                                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black))
                                    ),
                                  ],
                                ),
                                onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) => ScheduleDetails()));
                                },
                              )
                          ),
                        ),
                      )
                  );
                }
            ):
            Container(),

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
    );
  }

  _loadDynamicEvents() async{
    //Essa função vai carregar tudo assim que a tela correspondente iniciar
    formattedSelectedDate = DateFormat("dd/MM/yyyy").format(_controller.selectedDay);
    print("DataDaTela : $formattedSelectedDate");

    setState(() {
      eventsList.forEach((element) {

        DateTime listDate = DateFormat("yyyy-MM-dd").parse(element.schedule);
        formattedListDate = DateFormat("dd/MM/yyyy").format(listDate);
        print("DataDaLista : $formattedListDate");

        DateTime nowDate = DateFormat("yyyy-MM-dd").parse(DateTime.now().toString());
        todayDate = DateFormat("dd/MM/yyyy").format(nowDate);
        print("DataToday : $todayDate");

        DateTime listHour = DateFormat("yyyy-MM-ddTHH:mm:ss.mmmZ").parse(element.schedule);
        element.formattedHour = DateFormat("HH:mm").format(listHour);
        print("DataToday : $formattedHour");

        //Add os eventos da API em uma nova lista
        if (_events[listDate] != null) {
          _events[listDate].add(element);
          print("Null foi false :" + element.schedule);

        }else{
          _events[listDate] = [element];
          print("Null foi true:" + element.schedule);

        }

        //Faz os eventos do dia aparecerem também, esse print é só pra fechar a validação
        todayDate == formattedListDate ?
        newEvents.add(element) : print("EVENTS : ${_events}");

      });
    });
  }
}