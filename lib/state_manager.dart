import 'dart:math';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';

class StateManager extends ChangeNotifier {
  static int num = 30;
  static StateManager on(BuildContext context) =>
      Provider.of<StateManager>(context);
  static StateManager of(BuildContext context) =>
      Provider.of<StateManager>(context, listen: false);
  static Random rnd = Random();
  final List<List<double>> spotss = [
    List.generate(num, (index) => index.toDouble()),
    List.generate(num, (index) => index.toDouble() * index.toDouble()),
    List.generate(num, (index) => sqrt(index.toDouble())),
    List.generate(num, (index) => sin(index) * 100),
    List.generate(num, (index) => cos(index) * cos(index) * index * index),
    List.generate(num, (index) => log(index + 10) * 100),
  ];
  List<Color> get colors => List.generate(
      spotss.length,
      (index) => Color.fromARGB(
          255, rnd.nextInt(255), rnd.nextInt(255), rnd.nextInt(255)));
  // final List<double> spots1 = List.generate(num, (index) => index.toDouble());
  // final List<double> spots2 =
  //     List.generate(num, (index) => index.toDouble() * index.toDouble());
  // final List<double> spots3 =
  //     List.generate(num, (index) => sqrt(index.toDouble()));

  // double maxY = 0;
  int touchIndex = 0;
  String tooltip = "";
  double minY = double.infinity;

  double get sizeY {
    // double min = double.infinity;
    double max = double.negativeInfinity;
    for (var spots in spotss) {
      for (var spot in spots) {
        if (max < spot) max = spot;
        if (minY > spot) minY = spot;
      }
    }
    return max - minY;
  }

  void setTouchIndex(int index) {
    touchIndex = index;
    // notifyListeners();
  }

  void setTooltip(int index) {
    final y = (spotss[index][touchIndex]).toStringAsFixed(3);
    tooltip = "($touchIndex, $y)";
    // debugPrint(tooltip);
    // debugPrint(index.toString());
    // notifyListeners();
  }
}
