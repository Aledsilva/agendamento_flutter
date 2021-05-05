import 'package:flutter/material.dart';

class ReservePage extends StatefulWidget {


  String selectedHour;
  String selectedModality;
  String dateReserved;

  String valor;


  ReservePage(this.selectedHour, this.selectedModality, this.dateReserved);

  @override
  _ReservePageState createState() => _ReservePageState();
}

class _ReservePageState extends State<ReservePage> {

  TextEditingController noteController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //APPBAR e botões de ação
      appBar: AppBar(actions: [
        Padding(
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
      ]),

      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                height: 294,
                width: 455,
                child: Image.network(
                    "https://images.squarespace-cdn.com/content/5cee719a52ab760001a563d8/1561485136279-DLIEX3NP3VDE2FPKUPGM/5523d62b4ec9c9cef47b6dd3a945569fdd9c5b72687d5.jpg?content-type=image%2Fjpeg"),
              ),
              SizedBox(
                height: 50,
                width: 420,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)
                    ),
                    color: Colors.blue,
                    boxShadow: [
                      BoxShadow(color: Colors.green)
                    ],
                  ),
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Quadra França",
                        style: TextStyle(color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                      ),

                    ],
                  )
                ),
              ),
              SizedBox(
                height: 480,
                width: 420,
                child: Card(
                  child: Column(
                    children: [
                      //Campos de informações
                      Padding(
                        padding: EdgeInsets.only(top: 30, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Modalidade: ",
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              widget.selectedModality,
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.only(top: 8, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Horário: ",
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              widget.selectedHour,
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.only(top: 8, bottom: 50),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Máximo de pessoas permitidas 4 pessoas ",
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Container(
                        width: 365,
                        child: TextFormField(
                          maxLines: 3,
                          decoration: InputDecoration(
                            hintText: "Observações",
                            hintStyle: TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(),
                          ),
                          controller: noteController,
                        ),
                      ),

                      //INICIO DO BOTÃO
                      Padding(
                        padding: EdgeInsets.only(top: 80, bottom: 5),
                        child: SizedBox(
                          height: 50,
                          width: 365,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                            color: Colors.blue,
                            child: Text(
                              "RESERVAR",
                              style: TextStyle(color: Colors.white,
                              fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              setState(() {
                                //widget.selectedHour = widget.valor;
                                //pegar os valores de data horario e modalidade
                                _resetFields();
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //////////FUNÇÕES//////////
  void _resetFields() {
    noteController.text = "";
  }
}
