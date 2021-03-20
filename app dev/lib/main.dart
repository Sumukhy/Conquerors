import 'dart:io';

import 'package:flutter/material.dart';
import 'package:odour_and_air_quality/view_data.dart';
import 'credits.dart';
import 'map_display.dart';
import 'place_circle.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:image_picker/image_picker.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    title: "Odour and Air Quality Detection and Mapping",
    theme: ThemeData.light(),
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.map),
            title: new Text('Maps'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.table_chart),
            title: new Text('Table'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.image), title: Text('Image Upload'))
        ],
      ),
      body: [
        Maps(),
        ViewData(),
        Container(
          child: Column(
            children: [
              Text("Upload Image"),
              RaisedButton(
                onPressed: () async {
                  // final pickedFile =
                  //     await ImagePicker().getImage(source: ImageSource.camera);

                  // setState(() {
                  //   if (pickedFile != null) {
                  //     print(pickedFile.path);
                  //     var _image = File(pickedFile.path);
                  //   } else {
                  //     print('No image selected.');
                  //   }
                  // }
                  // );
                },
                child: Text("Capture the garbage"),
              )
            ],
          ),
        )
      ][_currentIndex],
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Team Conquerors'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            // ListTile(
            //   leading: Icon(Icons.view_agenda),
            //   title: Text('View Data'),
            //   onTap: () {
            //     Navigator.push(context,
            //         MaterialPageRoute(builder: (context) => ViewData()));
            //   },
            // ),
            // ListTile(
            //   leading: Icon(Icons.cake),
            //   title: Text('Credits'),
            //   onTap: () {
            //     Navigator.push(context,
            //         MaterialPageRoute(builder: (context) => Credits()));
            //   },
            // ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("Odour and Air Quality Detection and Mapping"),
      ),

      // Column(
      //   children: [
      //     RaisedButton(
      //       child: Text("Example map"),
      //       onPressed: () {
      //         Navigator.push(context,
      //             MaterialPageRoute(builder: (context) => PlaceCircleBody()));
      //       },
      //     ),
      //     RaisedButton(
      //       child: Text("Odour map"),
      //       onPressed: () {
      //         Navigator.push(
      //             context, MaterialPageRoute(builder: (context) => Maps()));
      //       },
      //     ),
      //   ],
      // ),
    );
  }
}
