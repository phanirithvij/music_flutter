import 'package:flutter/material.dart';

class VisualizerPainter extends CustomPainter {
  final double height;
  final List<int> fft;
  final Color color;
  final Paint visualizerPaint;

  VisualizerPainter({
    this.color,
    this.fft,
    this.height,
  }) : visualizerPaint = Paint()
          ..color = color.withOpacity(0.75)
          ..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Size size) {
    // canvas.drawRect(
    //   Rect.fromLTRB(0, 0, size.width, size.height),
    //   visualizerPaint,
    // );

    _renderWaves(canvas, size);
  }

  List<int> _histogram(
    List<int> samples,
    int numBuckets, [
    int start,
    int end,
  ]) {
    if (start == end) {
      return const [];
    }

    start = start ?? 0;
    end = end ?? samples.length - 1;

    final sampleCount = end - start + 1;
    final samplesPerBucket = (sampleCount / numBuckets).floor();
    if (samplesPerBucket == 0) {
      return const [];
    }

    final actualSampleCount = sampleCount - (sampleCount % samplesPerBucket);
    List<int> historgam = new List<int>.filled(numBuckets, 0);

    for (int i = start; i <= start + actualSampleCount; ++i) {
      // ignore imaginary half of the fft samples
      if ((i - start) % 2 == 1) {
        continue;
      }

      int bucketIndex = ((i - start) / samplesPerBucket).floor();
      historgam[bucketIndex] += samples[i];
    }

    // Massage the data suitable for visualization
    for (var i = 0; i < historgam.length; ++i) {
      historgam[i] = (historgam[i] / samplesPerBucket).abs().round();
    }

    return historgam;
  }

  void _renderWaves(Canvas canvas, Size size) {
    final histogramLow = _histogram(fft, 15, 2, ((fft.length / 4).floor()));
    final histogramHigh = _histogram(
      fft,
      15,
      ((fft.length / 4).ceil()),
      (fft.length / 2).floor(),
    );

    _renderHistograms(canvas, size, histogramLow);
    _renderHistograms(canvas, size, histogramHigh);
  }

  void _renderHistograms(Canvas canvas, Size size, List<int> histogram) {
    if (histogram.length == 0) {
      return;
    }

    final pointsToGraph = histogram.length;
    final widthsPerSample = (size.width / (pointsToGraph - 2)).floor();

    final points = new List<double>.filled(pointsToGraph * 4, 0);
    for (var i = 0; i < histogram.length - 1; ++i) {
      points[i * 4] = (i * widthsPerSample).toDouble();
      points[i * 4 + 1] = size.height - histogram[i].toDouble();

      points[i * 4 + 2] = ((i + 1) * widthsPerSample).toDouble();
      points[i * 4 + 3] = size.height - histogram[i + 1].toDouble();
    }

    var path = Path();
    path.moveTo(0, size.height);
    path.lineTo(points[0], points[1]);

    for (int i = 2; i < points.length - 4; i += 2) {
      path.cubicTo(
        points[i - 2] + 10,
        points[i - 1],
        points[i] - 10,
        points[i + 1],
        points[i],
        points[i + 1],
      );
    }

    path.lineTo(size.width, size.height);
    path.close();

    canvas.drawPath(path, visualizerPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
