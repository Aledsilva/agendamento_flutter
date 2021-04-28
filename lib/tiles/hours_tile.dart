import 'package:flutter/material.dart';

class HoursTile extends StatelessWidget {

  final HoursTile hoursTile;
  HoursTile(this.hoursTile);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          children: [
            Text("17:00"),
            Text("17:00"),
            Text("17:00"),
            Text("17:00"),
            Text("17:00"),
            Text("17:00"),
          ],
        ),
      ),
    );
  }
}
