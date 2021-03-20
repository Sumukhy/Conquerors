import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'dart:math';
import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;
import 'constants.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class Maps extends StatefulWidget {
  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  static final LatLng center = const LatLng(13.1288, 77.5874);

  final databaseReference = FirebaseDatabase.instance.reference();
  List sensorData = List();
  MapboxMapController controller;
  Circle _selectedCircle;
  bool dataLoaded = false;

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

            sensorData.add([
              da[0],
              da[1],
              (double.parse(da[2]) / 3).toInt().toString(),
              (double.parse(da[3]) / 3).toInt().toString(),
              da[4].split(" ").last
            ]);
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

  @override
  void initState() {
    super.initState();
    load();
    getData();
  }

  void _onMapCreated(MapboxMapController controller) {
    this.controller = controller;
    controller.onCircleTapped.add(_onCircleTapped);
    Future.delayed(const Duration(milliseconds: 500), () {
      _add();
      setState(() {});
    });
    print("added");
  }

  @override
  void dispose() {
    controller?.onCircleTapped?.remove(_onCircleTapped);
    super.dispose();
  }

  void _onCircleTapped(Circle circle) async {
    if (_selectedCircle != null) {
      // _updateSelectedCircle(
      //   const CircleOptions(circleRadius: 60),
      // );
    }
    setState(() {
      _selectedCircle = circle;
    });
    LatLng latLng = (await controller.getCircleLatLng(circle));

    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(
            "Latitude - ${latLng.latitude}  \nLongitude - ${latLng.longitude}"),
      ),
    );
  }

  void _updateSelectedCircle(CircleOptions changes) {
    controller.updateCircle(_selectedCircle, changes);
  }

  Future<void> getData() async {
    String data = await rootBundle.loadString("asset/data.txt");
    List data1 = data.split("\n");

    for (var d in data1) {
      sensorData.add(d.split(','));
    }
    print(sensorData.last);
  }

  void _add() {
    for (var data in sensorData) {
      controller.addCircle(
        CircleOptions(
            circleStrokeWidth: 1,
            circleRadius: (int.parse(data[2]) + int.parse(data[3])) / 200,
            circleOpacity: 0.4,
            geometry: LatLng(double.parse(data[0]), double.parse(data[1])),
            circleColor: "#FF0000"),
      );
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ProgressHUD(
        child: Builder(
          builder: (context) => Center(
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: MapboxMap(
                myLocationTrackingMode: MyLocationTrackingMode.TrackingGPS,
                accessToken: ACCESS_TOKEN,
                onMapCreated: _onMapCreated,
                initialCameraPosition: const CameraPosition(
                    target: LatLng(13.1288, 77.5874), zoom: 14.0),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
