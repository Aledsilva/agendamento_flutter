import 'package:flutter/material.dart';

class EventFiles extends StatefulWidget {
  @override
  _EventFilesState createState() => _EventFilesState();
}

class _EventFilesState extends State<EventFiles> {

  List eventsList = ["Arroz", "Flango", "Bacon", "Arroz", "Flango", "Bacon", "Arroz", "Flango", "Bacon"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(""),
          backgroundColor: Colors.orange[600],
          leading: new IconButton(
              icon: new Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              })
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: 400,
              height: 70,
              color: Colors.grey[100],
              child: Center(
                child: Text("Ravenna Beach",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Material(
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  primary: false,
                  itemCount: eventsList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide())
                      ),
                      child: ListTile(
                          title: Text(eventsList[index].toString()),
                          subtitle: Text("${eventsList[index].toString()} às "
                              "${eventsList[index].toString()} "),
                          onTap: (){ }
                          ),
                    );
                  }
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 15)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                  width: 350,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)
                        ),
                        primary: Colors.red[600]
                    ),
                    child: Text("DOWNLOAD",
                      style: TextStyle(fontSize: 12, color: Colors.white),),
                    onPressed: (){},

                  ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
