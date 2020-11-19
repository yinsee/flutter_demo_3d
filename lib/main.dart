import 'package:flutter_demo_3d/object3d.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(new MyApp());
}

const models = [
  "bed",
  "brain",
  "car",
  "coffee",
  "cow",
  "cYBertruck",
  "hexahedron",
  "lamp",
  "pickup"
];

const zooms = [0.3, 1, 10, 20, 30];

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        title: 'Object Viewer',
        home: Home());
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _object = models.first;
  num _zoom = zooms.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 0,
        backgroundColor: Color.fromRGBO(33, 33, 33, 1),
        title: Text('Model Demo'),
      ),
      // backgroundColor: Color.fromRGBO(33, 33, 33, 1),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: DropdownButton(
                    isExpanded: true,
                    value: _object,
                    items: models
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(e),
                            ))
                        .toList(),
                    onChanged: (_) {
                      setState(() {
                        _object = _;
                      });
                    }),
              ),
              VerticalDivider(),
              Expanded(
                child: DropdownButton(
                    isExpanded: true,
                    value: _zoom,
                    items: zooms
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(e.toString()),
                            ))
                        .toList(),
                    onChanged: (_) {
                      setState(() {
                        _zoom = _;
                      });
                    }),
              ),
            ],
          ),
          Expanded(
            key: Key(_object),
            child: ClipRect(
              child: Object3D(
                size: Size(500.0, 500.0),
                zoom: _zoom.toDouble(),
                path: "assets/$_object.obj",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
