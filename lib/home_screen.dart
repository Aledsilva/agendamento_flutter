import 'dart:convert';

import 'package:agendamento_flutter/scheduling_options.dart';
import 'package:agendamento_flutter/reserve_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:scrolling_day_calendar/scrolling_day_calendar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

final formatHour = DateFormat('HH:mm');
final formatDate = DateFormat('yyyy-MM-dd');

//Estilo para a TextButton em caso de ser selecionada//
const pressedStyle = TextStyle(
    backgroundColor: Colors.blue,
    color: Colors.white,
    fontWeight: FontWeight.bold);

const hourStyle = TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.black,
    backgroundColor: Colors.white);

class _HomeScreenState extends State<HomeScreen> {

  Future<SchedulingOptions> getDinamicProfile() async {
    Map<String, String> headers = {
      'Authorization': 'Token token="761c62dbe6cdfc2026de52f4696ce4ee"',
      'x-app-id': "1000051",
    };

    String urlBase =
        "https://ravennahmlg.ad-alive.com/api/v1/spaces/list_hours?day=2021-05-11";

    final response = await http.get(
      urlBase,
      headers: headers,
    );

    print('params uri: ${urlBase.toString()}');
    print('HEADERS' + headers.toString());

    if (response.statusCode == 200) {
      print('response:' + response.body);
      setState(() {
        SchedulingOptions.fromJson(json.decode(response.body))
            .optionUses
            .forEach((element) {
          listModalities.add(element.name);
        });
      });
      return SchedulingOptions.fromJson(json.decode(response.body));
    } else {
      print('Response Error. Code: ${response.statusCode}');
      throw Exception('Failed to load HORARIOS');
    }
  }

  Future<SchedulingOptions> getTimeTable() async {
    Map<String, String> headers = {
      'Authorization': 'Token token="761c62dbe6cdfc2026de52f4696ce4ee"',
      'x-app-id': "1000051",
    };

    String urlBase =
        "https://ravennahmlg.ad-alive.com/api/v1/spaces/list_hours?day=${selectedDate}&option_use_id=1";

    final response = await http.get(urlBase, headers: headers);

    print('params uri: ${urlBase.toString()}');
    print('HEADERS' + headers.toString());

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print('HORARIO:' + response.body);
      setState(() {
        listScheduling = SchedulingOptions.fromJson(json.decode(response.body));

        listHours = new List();

        /*SchedulingOptions.fromJson(json.decode(response.body))
            .hours
            .forEach((element) {
          var dateTimeString = element.hour;
          var dateTime = DateTime.parse(dateTimeString);

          var formaterClock = formatHour.format(dateTime);

          listHours.add(formaterClock);
        });*/

        //listaQualquer =
        //Modalities.fromJson(json.decode(response.body)).optionUses;
      });
      return SchedulingOptions.fromJson(json.decode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      print('Response Error. Code: ${response.statusCode}');
      throw Exception('Failed to load');
    }
  }

  String selectedModality;
  String spaceName = "";
  String selectedHour;
  String reservedDate;

  List listModalities = [];
  List listHours = [];
  SchedulingOptions listScheduling;

  bool _showButton = true;

  int selectedExpansion;

  //V??riaveis relacionados ao calend??rio
  DateTime selectedDate = DateTime.now();
  DateTime startDate = DateTime.now().subtract(Duration(days: 10));
  DateTime endDate = DateTime.now().add(Duration(days: 10));
  Map<String, Widget> widgets = Map();
  String widgetKeyFormat = "yyyy-MM-dd";

