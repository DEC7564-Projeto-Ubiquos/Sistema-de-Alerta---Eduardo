import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class VoltageSample {
  final double sample;
  final double voltage;

  VoltageSample(
    this.sample,
    this.voltage,
  );
}

class VoltageSampleChart extends StatelessWidget {
  final List<VoltageSample> data;
  final Color color;

  const VoltageSampleChart({
    Key? key,
    required this.data,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      primaryXAxis: NumericAxis(
        title: AxisTitle(text: 'Amostra (kHz)'),
        interval: 100,
        majorGridLines: const MajorGridLines(width: 0),
      ),
      primaryYAxis: NumericAxis(
        title: AxisTitle(text: 'Tensão (mV)'),
        interval: 500,
        majorGridLines: const MajorGridLines(width: 0),
      ),
      series: <ChartSeries>[
        SplineSeries<VoltageSample, double>(
          color: color,
          dataSource: data,
          xValueMapper: (VoltageSample voltageSample, _) =>
              voltageSample.sample,
          yValueMapper: (VoltageSample voltageSample, _) =>
              voltageSample.voltage,
          width: 2,
          splineType: SplineType.natural,
        ),
      ],
      zoomPanBehavior: ZoomPanBehavior(
        zoomMode: ZoomMode.xy,
        enableDoubleTapZooming: true,
      ),
    );
  }
}
