import 'package:fl_chart/fl_chart.dart';
import 'package:fluent_ui/fluent_ui.dart';

import 'state_manager.dart';

class TestPage extends StatelessWidget {
  const TestPage({Key? key}) : super(key: key);
  final double verticalPadding = 30;

  double getChartFullHeight(BuildContext context) =>
      MediaQuery.of(context).size.height * 0.9;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFEEEEEE),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            height: getChartFullHeight(context),
            child: LineChart(
              LineChartData(
                titlesData: FlTitlesData(
                  topTitles: AxisTitles(
                    axisNameWidget: SizedBox(height: verticalPadding),
                    axisNameSize: verticalPadding,
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: verticalPadding,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          meta.formattedValue,
                          style: const TextStyle(color: Colors.black),
                        );
                      },
                    ),
                  ),
                ),
                lineTouchData: LineTouchData(
                  touchCallback: (event, response) {
                    // debugPrint(event.localPosition.toString());
                    if (event.localPosition != null) {
                      if (response != null && response.lineBarSpots != null) {
                        final maxY = StateManager.of(context).maxY;
                        final per1 = maxY /
                            (getChartFullHeight(context) - verticalPadding * 2);
                        final nearnessY =
                            maxY - (per1 * event.localPosition!.dy);
                        int index = 0;
                        double min = double.infinity;
                        for (var spot in response.lineBarSpots!) {
                          double dis = spot.y - nearnessY;
                          if (dis < 0) dis = dis * -1;
                          debugPrint(
                              "[${response.lineBarSpots!.indexOf(spot)}]distance: $dis");
                          if (min > dis) {
                            min = dis;
                            index = response.lineBarSpots!.indexOf(spot);
                          }
                        }

                        StateManager.of(context).setTooltip(index);
                      }
                    }
                  },
                  touchTooltipData: LineTouchTooltipData(
                    getTooltipItems: (spots) {
                      StateManager.of(context)
                          .setTouchIndex(spots[0].spotIndex);
                      return List.generate(
                        StateManager.of(context).spotss.length,
                        (index) {
                          if (index ==
                              (StateManager.of(context).spotss.length ~/ 2)) {
                            return LineTooltipItem(
                              StateManager.of(context).tooltip,
                              const TextStyle(color: Colors.white),
                            );
                          } else {
                            return LineTooltipItem(
                              "",
                              const TextStyle(fontSize: 0),
                            );
                          }
                        },
                      );
                    },
                  ),
                ),
                lineBarsData: List.generate(
                  StateManager.on(context).spotss.length,
                  (index) {
                    return LineChartBarData(
                      color: StateManager.on(context).colors[index],
                      spots: List.generate(
                        StateManager.on(context).spotss[index].length,
                        (jndex) => FlSpot(
                          jndex.toDouble(),
                          StateManager.on(context).spotss[index][jndex],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Container(
            height: getChartFullHeight(context),
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
            child: const Text(
              "테\n스\n트\n용",
              style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
