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
      'Authorization': 'Token token="bb739e7760407cc4985ae37038a1bef2"',
      'x-app-id': "1000051",
    };

    String urlBase =
        "https://ravennahmlg.ad-alive.com/api/v1/spaces/list_hours?day=2021-05-03";

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
      'Authorization': 'Token token="bb739e7760407cc4985ae37038a1bef2"',
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

  //Váriaveis relacionados ao calendário
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

          //Actions: são os widgets que estão dentro desta na AppBar
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

      //Calendário que está abaixo da AppBar
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

            //Aqui está a construção da DropDown
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
            //DENTRO DESTA FUNÇÃO - Torna a página rolável ENTRE o Widget do no TOP e no BOTTOM
            if (selectedModality != null) _buildCard(),

            //Validacão para botão RESERVAR, ele só aparece quando necessário!
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

  //////////  FUNÇÕES  //////////

  Widget _buildCard() {

    //dynamic teste = listScheduling.hours.length.toDouble();
    //print("EEEEEE ${teste}");

    return Expanded(
        child: ListView(
      children: [
        Center(
          child: SizedBox(
            height: 210,
            width: 372,
            child: Card(
              elevation: 5,
              child: listScheduling.hours != null
                  ? GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 6,
                        crossAxisSpacing: 1,
                        mainAxisSpacing: 1,
                      ),
                      itemCount: listScheduling.hours.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            SizedBox(height: 5),
                            /*Visibility(
                          visible: _hasSelected ? true : false,
                          child: SizedBox(width: 310,
                            child: Padding(
                              padding: EdgeInsets.only(top: 10, bottom: 10),
                              child: Text(spaceName,
                                style: TextStyle(fontWeight: FontWeight.bold,
                                    fontSize: 18),),),

                          )),*/
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _buildTxtButton(
                                    listScheduling.hours[index].hour,
                                    index,
                                    listScheduling.hours[index].hasBeenPressed),
                              ],
                            ),
                          ],
                        );
                      })
                  : Container(),
            ),
          ),
        )
      ],
    ));
  }

  //Constrói os horários clicáveis//
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

  //Contrói o botão RESERVAR//
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