  @override
  void initState() {
    super.initState();
    listScheduling = new SchedulingOptions();
    listScheduling.hours = List();
    getDinamicProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

          //Actions: s??o os widgets que est??o dentro desta na AppBar
          actions: [
            Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: InkWell(
                child: Container(
                  width: 50,
                  height: 50,
                  child: Icon(Icons.menu, color: Colors.white),
                ),
                onTap: () {},
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 275),
                child: InkWell(
                  child: Container(
                    width: 50,
                    height: 50,
                    child: Icon(Icons.notifications, color: Colors.white),
                  ),
                  onTap: () {},
                ),
              ),
            )
          ]),

      //Calend??rio que est?? abaixo da AppBar
      body: ScrollingDayCalendar(
        startDate: startDate,
        endDate: endDate,
        selectedDate: selectedDate,
        dateStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        displayDateFormat: "EEEE, d 'de' MMMM",
        dateBackgroundColor: Colors.grey,
        forwardIcon: Icons.arrow_forward_ios_outlined,
        backwardIcon: Icons.arrow_back_ios_outlined,
        pageChangeDuration: Duration(
          milliseconds: 300,
        ),
        widgets: widgets,
        widgetKeyFormat: widgetKeyFormat,
        noItemsWidget:

            //Aqui est?? a constru????o da DropDown
            Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8.0),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              child: DropdownButton(
                dropdownColor: Colors.grey[100],
                hint: Text(
                  "  Modalidades :",
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
                icon: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Colors.blue,
                ),
                iconSize: 36,
                isExpanded: true,
                value: selectedModality,
                style: TextStyle(color: Colors.blue, fontSize: 18),
                items: listModalities.map((modalityItem) {
                  return DropdownMenuItem(
                    value: modalityItem,
                    child: Row(
                      children: <Widget>[Text("${modalityItem}")],
                    ),
                  );
                }).toList(),
                onChanged: (newModalityItem) {
                  setState(() {
                    getTimeTable();
                    selectedModality = newModalityItem;
                    spaceName = newModalityItem;
                  });
                },
              ),
            ),

            //Abaixo da DropDown
            //DENTRO DESTA FUN????O - Torna a p??gina rol??vel ENTRE o Widget do no TOP e no BOTTOM
            if (selectedModality != null) _buildCard(),

            //Validac??o para bot??o RESERVAR, ele s?? aparece quando necess??rio!
            Visibility(
              child: _buildReserveButton(),
              visible: _showButton ? false : true,
            ),

            SizedBox(height: 20)
          ],
        ),
      ),
    );
  }

  //////////  FUN????ES  //////////

  Widget _buildCard() {

    //dynamic teste = listScheduling.hours.length.toDouble();
    //print("EEEEEE ${teste}");

    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 10,
        key: Key('builder ${selectedExpansion.toString()}'),
        itemBuilder: (context, int index){

          return ExpansionTile(
            title: Text("Taitoou"),
            key: Key(index.toString()),
            onExpansionChanged: (expanded){
              if(expanded)
                setState(() {
                  selectedExpansion = index;
                });
              else setState(() {
                selectedExpansion = 0;
              });
            },

            children: [
              ListTile(
                title: listScheduling.hours != null
                    ? SizedBox(
                  height: 210,
                  child: Material(
                    elevation: 3,
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5,
                          crossAxisSpacing: 1,
                          mainAxisSpacing: 1,
                        ),
                        itemCount: listScheduling.hours.length,
                        itemBuilder: (BuildContext context, int outroindex) {
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _buildTxtButton(
                                      listScheduling.hours[outroindex].hour,
                                      outroindex,
                                      listScheduling.hours[outroindex].hasBeenPressed),
                                ],
                              ),
                            ],
                          );
                        }),
                  ),
                )
                    : Container(),
              ),
            ],
          );
        },
      ),
    );
  }

  //Constr??i os hor??rios clic??veis//
  Widget _buildTxtButton(String umHorario, index, bool hasBeenPressed) {

    var dateTimeString = umHorario;
    DateFormat inputFormat = DateFormat('dd-MM-yyyy hh:mm');
    DateTime input = inputFormat.parse(dateTimeString);
    //var dateTime = DateTime.parse(dateTimeString);
    var convertedData = DateFormat('hh:mm').format(input);
    //var formatedClock = formatHour.format(dateTime);

    return TextButton(
      child:
          Text(convertedData, style: hasBeenPressed ? hourStyle : pressedStyle),
      onPressed: () {
        setState(() {
          listScheduling.hours.forEach((element) {
            element.hasBeenPressed = true;
          });

          listScheduling.hours[index].hasBeenPressed =
              !listScheduling.hours[index].hasBeenPressed;

          selectedHour = convertedData;

          //Button RESERVAR
          if (listScheduling.hours[index].hasBeenPressed) {
            _showButton = true;
          } else {
            _showButton = false;
          }
        });
      },
    );
  }

  //Contr??i o bot??o RESERVAR//
  Widget _buildReserveButton() {

    var dateString = selectedDate;
    //var date = DateFormat.yMMMd();

    var formatedDate = formatDate.format(dateString);

    reservedDate = formatedDate;

    return Center(
      child: Padding(
        padding: EdgeInsets.only(top: 8),
        child: SizedBox(
          height: 50,
          width: 365,
          child: RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            color: Colors.blue,
            child: Text(
              "RESERVAR",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ReservePage(selectedHour, selectedModality, reservedDate)));
            },
          ),
        ),
      ),
    );
  }
}
