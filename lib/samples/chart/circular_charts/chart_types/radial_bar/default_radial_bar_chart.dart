/// Package import
import 'package:flutter/material.dart';

/// Chart import
import 'package:syncfusion_flutter_charts/charts.dart';

/// Local imports
import '../../../../../model/sample_view.dart';

/// Render the default radial bar.
class RadialBarDefault extends SampleView {
  /// Creates the default radial bar.
  const RadialBarDefault(Key key) : super(key: key);

  @override
  _RadialBarDefaultState createState() => _RadialBarDefaultState();
}

/// State class of radial bar.
class _RadialBarDefaultState extends SampleViewState {
  _RadialBarDefaultState();

  @override
  Widget build(BuildContext context) {
    return _getDefaultRadialBarChart();
  }

  /// Returns the circular chart with radial series.
  SfCircularChart _getDefaultRadialBarChart() {
    return SfCircularChart(
      title: ChartTitle(text: isCardView ? '' : 'Shot put distance'),
      series: _getRadialBarDefaultSeries(),
      tooltipBehavior:
          TooltipBehavior(enable: true, format: 'point.x : point.ym'),
    );
  }

  /// Returns default radial series.
  List<RadialBarSeries<ChartSampleData, String>> _getRadialBarDefaultSeries() {
    final List<ChartSampleData> chartData = <ChartSampleData>[
      ChartSampleData(
          x: 'John',
          y: 10,
          text: '100%',
          pointColor: const Color.fromRGBO(248, 177, 149, 1.0)),
      ChartSampleData(
          x: 'Almaida',
          y: 11,
          text: '100%',
          pointColor: const Color.fromRGBO(246, 114, 128, 1.0)),
      ChartSampleData(
          x: 'Don',
          y: 12,
          text: '100%',
          pointColor: const Color.fromRGBO(61, 205, 171, 1.0)),
      ChartSampleData(
          x: 'Tom',
          y: 13,
          text: '100%',
          pointColor: const Color.fromRGBO(1, 174, 190, 1.0)),
    ];
    return <RadialBarSeries<ChartSampleData, String>>[
      RadialBarSeries<ChartSampleData, String>(
          maximumValue: 15,
          dataLabelSettings: DataLabelSettings(
              isVisible: true, textStyle: const TextStyle(fontSize: 10.0)),
          dataSource: chartData,
          cornerStyle: CornerStyle.bothCurve,
          gap: '10%',
          radius: '90%',
          xValueMapper: (ChartSampleData data, _) => data.x,
          yValueMapper: (ChartSampleData data, _) => data.y,
          pointRadiusMapper: (ChartSampleData data, _) => data.text,
          pointColorMapper: (ChartSampleData data, _) => data.pointColor,
          dataLabelMapper: (ChartSampleData data, _) => data.x)
    ];
  }
}
