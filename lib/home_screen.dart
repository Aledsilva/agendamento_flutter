import 'package:flutter/material.dart';
import 'package:scrolling_day_calendar/scrolling_day_calendar.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  String valorSelecionado;
  List listaQualquer = [
    "Unidos do GreenValley",
    "Centro - Osasco",
    "Terminal Grajaú",
    "Eita Guaianazes",
  ];
  String spaceName = "";
  String resultadoFinal;


  DateTime selectedDate = DateTime.now();
  DateTime startDate = DateTime.now().subtract(Duration(days: 10));
  DateTime endDate = DateTime.now().add(Duration(days: 10));
  Map<String, Widget> widgets = Map();
  String widgetKeyFormat = "yyyy-MM-dd";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Novo Agendamento"),
        centerTitle: true,
      ),
      body: ScrollingDayCalendar(
        startDate: startDate,
        endDate: endDate,
        selectedDate: selectedDate,
        dateStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        displayDateFormat: "dd, MMM yyyy",
        dateBackgroundColor: Colors.grey,
        forwardIcon: Icons.arrow_forward_ios_outlined,
        backwardIcon: Icons.arrow_back_ios_outlined,
        pageChangeDuration: Duration(
          milliseconds: 700,
        ),
        widgets: widgets,
        widgetKeyFormat: widgetKeyFormat,
        noItemsWidget: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8.0),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              child: DropdownButton(
                dropdownColor: Colors.grey[100],
                  hint: Text("  Planos :",
                    style: TextStyle(
                      color: Colors.grey[500],
                    ),
                  ),
                  icon: Icon(Icons.keyboard_arrow_down_rounded,
                  color: Colors.blue,),
                  iconSize: 36,
                  isExpanded: true,
                  value: valorSelecionado,
                  style: TextStyle(color: Colors.blue, fontSize: 18),
                  items: listaQualquer.map((modalityItem) {
                    return DropdownMenuItem(
                      value: modalityItem,
                      child: Row(
                        children: <Widget>[Text("${modalityItem}")],
                      ),
                    );
                  }).toList(),
                  onChanged: (newModalityItem) {
                    setState(() {

                    });
                  },
                ),
              ),
            Column(
              children: [
                _buildCard("16:00"),
                SizedBox(height: 5),
                _buildCard("13:00"),
                SizedBox(height: 5),
                _buildCard("13:00"),

              ],
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.only(top: 10),
                child: SizedBox(
                  height: 50,
                  width: 365,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)
                    ),
                    color: Colors.blue,
                    child: Text("RESERVAR",
                      style: TextStyle(
                          color: Colors.white
                      ),
                    ),
                    onPressed: (){},
                  ),
                ),
              )
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCard(String hour) {
    return Center(
      child: SizedBox(
        height: 170,
        width: 372,
        child: Card(
          elevation: 5,
          child: Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 22),
              child: Column(
                children: [
                  SizedBox(height: 5,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _buildTxtButton(hour),
                      _buildTxtButton(hour),
                      _buildTxtButton(hour),
                      _buildTxtButton(hour),
                      _buildTxtButton(hour),
                      _buildTxtButton(hour),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _buildTxtButton(hour),
                      _buildTxtButton(hour),
                      _buildTxtButton(hour),
                      _buildTxtButton(hour),
                      _buildTxtButton(hour),
                      _buildTxtButton(hour),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _buildTxtButton(hour),
                      _buildTxtButton(hour),
                      _buildTxtButton(hour),
                      _buildTxtButton(hour),
                      _buildTxtButton(hour),
                    ],
                  ),
                ],
              )
          ),
        ),
      ),
    );
  }

  Widget _buildTxtButton(String hour){
    return TextButton(
      onPressed: (){
        setState(() {
          
        });
      },
      child: Text(hour,
        style: TextStyle(fontWeight: FontWeight.bold,
            color: Colors.black),),
    );
  }
}
