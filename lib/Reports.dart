import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'daily_report.dart';
import 'package:hexcolor/hexcolor.dart';

class Reports extends StatefulWidget {
  @override
  _Reports createState() => _Reports();
}

class _Reports extends State<Reports> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          InkWell(
            onTap: () {
              FocusScope.of(context).unfocus();
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (BuildContext context) => daily_report()));
            },
            child: Card(
              elevation: 5,
              child: Container(
                height: 120,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 0.5)),
                child: Row(children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(3, 3, 8, 3),
                    child: Container(
                      child: Image.asset("assets/images/appointment.png",
                          height: 90, width: 120),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                            child: Text(
                              "Today's report",
                              style: TextStyle(
                                  letterSpacing: 2,
                                  fontSize: 14,
                                  fontFamily: "selawk",
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                            child: Image(
                              image: AssetImage("assets/images/arrow_icon.png"),
                              height: 50,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ]),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              FocusScope.of(context).unfocus();
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (BuildContext context) => daily_report()));
            },
            child: Card(
              elevation: 5,
              child: Container(
                height: 120,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 0.5)),
                child: Row(children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(3, 3, 8, 3),
                    child: Container(
                      child: Image.asset("assets/images/appointment.png",
                          height: 90, width: 120),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                            child: Text(
                              "Monthly report",
                              style: TextStyle(
                                  letterSpacing: 2,
                                  fontSize: 14,
                                  fontFamily: "selawk",
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                            child: Image(
                              image: AssetImage("assets/images/arrow_icon.png"),
                              height: 50,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
