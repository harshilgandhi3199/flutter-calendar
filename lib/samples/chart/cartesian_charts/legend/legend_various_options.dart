/// Package import
import 'package:flutter/material.dart';

/// Chart import
import 'package:syncfusion_flutter_charts/charts.dart';

/// Local imports
import '../../../../model/sample_view.dart';

/// Renders the Stacked line chart and legend with various opdations sample.
class CartesianLegendOptions extends SampleView {
  /// Creates the Stacked line chart and legend with various opdations sample.
  const CartesianLegendOptions(Key key) : super(key: key);

  @override
  _CartesianLegendOptionsState createState() => _CartesianLegendOptionsState();
}

/// State class of the cartesian legend with various opdations sample.
class _CartesianLegendOptionsState extends SampleViewState {
  _CartesianLegendOptionsState();

  bool toggleVisibility;
  final List<String> _positionList =
      <String>['auto', 'bottom', 'left', 'right', 'top'].toList();
  String _selectedPosition;
  LegendPosition _position;
  final List<String> _modeList = <String>['wrap', 'scroll', 'none'].toList();
  String _selectedMode;
  LegendItemOverflowMode _overflowMode;

  @override
  void initState() {
    _selectedPosition = 'auto';
    _position = LegendPosition.auto;
    _selectedMode = 'wrap';
    _overflowMode = LegendItemOverflowMode.wrap;
    toggleVisibility = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _getCartesianLegendOptionsChart();
  }

