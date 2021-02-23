/// Flutter package imports
import 'package:flutter/material.dart';

/// Gauge imports
import 'package:syncfusion_flutter_gauges/gauges.dart';

/// Local imports
import '../../../model/sample_view.dart';

/// Renders the gauge range pointer sample
class RangePointerExample extends SampleView {
  /// Creates the gauge range pointer sample
  const RangePointerExample(Key key) : super(key: key);

  @override
  _RangePointerExampleState createState() => _RangePointerExampleState();
}

class _RangePointerExampleState extends SampleViewState {
  _RangePointerExampleState();

  @override
  Widget build(BuildContext context) {
    return _getRangePointerExampleGauge();
  }

  /// Returns the range pointer gauge
  SfRadialGauge _getRangePointerExampleGauge() {
    return SfRadialGauge(
      axes: <RadialAxis>[
        RadialAxis(
            showLabels: false,
            showTicks: false,
            startAngle: 270,
            endAngle: 270,
            minimum: 0,
            maximum: 100,
            radiusFactor: 0.8,
            axisLineStyle: AxisLineStyle(
                thicknessUnit: GaugeSizeUnit.factor, thickness: 0.15),
            annotations: <GaugeAnnotation>[
              GaugeAnnotation(
                  angle: 180,
                  widget: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        child: Text(
                          '50',
                          style: TextStyle(
                              fontFamily: 'Times',
                              fontSize: isCardView ? 18 : 22,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.italic),
                        ),
                      ),
                      Container(
                        child: Text(
                          ' / 100',
                          style: TextStyle(
                              fontFamily: 'Times',
                              fontSize: isCardView ? 18 : 22,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.italic),
                        ),
                      )
                    ],
                  )),
            ],
            pointers: <GaugePointer>[
              RangePointer(
                  value: 50,
                  cornerStyle: CornerStyle.bothCurve,
                  enableAnimation: true,
                  animationDuration: 1200,
                  animationType: AnimationType.ease,
                  sizeUnit: GaugeSizeUnit.factor,
                  // Sweep gradient not supported in web
                  gradient: model.isWeb
                      ? null
                      : const SweepGradient(
                          colors: <Color>[Color(0xFF6A6EF6), Color(0xFFDB82F5)],
                          stops: <double>[0.25, 0.75]),
                  color: const Color(0xFF00A8B5),
                  width: 0.15),
            ]),
      ],
    );
  }
}
