import 'package:flutter/material.dart';

void main() => runApp(List());

class List extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = 'Basic List';

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      home: Scaffold(
        body: ListView(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.money),
              title: Text('Commercial Bank of Ethiopia'),
            ),
            Text(
              "01323456789",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
            ListTile(
              leading: Icon(Icons.photo_album),
              title: Text('Album'),
            ),
            Text(
              "01323456789",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text('Phone'),
            ),
          ],
        ),
      ),
    );
  }
}
