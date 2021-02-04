import 'package:flutter/material.dart';

void main() => runApp(List());

class List extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
            height: 750,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(44, 52, 155, 1),
                  Color.fromRGBO(76, 45, 141, 1),
                  Color.fromRGBO(97, 39, 131, 1),
                ],
              ),
            ),
            child: Column(children: [
              createCard(Icons.home_work, "Commercial Bank of Ethiopia",
                  "01323456789", context),
              createCard(Icons.house_siding_outlined, "Awash Bank",
                  "01323456789", context),
              createCard(Icons.phone, "Phone Number", "0", context),
            ]),
          ),
        ],
      ),
    );
  }

  Widget createCard(icon, name, count, context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10, bottom: 40),
      child: Container(
        color: Color.fromRGBO(0, 0, 0, .2),
        width: MediaQuery.of(context).size.width * 0.9,
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 64,
              width: 64,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 255, 255, 0.15),
                  shape: BoxShape.circle),
              child: Icon(
                icon,
                color: Colors.white,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(name,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(count,
                  style: TextStyle(
                    fontSize: 23,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
