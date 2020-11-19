import 'dart:core';
import 'dart:ui';
import 'package:vector_math/vector_math.dart';

/*
 *  A very simple Wavefront .OBJ parser.
 *  https://en.wikipedia.org/wiki/Wavefront_.obj_file
 */
class Model {
  List<Vector3> verts;
  List<List<int>> faces;

  List<Color> colors;
  Map<String, Color> materials;

  /*
   *  Converts normalised color values to a Color()
   */
  Color _toRGBA(double r, double g, double b) {
    return Color.fromRGBO(
        (r * 255).toInt(), (g * 255).toInt(), (b * 255).toInt(), 1);
  }

  Model() {
    verts = List<Vector3>();
    faces = List<List<int>>();
    colors = List<Color>();
    materials = {
      "default": _toRGBA(0.5, 0.5, 0.5),
    };
  }

  /*
   *  Parses the object from a string.
   */
  void loadFromString(String string) {
    String material;
    List<String> lines = string.split("\n");
    print("Parsing.. ${lines.length} lines");
    lines.forEach((line) {
      // Parse a vertex
      if (line.startsWith("v ")) {
        var values = line.split(new RegExp(r"\s+"));
        verts.add(Vector3(
          double.parse(values[1]),
          double.parse(values[2]),
          double.parse(values[3]),
        ));
      }
      // Parse a material reference
      else if (line.startsWith("usemtl ")) {
        material = line.substring(7);
      }
      // Parse a face
      else if (line.startsWith("f ")) {
        var values = line.trim().split(new RegExp(r"\s+"));

        faces.add(List.from([
          int.parse(values[1].split("/")[0]),
          int.parse(values[2].split("/")[0]),
          int.parse(values[3].split("/")[0]),
        ]));
        colors.add(Color(0xffffffff));

        if (values.length == 5) {
          // print(values.join('|'));
          faces.add(List.from([
            int.parse(values[1].split("/")[0]),
            int.parse(values[3].split("/")[0]),
            int.parse(values[4].split("/")[0]),
          ]));
          colors.add(Color(0xffffffff));
        }

        colors.add(materials.containsKey(material)
            ? materials[material]
            : materials['default']);
      }
    });
    print("completed.");
  }
}
