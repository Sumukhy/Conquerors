import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ViewData extends StatefulWidget {
  @override
  _ViewDataState createState() => _ViewDataState();
}

class _ViewDataState extends State<ViewData> {
  List sensorData = List();
  List<TableRow> tableData = [
    TableRow(children: [
      Column(children: [
        Text('Lat',
            style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold))
      ]),
      Column(children: [
        Text('Long',
            style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold))
      ]),
      Column(children: [
        Text('Data1',
            style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold))
      ]),
      Column(children: [
        Text('Data2',
            style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold))
      ]),
      Column(children: [
        Text('Time',
            style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold))
      ]),
    ]),
  ];
  Future<void> load() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    bool stop = false;
    // app = await Firebase.initializeApp();
    try {
      for (var i = 1; i < 50; i++) {
        FirebaseDatabase.instance
            .reference()
            .child('live')
            .child("$i")
            .once()
            .then((DataSnapshot snapshot) {
          if (snapshot.value == null) {
            stop = true;
          } else {
            print(snapshot.value);
            print(snapshot.key);
            List da = snapshot.value.split(",");
            print([da[0], da[1], da[2], da[3], da[5].split(" ").last]);

            // sensorData.add([
            //   da[0],
            //   da[1],
            //   (double.parse(da[2]) / 3).toInt().toString(),
            //   (double.parse(da[3]) / 3).toInt().toString(),
            //   da[4].split(" ").last
            // ]);
            setState(() {
              tableData.add(TableRow(children: [
                Column(
                    children: [Text(da[0], style: TextStyle(fontSize: 13.0))]),
                Column(
                    children: [Text(da[1], style: TextStyle(fontSize: 13.0))]),
                Column(children: [
                  Text((double.parse(da[2]) / 1).toInt().toString(),
                      style: TextStyle(fontSize: 13.0))
                ]),
                Column(children: [
                  Text((double.parse(da[3]) / 1).toInt().toString(),
                      style: TextStyle(fontSize: 13.0))
                ]),
                Column(children: [
                  Text(da[5].split(" ").last, style: TextStyle(fontSize: 13.0))
                ]),
              ]));
            });
          }
        });
        if (stop) {
          break;
        }
        // print(data);
      }
    } catch (e) {
      //print(e);
    }
  }

  Future<void> getData() async {
    String data = await rootBundle.loadString("asset/data.txt");
    List data1 = data.split("\n");

    for (var d in data1) {
      sensorData.add(d.split(','));
    }

    for (var sdata in sensorData) {
      setState(() {
        tableData.add(TableRow(children: [
          Column(children: [Text(sdata[0], style: TextStyle(fontSize: 13.0))]),
          Column(children: [Text(sdata[1], style: TextStyle(fontSize: 13.0))]),
          Column(children: [Text(sdata[2], style: TextStyle(fontSize: 13.0))]),
          Column(children: [Text(sdata[3], style: TextStyle(fontSize: 13.0))]),
          Column(children: [Text(sdata[4], style: TextStyle(fontSize: 13.0))]),
        ]));
      });
    }
    print(sensorData.last);
  }

  @override
  void initState() {
    super.initState();
    load();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Table(
            // defaultColumnWidth: FixedColumnWidth(120.0),
            border: TableBorder.all(
                color: Colors.black, style: BorderStyle.solid, width: 2),
            children: tableData),
      ),
    );
  }
}
