import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hexcolor/hexcolor.dart';

class Water_Measure extends StatefulWidget {
  @override
  _Water_Measure createState() => _Water_Measure();
}

class Humidity {
  double hlevel;
  double temp;

  Humidity({ @required this.hlevel, @required this.temp});
}
getlatest(String sensor, String Date) async {
  return await FirebaseFirestore.instance
      .collection(sensor)
      .where('Date', isEqualTo: Date)
      .orderBy('Time', descending: true)
      .limit(1)
      .get();
}

Widget data(String image, String name, String value) {
  return Padding(
    padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
    child: Row(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(22, 40, 10, 10),
          child: Container(
            height: 50,
            width: 50,
            child: Image.asset("assets/images/" + image),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 35, 0, 0),
          child: Column(
            children: [
              Text(name),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 15, 0),
                child: Text(value),
              )
            ],
          ),
        )
      ],
    ),
  );
}

class _Water_Measure extends State<Water_Measure> {
bool loading = true;
    Humidity H_one;
  _getData() async {
    var h = await getlatest("Humidity", "04/22/21");
      setState(() {
        H_one =Humidity(
            temp: h.docs[0]["Temperature"],
            hlevel: h.docs[0]["Humidity"]);
      });
      if(this.mounted){
        setState(() {
          loading = false;
        });

      }


  }
  void initState() {
    super.initState();
    _getData();
  }
  @override
  Widget build(BuildContext context) {
    if(loading){
      return Container(
        color: Colors.white,
        child: SpinKitFadingFour(
          color: HexColor('#7cb048'),
          size: 70,
        ),
      );
    }else{
    return Scaffold(
      body: Stack(children: [
        Opacity(
          opacity: 0.8,
          child: Container(
            child: Image.asset('assets/images/corn-field-440338_1920.jpg'),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: (MediaQuery.of(context).size.height -
                (MediaQuery.of(context).size.height / 2.3)),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(35),
                    topRight: Radius.circular(35))),
            child: Column(
              children: [
                Container(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(45, 0, 50, 0),
                  child: Text(
                    "Below are the current conditions of the plants monitored.",
                    style: TextStyle(fontFamily: "selawk", fontSize: 15),
                  ),
                ),
                Row(
                  children: [
                    data("thermometer.png", "Temperature", H_one.temp.toStringAsFixed(2)+"° C"),
                    data("pottery.png", "Humidity", H_one.hlevel.toStringAsFixed(2)+" %")
                  ],
                ),
                Divider(
                  thickness: 0.3,
                ),
                Row(
                  children: [
                    data("sprout.png", "Moisture", "23%"),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
                      child: data("hose.png", "Water Level", "Low"),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ]),
    );}
  }
}
