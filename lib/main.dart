import 'package:flutter_demo_3d/object3d.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Technical'),
      debugShowCheckedModeBanner: false,
      title: 'Object Viewer',
      home: Scaffold(
        appBar: new AppBar(
          elevation: 0,
          backgroundColor: Color.fromRGBO(33, 33, 33, 1),
        ),
        backgroundColor: Color.fromRGBO(33, 33, 33, 1),
        body: Column(
          children: [
            Object3D(
              size: Size(300.0, 600.0),
              zoom: 10,
              path: "assets/car.obj",
            ),
          ],
        ),
      ),
    );
  }
}
