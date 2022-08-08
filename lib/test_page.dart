import 'package:fl_chart/fl_chart.dart';
import 'package:fluent_ui/fluent_ui.dart';

import 'state_manager.dart';

class TestPage extends StatelessWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.7,
      height: MediaQuery.of(context).size.height * 0.9,
      child: LineChart(
        LineChartData(
          lineTouchData: LineTouchData(
            mouseCursorResolver: (event, response) {
              // debugPrint([
              //   event.isInterestedForInteractions,
              //   event.localPosition
              // ].toString());
              // response?.lineBarSpots?[0].distance;
              final maxY = StateManager.of(context).spots2.last;
              final per1 = maxY / (MediaQuery.of(context).size.height * 0.9);
              final nearnessY = maxY - (per1 * event.localPosition!.dy);
              debugPrint([maxY, per1, nearnessY].toString());
              // debugPrint([
              //   event.localPosition!.direction,
              //   event.localPosition!.distance,
              //   // event.localPosition!.distanceSquared
              // ].toString());
              if (response != null && response.lineBarSpots != null) {
                // StateManager.of(context).touchIndex
                // debugPrint(response.lineBarSpots!.length.toString());
                // final LineBarSpot currentSpots =
                // debugPrint([
                //   response.lineBarSpots![0].barIndex,
                //   response.lineBarSpots![1].barIndex,
                //   response.lineBarSpots![2].barIndex
                // ].toString());
                // debugPrint([
                //   response.lineBarSpots![0].x,
                //   response.lineBarSpots![1].x,
                //   response.lineBarSpots![2].x
                // ].toString());
                // debugPrint([
                //   response.lineBarSpots![0].y,
                //   response.lineBarSpots![1].y,
                //   response.lineBarSpots![2].y
                // ].toString());
                // debugPrint([
                //   response.lineBarSpots![0].stringify,
                //   // response.lineBarSpots![1].y,
                //   // response.lineBarSpots![2].y
                // ].toString());
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
                // final tmp = List.generate(
                //     3, (index) => response.lineBarSpots![index].distance);
                // debugPrint(event.localPosition.toString());
                // debugPrint(tmp.toString());
              }

              // response?.lineBarSpots;
              // debugPrint(response?.lineBarSpots?[0].distance.toString());
              return MouseCursor.defer;
            },
            touchTooltipData: LineTouchTooltipData(
              getTooltipItems: (spots) {
                StateManager.of(context).setTouchIndex(spots[0].spotIndex);
                // debugPrint([spots[0].bar.aboveBarData.spotsLine.].toString());
                // debugPrint(spots.length.toString());
                return [
                  LineTooltipItem("", const TextStyle(fontSize: 0)),
                  LineTooltipItem(
                    StateManager.of(context).tooltip,
                    // "x: ${spots[0].x},\ny: ${spots[0].y}",
                    const TextStyle(color: Colors.white),
                  ),
                  LineTooltipItem("", const TextStyle(fontSize: 0)),
                ];
              },
            ),
          ),
          lineBarsData: [
            LineChartBarData(
              color: Colors.blue,
              spots: List.generate(
                StateManager.on(context).spots1.length,
                (index) => FlSpot(
                  index.toDouble(),
                  StateManager.on(context).spots1[index],
                ),
              ),
            ),
            LineChartBarData(
              // barWidth: 0.8,
              color: Colors.green,
              spots: List.generate(
                StateManager.on(context).spots2.length,
                (index) => FlSpot(
                  index.toDouble(),
                  StateManager.on(context).spots2[index],
                ),
              ),
            ),
            LineChartBarData(
              color: Colors.orange,
              spots: List.generate(
                StateManager.on(context).spots3.length,
                (index) => FlSpot(
                  index.toDouble(),
                  StateManager.on(context).spots3[index],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