  @override
  Widget buildSettings(BuildContext context) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter stateSetter) {
      return ListView(
        shrinkWrap: true,
        children: <Widget>[
          Container(
            child: Row(
              children: <Widget>[
                Text('Position ',
                    style: TextStyle(
                      color: model.textColor,
                      fontSize: 16,
                    )),
                Container(
                    padding: const EdgeInsets.fromLTRB(75, 0, 0, 0),
                    height: 50,
                    alignment: Alignment.bottomLeft,
                    child: DropdownButton<String>(
                        underline:
                            Container(color: Color(0xFFBDBDBD), height: 1),
                        value: _selectedPosition,
                        items: _positionList.map((String value) {
                          return DropdownMenuItem<String>(
                              value: (value != null) ? value : 'auto',
                              child: Text('$value',
                                  style: TextStyle(color: model.textColor)));
                        }).toList(),
                        onChanged: (dynamic value) {
                          _onPositionTypeChange(value.toString());
                          stateSetter(() {});
                        })),
              ],
            ),
          ),
          Container(
            child: Row(
              children: <Widget>[
                Text('Overflow mode',
                    style: TextStyle(
                      color: model.textColor,
                      fontSize: 16,
                    )),
                Container(
                    padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                    height: 50,
                    child: DropdownButton(
                        underline:
                            Container(color: Color(0xFFBDBDBD), height: 1),
                        value: _selectedMode,
                        items: _modeList.map((String value) {
                          return DropdownMenuItem<String>(
                              value: (value != null) ? value : 'wrap',
                              child: Text('$value',
                                  style: TextStyle(color: model.textColor)));
                        }).toList(),
                        onChanged: (dynamic value) {
                          _onModeTypeChange(value);
                          stateSetter(() {});
                        })),
              ],
            ),
          ),
          Container(
            child: Row(
              children: <Widget>[
                Text('Toggle visibility',
                    style: TextStyle(
                      color: model.textColor,
                      fontSize: 16,
                    )),
                Container(
                    width: 75,
                    child: CheckboxListTile(
                        activeColor: model.backgroundColor,
                        value: toggleVisibility,
                        onChanged: (bool value) {
                          setState(() {
                            toggleVisibility = value;
                            stateSetter(() {});
                          });
                        })),
              ],
            ),
          ),
        ],
      );
    });
  }

  /// Returns the stacked line chart with various legedn modification options.
  SfCartesianChart _getCartesianLegendOptionsChart() {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      title: ChartTitle(text: isCardView ? '' : 'Monthly expense of a family'),

      /// Legend and its options for cartesian chart.
      legend: Legend(
          isVisible: !isCardView,
          position: _position,
          overflowMode: _overflowMode,
          toggleSeriesVisibility: toggleVisibility),
      primaryXAxis: CategoryAxis(
        majorGridLines: MajorGridLines(width: 0),
        labelRotation: isCardView ? 0 : -45,
      ),
      primaryYAxis: NumericAxis(
          axisLine: AxisLine(width: 0),
          labelFormat: '\${value}',
          majorTickLines: MajorTickLines(size: 0)),
      series: _getStackedLineSeries(),
      tooltipBehavior: TooltipBehavior(enable: true),
    );
  }

  /// Returns the list of chart series which need to render
  /// on the stacked line chart.
  List<StackedLineSeries<ChartSampleData, String>> _getStackedLineSeries() {
    final List<ChartSampleData> chartData = <ChartSampleData>[
      ChartSampleData(
          x: 'Food',
          y: 55,
          yValue: 40,
          secondSeriesYValue: 45,
          thirdSeriesYValue: 48,
          size: 28),
      ChartSampleData(
          x: 'Transport',
          y: 33,
          yValue: 45,
          secondSeriesYValue: 54,
          thirdSeriesYValue: 28,
          size: 35),
      ChartSampleData(
          x: 'Medical',
          y: 43,
          yValue: 23,
          secondSeriesYValue: 20,
          thirdSeriesYValue: 34,
          size: 48),
      ChartSampleData(
          x: 'Clothes',
          y: 32,
          yValue: 54,
          secondSeriesYValue: 23,
          thirdSeriesYValue: 54,
          size: 27),
      ChartSampleData(
          x: 'Books',
          y: 56,
          yValue: 18,
          secondSeriesYValue: 43,
          thirdSeriesYValue: 55,
          size: 31),
      ChartSampleData(
          x: 'Others',
          y: 23,
          yValue: 54,
          secondSeriesYValue: 33,
          thirdSeriesYValue: 56,
          size: 35),
    ];
    return <StackedLineSeries<ChartSampleData, String>>[
      StackedLineSeries<ChartSampleData, String>(
          dataSource: chartData,
          xValueMapper: (ChartSampleData sales, _) => sales.x,
          yValueMapper: (ChartSampleData sales, _) => sales.y,
          name: 'Person 1',
          markerSettings: MarkerSettings(isVisible: true)),
      StackedLineSeries<ChartSampleData, String>(
          dataSource: chartData,
          xValueMapper: (ChartSampleData sales, _) => sales.x,
          yValueMapper: (ChartSampleData sales, _) => sales.yValue,
          name: 'Person 2',
          markerSettings: MarkerSettings(isVisible: true)),
      StackedLineSeries<ChartSampleData, String>(
          dataSource: chartData,
          xValueMapper: (ChartSampleData sales, _) => sales.x,
          yValueMapper: (ChartSampleData sales, _) => sales.secondSeriesYValue,
          name: 'Person 3',
          markerSettings: MarkerSettings(isVisible: true)),
      StackedLineSeries<ChartSampleData, String>(
          dataSource: chartData,
          xValueMapper: (ChartSampleData sales, _) => sales.x,
          yValueMapper: (ChartSampleData sales, _) => sales.thirdSeriesYValue,
          name: 'Person 4',
          markerSettings: MarkerSettings(isVisible: true)),
      StackedLineSeries<ChartSampleData, String>(
          dataSource: chartData,
          xValueMapper: (ChartSampleData sales, _) => sales.x,
          yValueMapper: (ChartSampleData sales, _) => sales.size,
          name: 'Person 5',
          markerSettings: MarkerSettings(isVisible: true))
    ];
  }

  /// Method to update the selected position type change.
  void _onPositionTypeChange(String item) {
    _selectedPosition = item;
    if (_selectedPosition == 'auto') {
      _position = LegendPosition.auto;
    }
    if (_selectedPosition == 'bottom') {
      _position = LegendPosition.bottom;
    }
    if (_selectedPosition == 'right') {
      _position = LegendPosition.right;
    }
    if (_selectedPosition == 'left') {
      _position = LegendPosition.left;
    }
    if (_selectedPosition == 'top') {
      _position = LegendPosition.top;
    }
    setState(() {
      /// update the legend position type changes
    });
  }

  /// Method to update the selected overflow mode type change.
  void _onModeTypeChange(String item) {
    _selectedMode = item;
    if (_selectedMode == 'wrap') {
      _overflowMode = LegendItemOverflowMode.wrap;
    }
    if (_selectedMode == 'scroll') {
      _overflowMode = LegendItemOverflowMode.scroll;
    }
    if (_selectedMode == 'none') {
      _overflowMode = LegendItemOverflowMode.none;
    }
    setState(() {
      /// update the legend item overflow mode changes
    });
  }
}
