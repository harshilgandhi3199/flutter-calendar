/// Flutter package imports
import 'package:flutter/material.dart';

/// Gauge imports
import 'package:syncfusion_flutter_gauges/gauges.dart';

/// Local imports
import '../../../model/sample_view.dart';

/// Renders the gauge pointer ease in circle animation sample
class RadialEaseInCircExample extends SampleView {
  /// Creates gauge with [easeInCirc] animation
  const RadialEaseInCircExample(Key key) : super(key: key);

  @override
  _RadialEaseInCircExampleState createState() =>
      _RadialEaseInCircExampleState();
}

class _RadialEaseInCircExampleState extends SampleViewState {
  _RadialEaseInCircExampleState();

  @override
  Widget build(BuildContext context) {
    return _getRadialEaseInCircExample();
  }

  /// Returns the pointer ease in circle animation gauge
  SfRadialGauge _getRadialEaseInCircExample() {
    return SfRadialGauge(
      axes: <RadialAxis>[
        RadialAxis(
            radiusFactor: model.isWeb ? 0.85 : 0.95,
            showAxisLine: false,
            ticksPosition: ElementsPosition.outside,
            labelsPosition: ElementsPosition.outside,
            interval: 10,
            axisLabelStyle: GaugeTextStyle(fontSize: 12),
            majorTickStyle: MajorTickStyle(
              length: 0.15,
              lengthUnit: GaugeSizeUnit.factor,
              thickness: 1,
            ),
            minorTicksPerInterval: 4,
            minorTickStyle: MinorTickStyle(
              length: 0.04,
              lengthUnit: GaugeSizeUnit.factor,
              thickness: 1,
            ),
            pointers: <GaugePointer>[
              RangePointer(
                  width: 15,
                  pointerOffset: 10,
                  value: 45,
                  animationDuration: 1000,
                  // Sweep gradient not supported in web
                  gradient: model.isWeb
                      ? null
                      : const SweepGradient(
                          colors: <Color>[Color(0xFF3B3FF3), Color(0xFF46D0ED)],
                          stops: <double>[0.25, 0.75]),
                  animationType: AnimationType.easeInCirc,
                  enableAnimation: true,
                  color: const Color(0xFFF8B195))
            ])
      ],
    );
  }
}
