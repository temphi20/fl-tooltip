import 'dart:math';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';

class StateManager extends ChangeNotifier {
  static int num = 30;
  static StateManager on(BuildContext context) =>
      Provider.of<StateManager>(context);
  static StateManager of(BuildContext context) =>
      Provider.of<StateManager>(context, listen: false);

  final List<double> spots1 = List.generate(num, (index) => index.toDouble());
  final List<double> spots2 =
      List.generate(num, (index) => index.toDouble() * index.toDouble());
  final List<double> spots3 =
      List.generate(num, (index) => sqrt(index.toDouble()));

  int touchIndex = 0;
  String tooltip = "";
  void setTouchIndex(int index) {
    touchIndex = index;
    // notifyListeners();
  }

  void setTooltip(int index) {
    double y = 0;
    if (index == 0) {
      y = spots1[touchIndex];
    } else if (index == 1) {
      y = spots2[touchIndex];
    } else if (index == 2) {
      y = spots3[touchIndex];
    }
    tooltip = "($touchIndex, $y)";
    debugPrint(tooltip);
    debugPrint(index.toString());
    // notifyListeners();
  }
}
