import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hexcolor/hexcolor.dart';

class Humidity {
  double hlevel;
  String hours;
  double temp;

  Humidity({@required this.hours, @required this.hlevel, @required this.temp});
}

class GetData {
  gettlatest(String sensor, String Date) async {
    return await FirebaseFirestore.instance
        .collection(sensor)
        .where('Date', isEqualTo: Date)
        .orderBy('Time', descending: false)
        .get();
  }
}

class daily_report extends StatefulWidget {
  @override
  _daily_report createState() => _daily_report();
}

List<Humidity> data_h = [];
List<Humidity> data_t = [];

class _daily_report extends State<daily_report> {
  @override
  QuerySnapshot humidity_list;
  bool loading = true;

  _getData() async {
    humidity_list = await GetData().gettlatest("Humidity", "04/22/21");
    for (var i = 0; i < humidity_list.size; i++) {
//      DateTime t = DateTime.parse(humidity_list.docs[i]["Time"]);
      setState(() {
        data_h.add(Humidity(
            hours: humidity_list.docs[i]["Time"],
            temp: humidity_list.docs[i]["Temperature"],
            hlevel: humidity_list.docs[i]["Humidity"]));

      });
      if (this.mounted) {
        setState(() {
          loading = false;
        });
      }
    }
  }

  TooltipBehavior _tooltipBehavior;

  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
    _getData();
  }

  List<LineSeries<Humidity, String>> series_h = [
    LineSeries<Humidity, String>(
      // Bind data source
      dataSource: data_h,
      xValueMapper: (Humidity h, _) => h.hours,
      yValueMapper: (Humidity h, _) => h.hlevel,
    )
  ];
  List<LineSeries<Humidity, String>> series_t = [
    LineSeries<Humidity, String>(
      // Bind data source
      dataSource: data_h,
      xValueMapper: (Humidity h, _) => h.hours,
      yValueMapper: (Humidity h, _) => h.temp,
    )
  ];

  Future<bool> _willPopCallback() async {
    data_h = [];
    return Future.value(true);
  }

  Widget build(BuildContext context) {
    if (loading) {
      return Container(
        color: Colors.white,
        child: SpinKitFadingFour(
          color: HexColor('#7cb048'),
          size: 70,
        ),
      );
    } else {
      return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 15,
              ),
              Container(
                height: 400,
                padding: EdgeInsets.all(20),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: WillPopScope(
                      onWillPop: _willPopCallback,
                      child: Column(
                        children: <Widget>[
                          Text(
                            "Humidity Level",
                            style: Theme.of(context).textTheme.body2,
                          ),
                          Expanded(
                            child: SfCartesianChart(
                              enableAxisAnimation: true,
                              tooltipBehavior: _tooltipBehavior,
                              title:
                                  ChartTitle(text: 'Humidity Level for Today'),
                              primaryXAxis: CategoryAxis(),
                              series: series_h,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: 400,
                padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: WillPopScope(
                      onWillPop: _willPopCallback,
                      child: Column(
                        children: <Widget>[
                          Text(
                            "Temperature Level",
                            style: Theme.of(context).textTheme.body2,
                          ),
                          Expanded(
                            child: SfCartesianChart(
                              enableAxisAnimation: true,
                              tooltipBehavior: _tooltipBehavior,
                              title: ChartTitle(
                                  text: 'Temperature Level for Today'),
                              primaryXAxis: CategoryAxis(),
                              series: series_t,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
