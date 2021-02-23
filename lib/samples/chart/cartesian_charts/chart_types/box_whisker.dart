/// Package imports
import 'package:flutter/material.dart';

/// Chart import
import 'package:syncfusion_flutter_charts/charts.dart';

/// Local imports
import '../../../../model/sample_view.dart';

///Renders histogram chart sample
class BoxWhisker extends SampleView {
  const BoxWhisker(Key key) : super(key: key);

  @override
  _BoxWhiskerState createState() => _BoxWhiskerState();
}

class _BoxWhiskerState extends SampleViewState {
  _BoxWhiskerState();
  var _selectMode;
  BoxPlotMode _boxMode;
  bool _mean = true;
  final List<String> _modeType =
      <String>['normal', 'exclusive', 'inclusive'].toList();
  @override
  Widget buildSettings(BuildContext context) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter stateSetter) {
      return ListView(
        shrinkWrap: true,
        children: <Widget>[
          Container(
              child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text('Box plot mode ',
                  style: TextStyle(fontSize: 16.0, color: model.textColor)),
              Container(
                padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                child: DropdownButton<String>(
                    underline: Container(color: Color(0xFFBDBDBD), height: 1),
                    value: _selectMode,
                    items: _modeType.map((String value) {
                      return DropdownMenuItem<String>(
                          value: (value != null) ? value : 'normal',
                          child: Text('$value',
                              style: TextStyle(color: model.textColor)));
                    }).toList(),
                    onChanged: (dynamic value) {
                      _onModeChange(value.toString());
                      stateSetter(() {});
                    }),
              ),
            ],
          )),
          Container(
            child: Row(
              children: <Widget>[
                Text('Mean',
                    style: TextStyle(
                      color: model.textColor,
                      fontSize: 16,
                    )),
                Padding(
                  padding: const EdgeInsets.fromLTRB(60, 0, 0, 0),
                  child: Container(
                      width: 90,
                      child: CheckboxListTile(
                          activeColor: model.backgroundColor,
                          value: _mean,
                          onChanged: (bool value) {
                            setState(() {
                              _mean = value;
                              stateSetter(() {});
                            });
                          })),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(bottom: model.isWeb || !isCardView ? 0 : 50),
        child: _getDefaultWhiskerChart());
  }

  /// Get the cartesian chart with histogram series
  SfCartesianChart _getDefaultWhiskerChart() {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      title: ChartTitle(text: 'Employees age group in various departments'),
      primaryXAxis: CategoryAxis(
          majorGridLines: MajorGridLines(width: 0),
          labelIntersectAction: AxisLabelIntersectAction.rotate45),
      primaryYAxis: NumericAxis(
          name: 'Age',
          minimum: 10,
          maximum: 60,
          interval: 10,
          axisLine: AxisLine(width: 0),
          majorTickLines: MajorTickLines(size: 0)),
      series: _getBoxWhiskerSeries(),
      tooltipBehavior: TooltipBehavior(enable: true),
    );
  }

  ///Get the histogram series
  List<BoxAndWhiskerSeries<SalesData, dynamic>> _getBoxWhiskerSeries() {
    final List<SalesData> chartData = <SalesData>[
      SalesData(
          'Development',
          [
            22,
            22,
            23,
            25,
            25,
            25,
            26,
            27,
            27,
            28,
            28,
            29,
            30,
            32,
            34,
            32,
            34,
            36,
            35,
            38
          ],
          null,
          Color.fromRGBO(75, 135, 185, 0.9)),
      // SalesData('Testing',  [22, 33, 23, 25, 26, 28, 29, 30, 34, 33, 32, 31, 50],null,
      // Color.fromRGBO(75, 135, 185, 0.9) ),
      SalesData('HR', [22, 24, 25, 30, 32, 34, 36, 38, 39, 41, 35, 36, 40, 56],
          null, Color.fromRGBO(75, 135, 185, 0.9)),
      SalesData('Finance  ', [26, 27, 28, 30, 32, 34, 35, 37, 35, 37, 45], null,
          Color.fromRGBO(75, 135, 185, 0.9)),
      SalesData('Inventory', [21, 23, 24, 25, 26, 27, 28, 30, 34, 36, 38], null,
          Color.fromRGBO(75, 135, 185, 0.9)),
      SalesData('Sales', [27, 26, 28, 29, 29, 29, 32, 35, 32, 38, 53], null,
          Color.fromRGBO(75, 135, 185, 0.9)),
      SalesData('R&D', [26, 27, 29, 32, 34, 35, 36, 37, 38, 39, 41, 43, 58],
          null, Color.fromRGBO(75, 135, 185, 0.9)),
      SalesData('Graphics', [26, 28, 29, 30, 32, 33, 35, 36, 52], null,
          Color.fromRGBO(75, 135, 185, 0.9)),
      // SalesData(  'Training',  [28, 29, 30, 31, 32, 34, 35, 36],null,
      //  Color.fromRGBO(123, 180, 235, 1))
    ];
    return <BoxAndWhiskerSeries<SalesData, dynamic>>[
      BoxAndWhiskerSeries<SalesData, dynamic>(
        name: 'Department',
        dataSource: chartData,
        showMean: _mean,
        boxPlotMode: _boxMode,
        borderColor: model.themeData.brightness == Brightness.dark
            ? Colors.white
            : Colors.black,
        xValueMapper: (SalesData sales, _) => sales.x,
        yValueMapper: (SalesData sales, _) => sales.y,
        pointColorMapper: (SalesData sales, _) => sales.color,
      )
    ];
  }

  @override
  void initState() {
    _selectMode = "normal";
    _mean = true;
    _boxMode = BoxPlotMode.normal;
    super.initState();
  }

  void _onModeChange(String item) {
    setState(() {
      _selectMode = item;
      if (_selectMode == 'normal') {
        _boxMode = BoxPlotMode.normal;
      } else if (_selectMode == 'inclusive') {
        _boxMode = BoxPlotMode.inclusive;
      } else if (_selectMode == 'exclusive') {
        _boxMode = BoxPlotMode.exclusive;
      }
    });
  }
}
