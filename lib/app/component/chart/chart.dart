import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

class LineChart extends StatelessWidget {
  final List<ChartData> entries;

  LineChart(this.entries);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ChartPainter(entries),
    );
  }
}

class ChartPainter extends CustomPainter {
  final List<ChartData> entries;

  ChartPainter(this.entries);

  double leftOffsetStart;
  double topOffsetEnd;
  double drawingWidth;
  double drawingHeight;

  static const int NUMBER_OF_HORIZONTAL_LINES = 5;

  @override
  void paint(Canvas canvas, Size size) {
    leftOffsetStart = size.width * 0.05;
    topOffsetEnd = size.height * 0.9;
    drawingWidth = size.width * 0.95;
    drawingHeight = topOffsetEnd;

    if (entries.isNotEmpty) {
      Tuple2<int, int> borderLineValues = _getMinAndMaxValues(entries);
      _drawHorizontalLinesAndLabels(
          canvas, size, borderLineValues.item1, borderLineValues.item2);
      _drawBottomLabels(canvas, size);

      _drawLines(canvas, borderLineValues.item1, borderLineValues.item2);
    }
  }

  @override
  bool shouldRepaint(ChartPainter old) => true;

  void _drawLines(ui.Canvas canvas, int minLineValue, int maxLineValue) {
    final paint = Paint()
      ..color = Colors.blue[400]
      ..strokeWidth = 3.0;

    DateTime beginningOfChart = _getStartDateOfChart();
    for (var i = 0; i < entries.length; i++) {
      Offset lineStart = _getEntryOffset(
          entries[i], beginningOfChart, minLineValue, maxLineValue);
      Offset lineEnd = _getEntryOffset(
          entries[i + 1], beginningOfChart, minLineValue, maxLineValue);

      canvas.drawLine(lineStart, lineEnd, paint);
      canvas.drawCircle(lineEnd, 3.0, paint);
    }

    canvas.drawCircle(
        _getEntryOffset(
            entries.first, beginningOfChart, minLineValue, maxLineValue),
        5.0,
        paint);
  }

  void _drawHorizontalLinesAndLabels(
      Canvas canvas, Size size, int minLineValue, int maxLineValue) {
    final paint = Paint()
      ..color = Colors.grey[300];
    int lineStep = _calculateHorizontalLineStep(maxLineValue, minLineValue);
    double offsetStep = _calculateHorizontalOffsetStep;
    for (int line = 0; line < NUMBER_OF_HORIZONTAL_LINES; line++) {
      double yOffset = line * offsetStep;
      _drawHorizontalLabel(maxLineValue, line, lineStep, canvas, yOffset);
      _drawHorizontalLine(canvas, yOffset, size, paint);
    }
  }

  void _drawHorizontalLine(
      ui.Canvas canvas, double yOffset, ui.Size size, ui.Paint paint) {
    canvas.drawLine(
      new Offset(leftOffsetStart, 5 + yOffset),
      new Offset(size.width, 5 + yOffset),
      paint,
    );
  }

  void _drawHorizontalLabel(int maxLineValue, int line, int lineStep,
      ui.Canvas canvas, double yOffset) {
    ui.Paragraph paragraph =
        _buildParagraphForLeftLabel(maxLineValue, line, lineStep);
    canvas.drawParagraph(
      paragraph,
      new Offset(0.0, yOffset),
    );
  }

  double get _calculateHorizontalOffsetStep {
    return drawingHeight / (NUMBER_OF_HORIZONTAL_LINES - 1);
  }

  int _calculateHorizontalLineStep(int maxLineValue, int minLineValue) {
    return (maxLineValue - minLineValue) ~/ (NUMBER_OF_HORIZONTAL_LINES - 1);
  }

  void _drawBottomLabels(Canvas canvas, Size size) {
//    for (int daysFromStart = LineChart.NUMBER_OF_DAYS;
//        daysFromStart >= 0;
//        daysFromStart -= 7) {
//      double offsetXbyDay = drawingWidth / (LineChart.NUMBER_OF_DAYS);
//      double offsetX = leftOffsetStart + offsetXbyDay * daysFromStart;
//      ui.Paragraph paragraph = _buildParagraphForBottomLabel(daysFromStart);
//      canvas.drawParagraph(
//        paragraph,
//        new Offset(offsetX - 50.0, 10.0 + drawingHeight),
//      );
//    }
  }

  ui.Paragraph _buildParagraphForBottomLabel(int daysFromStart) {
//    ui.ParagraphBuilder builder = ui.ParagraphBuilder(
//        ui.ParagraphStyle(fontSize: 10.0, textAlign: TextAlign.right))
//      ..pushStyle(new ui.TextStyle(color: Colors.black))
//      ..addText(new DateFormat('d MMM').format(new DateTime.now().subtract(
//          new Duration(days: LineChart.NUMBER_OF_DAYS - daysFromStart))));
//    return builder.build()
//      ..layout(new ui.ParagraphConstraints(width: 50.0));

    return ui.ParagraphBuilder(ui.ParagraphStyle()).build();
  }

  ui.Paragraph _buildParagraphForLeftLabel(
      int maxLineValue, int line, int lineStep) {
    ui.ParagraphBuilder builder = new ui.ParagraphBuilder(
      new ui.ParagraphStyle(
        fontSize: 10.0,
        textAlign: TextAlign.right,
      ),
    )
      ..pushStyle(new ui.TextStyle(color: Colors.black))
      ..addText((maxLineValue - line * lineStep).toString());
    final ui.Paragraph paragraph = builder.build()
      ..layout(new ui.ParagraphConstraints(width: leftOffsetStart - 4));
    return paragraph;
  }

  Tuple2<int, int> _getMinAndMaxValues(List<ChartData> entries) {
    double maxWeight = entries.map((entry) => entry.value).reduce(math.max);
    double minWeight = entries.map((entry) => entry.value).reduce(math.min);

    int maxLineValue = maxWeight.ceil();
    int difference = maxLineValue - minWeight.floor();
    int toSubtract = (NUMBER_OF_HORIZONTAL_LINES - 1) -
        (difference % (NUMBER_OF_HORIZONTAL_LINES - 1));
    if (toSubtract == NUMBER_OF_HORIZONTAL_LINES - 1) {
      toSubtract = 0;
    }
    int minLineValue = minWeight.floor() - toSubtract;

    return new Tuple2(minLineValue, maxLineValue);
  }

  Offset _getEntryOffset(ChartData entry, DateTime beginningOfChart,
      int minLineValue, int maxLineValue) {
    int daysFromBeginning = entry.date
        .difference(beginningOfChart)
        .inDays;
    double relativeXposition = daysFromBeginning / 60; // TODO
    double xOffset = leftOffsetStart + relativeXposition * drawingWidth;

    double relativeYposition =
        (entry.value - minLineValue) / (maxLineValue - minLineValue);
    double yOffset = 5 + drawingHeight - relativeYposition * drawingHeight;
    return new Offset(xOffset, yOffset);
  }

  DateTime _getStartDateOfChart() {
    return entries
        .reduce((e1, e2) =>
        math.min(
            e1.date.millisecondsSinceEpoch, e2.date.millisecondsSinceEpoch))
        .date;
  }
}

class ChartData {
  DateTime date;
  double value;
  String note;

  ChartData({@required this.date, @required this.value, this.note = ''});
}
