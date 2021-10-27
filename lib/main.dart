import 'package:flutter/material.dart';
import 'Reports.dart';
import 'Water_Measure.dart';
import 'package:hexcolor/hexcolor.dart';
import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentIndex = 0;
  Map<int, Widget> pageMap;
  Map<int, String> titleMap = {0: "Reports", 1: "Irrigation"};
  Widget appBarContent, appBarText;
  TextEditingController appBarController;

  setAppBar() {
    appBarText = Text(
      titleMap[currentIndex],
      style: TextStyle(
          letterSpacing: 2,
          color: HexColor('#46ab2b'),
          fontSize: 24,
          fontFamily: "selawk",
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic),
    );

    appBarContent = appBarText;
  }

  changePage(int index) {
    setState(() {
      currentIndex = index;
      setAppBar();
      appBarController.clear();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    appBarController = TextEditingController();
    pageMap = {
      0: Reports(),
      1: Water_Measure()

    };
    setAppBar();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    appBarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: HexColor("#81ba49")),
        centerTitle: true,
        title: appBarContent,
        backgroundColor: Colors.transparent,
        elevation: 0,
        brightness: Brightness.light,

        flexibleSpace: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              color: Colors.transparent,
            ),
          ),
        ),
//        bottom: PreferredSize(
//          preferredSize: Size(double.infinity, 2),
//          child: Container(
//            color: Color(0xFFB67777),
//            height: 2,
//          ),
//        ),
      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
//            header
            new UserAccountsDrawerHeader(
              accountName: Text('Farmer'),
              accountEmail: Text('myfarm01@gmail.com'),
              currentAccountPicture: GestureDetector(
                child: new CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.person,color: Colors.white,),
                ),
              ),
              decoration: new BoxDecoration(
                color: Colors.green,
              ),
            ),




            InkWell(
              onTap: (){},
              child: ListTile(
                title: Text('My Account'),
                leading: Icon(Icons.person),
              ),
            ),




            Divider(),

            InkWell(
              onTap: (){},
              child: ListTile(
                title: Text('Settings'),
                leading: Icon(Icons.settings,color: Colors.grey,),
              ),
            ),

            InkWell(
              onTap: (){},
              child: ListTile(
                title: Text('About'),
                leading: Icon(Icons.help, color: Colors.blue,),
              ),
            ),
          ],
        ),
      ),
      body: pageMap[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
//        backgroundColor: HexColor('#9fe35b'),
        backgroundColor: HexColor('##608a37'),
        fixedColor: Colors.white,
        unselectedItemColor: Color(0x60FFFFFF),
        currentIndex: currentIndex,
        onTap: (index) {
          changePage(index);
        },
        items: [
          BottomNavigationBarItem(label: "Reports", icon: Icon(Icons.assignment)),
          BottomNavigationBarItem(
              label: "Irrigation", icon: Icon(Icons.bubble_chart)),

        ],
      ),
    );
  }
}
