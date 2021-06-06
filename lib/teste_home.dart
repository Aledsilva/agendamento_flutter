import 'dart:io';

import 'package:agendamento_flutter/teste_camera.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TesteHome extends StatefulWidget {
  @override
  _TesteHomeState createState() => _TesteHomeState();
}

class _TesteHomeState extends State<TesteHome> {

  File _image = null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vamos ver"),
      ),
      body: Center(
        child: Column(
          children: [
            RaisedButton(
              child: Text("BORA LÁ"),
              onPressed: (){
                _optionsDialogBox();
              },
            )
          ],
        ),
      ),
    );
  }


  Future<void> _optionsDialogBox() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: new SingleChildScrollView(
              child: new ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: new Text('Tirar foto'),
                    onTap: () async {
                      if (Platform.isIOS) {
                        final cameras = await availableCameras();
                        final firstCamera = cameras.last;
                        final result = Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TakePictureScreen(
                              // Pass the appropriate camera to the TakePictureScreen widget.
                              camera: firstCamera,
                            ),
                          ),
                        );

                        result.then((value) async {
                          if(value != "false"){

                            setState(() {
                              _image = value;
                              Navigator.pop(context, null);
                            });

                          }
                        });
                      } else {
                        openCamera();
                      }
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                  GestureDetector(
                    child: new Text('Escolher da galeria'),
                    onTap: openGallery,
                  ),
                ],
              ),
            ),
          );
        });
  }

  openCamera() async {
    final picker = ImagePicker();
    var picture = await picker.getImage(
      source: ImageSource.camera,
    );
    setState(() {
      this._image = File(picture.path);
    });
    Navigator.pop(context, null);
  }

  openGallery() async {
    final picker = ImagePicker();
    var gallery = await picker.getImage(
      source: ImageSource.gallery,
    );
    setState(() {
      this._image = File(gallery.path);
    });
    Navigator.pop(context, null);
  }


}

