import 'package:flutter/material.dart';

class EditTIRPage extends StatefulWidget {
  const EditTIRPage({Key? key}) : super(key: key);

  @override
  State<EditTIRPage> createState() => _EditTIRPageState();
}

class _EditTIRPageState extends State<EditTIRPage> {
  List<double> data = [0, 0, 98, 2, 0]; // 目前的資料，以百分比表示
  List<Color> colors = [Colors.red, Colors.blue, Colors.green, Colors.orange, Colors.red];
  List<String> labels = ["300", "200", "126", "90"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Edit TIR',
          style: TextStyle(
            fontSize: 24,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 8), // 調整文字與圖表之間的間距
              SizedBox(
                width: 300, // 控制圖表的寬度
                height: 300, // 控制圖表的高度
                child: CustomPaint(
                  painter: BarChartPainter(data, colors, labels),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BarChartPainter extends CustomPainter {
  final List<double> data;
  final List<Color> colors;
  final List<String> labels;

  BarChartPainter(this.data, this.colors, this.labels);

  @override
  void paint(Canvas canvas, Size size) {
    double totalHeight = size.height;
    double totalWidth = size.width;
    double currentY = 0;
    double separatorHeight = 2; // 分隔線的高度
    double spacing = 0; // 每個區間之間的間距
    double labelWidth = 30; // 刻度文字的寬度
    double barWidth = totalWidth - labelWidth; // 值條的寬度
    double firstHigh = 0.0;
    double lastHigh = 0.0;

    // 计算刻度文字的垂直位置数组
    List<double> labelYPositions = [];

    for (int i = 0; i < data.length; i++) {
      double barHeight = data[i] > 0 ? data[i] * (totalHeight - spacing * (data.length - 1)) / 100 : 1; // 如果數值為0，顯示高度為1

      Color barColor = data[i] > 0 ? colors[i] : Colors.grey; // 如果數值為0，顏色設置為灰色

      Paint barPaint = Paint()..color = barColor;

      // 繪製值條
      canvas.drawRect(
        Rect.fromLTWH(labelWidth, currentY, barWidth / 5, barHeight),
        barPaint,
      );

      currentY += barHeight;
      // 计算刻度文字的垂直位置
      double offsetY = currentY - separatorHeight / 2 - 16 / 2;
      if (i == 0) {
        firstHigh = offsetY;
      }
      if (i == data.length - 1) {
        lastHigh = offsetY;
      }
      print('offsetT = $offsetY');

      labelYPositions.add(offsetY);

      // 繪製分隔線
      if (i < data.length - 1) {
        currentY += separatorHeight + spacing;
        Paint separatorPaint = Paint()..color = Colors.transparent;
        canvas.drawRect(
          Rect.fromLTWH(labelWidth, currentY, barWidth, separatorHeight),
          separatorPaint,
        );
      }
    }

    // 调整刻度文字的位置，防止溢出
    double maxYPosition = labelYPositions.reduce((value, element) => value > element ? value : element);
    double minYPosition = labelYPositions.reduce((value, element) => value < element ? value : element);
    double overflowTop = totalHeight - maxYPosition;
    double overflowBottom = minYPosition;
    if (overflowTop < 0) {
      labelYPositions = labelYPositions.map((pos) => pos - overflowTop).toList();
    }

    if (overflowBottom < 0) {
      labelYPositions = labelYPositions.map((pos) => pos + overflowBottom).toList();
    }
    print(lastHigh);
    print('--------');
    if (labelYPositions[0] < firstHigh) labelYPositions[0] = firstHigh;
    for (int i = 1; i < labels.length; i++) {
      if (labelYPositions[i] - labelYPositions[i - 1] < 25) {
        labelYPositions[i] = labelYPositions[i - 1] + 25;
      }
      print('draw = ${labelYPositions[i]}');
    }

    if (labelYPositions[3] > lastHigh) {
      labelYPositions[3] = lastHigh;
    }
    for (int i = labels.length - 2; i >= 0; i--) {
      if ((labelYPositions[i + 1] - labelYPositions[i]) < 25) {
        labelYPositions[i] = labelYPositions[i + 1] - 25;
      }
      print('draw = ${labelYPositions[i]}');
    }

    // 繪製刻度文字
    for (int i = 0; i < labels.length; i++) {
      print(labelYPositions[i]);
      if (i < labelYPositions.length) {
        drawText(
          canvas,
          labels[i],
          Offset(-5, labelYPositions[i]),
          TextStyle(color: Colors.black, fontSize: 16),
        );
      }
    }


    if (data.isNotEmpty) {
      //繪製虛線
      drawFoldedLine(canvas, Offset(barWidth / 5, 0), totalWidth / 2);
      drawstraightLine(canvas, Offset(barWidth / 5, 25), totalWidth / 2);
      drawMidStraightLine(canvas, Offset(barWidth / 3, 158), totalWidth / 2);
      drawstraightLine(canvas, Offset(barWidth / 5, 285), totalWidth / 2);
      drawEndFoldedLine(canvas, Offset(barWidth / 5, 310), totalWidth / 2);
      //繪製文字
      drawText(canvas, 'Very High', Offset(barWidth / 5 + 40 , -40), TextStyle(color: Colors.black54, fontSize: 16));
      drawText(canvas, 'High', Offset(barWidth / 5 + 40 , 15), TextStyle(color: Colors.black54, fontSize: 16));
      drawText(canvas, 'Target', Offset(barWidth / 5 + 40 , 147), TextStyle(color: Colors.black54, fontSize: 16));
      drawText(canvas, 'Low', Offset(barWidth / 5 + 40 , 275), TextStyle(color: Colors.black54, fontSize: 16));
      drawText(canvas, 'Very Low', Offset(barWidth / 5 + 40 , 320), TextStyle(color: Colors.black54, fontSize: 16));
      //繪製百分比
      drawText(canvas, '${data[0].toStringAsFixed(0)}%', Offset(barWidth - 60 , -20), TextStyle(color: Colors.black54, fontSize: 16,fontWeight: FontWeight.bold));
      drawText(canvas, '${data[1].toStringAsFixed(0)}%', Offset(barWidth - 60 , 15), TextStyle(color: Colors.black54, fontSize: 16,fontWeight: FontWeight.bold));
      drawText(canvas, '${data[3].toStringAsFixed(0)}%', Offset(barWidth - 60 , 275), TextStyle(color: Colors.black54, fontSize: 16,fontWeight: FontWeight.bold));
      drawText(canvas, '${data[4].toStringAsFixed(0)}%', Offset(barWidth - 60 , 310), TextStyle(color: Colors.black54, fontSize: 16,fontWeight: FontWeight.bold));
    }
  }

  void drawText(Canvas canvas, String text, Offset offset, TextStyle style) {
    final TextSpan span = TextSpan(text: text, style: style);
    final TextPainter tp = TextPainter(text: span, textAlign: TextAlign.left, textDirection: TextDirection.ltr);
    tp.layout();
    tp.paint(canvas, offset);
  }

  void drawFoldedLine(Canvas canvas, Offset start, double width) {
    final Paint paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 1.0;

    double dashHeight = 4.0;
    double dashSpace = 2.0;

    Offset current = start;
    while (current.dy > start.dy - 10) {
      canvas.drawLine(current, Offset(current.dx, current.dy - dashHeight), paint);
      current = Offset(current.dx, current.dy - (dashHeight + dashSpace));
    }

    current = Offset(current.dx, start.dy - 10);

    while (current.dx < start.dx + width) {
      double remainingSpace = (start.dx + width) - current.dx;

      if (remainingSpace < dashHeight) {
        canvas.drawLine(current, Offset(current.dx + remainingSpace, current.dy), paint);
        break;
      } else {
        canvas.drawLine(current, Offset(current.dx + dashHeight, current.dy), paint);
        current = Offset(current.dx + (dashHeight + dashSpace), current.dy);
      }
    }
  }

  void drawstraightLine(Canvas canvas, Offset start, double width) {
    final Paint paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 1.0;

    double dashHeight = 4.0;
    double dashSpace = 2.0;

    Offset current = Offset(start.dx + (width / 2), start.dy);

    while (current.dx < start.dx + width) {
      double remainingSpace = (start.dx + width) - current.dx;

      if (remainingSpace < dashHeight) {
        canvas.drawLine(current, Offset(current.dx + remainingSpace, current.dy), paint);
        break;
      } else {
        canvas.drawLine(current, Offset(current.dx + dashHeight, current.dy), paint);
        current = Offset(current.dx + (dashHeight + dashSpace), current.dy);
      }
    }
  }

  void drawMidStraightLine(Canvas canvas, Offset start, double width) {
    final Paint paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 1.0;

    double dashHeight = 4.0;
    double dashSpace = 2.0;

    Offset current = Offset(start.dx + (width / 2.5), start.dy);

    while (current.dx < start.dx + width) {
      double remainingSpace = (start.dx + width) - current.dx;

      if (remainingSpace < dashHeight) {
        canvas.drawLine(current, Offset(current.dx + remainingSpace, current.dy), paint);
        break;
      } else {
        canvas.drawLine(current, Offset(current.dx + dashHeight, current.dy), paint);
        current = Offset(current.dx + (dashHeight + dashSpace), current.dy);
      }
    }
  }

  void drawEndFoldedLine(Canvas canvas, Offset start, double width) {
    final Paint paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 1.0;

    double dashHeight = 4.0;
    double dashSpace = 2.0;

    Offset current = start;
    while (current.dy < start.dy + 10) {
      canvas.drawLine(current, Offset(current.dx, current.dy + dashHeight), paint);
      current = Offset(current.dx, current.dy + (dashHeight + dashSpace));
    }

    current = Offset(current.dx, start.dy + 10);

    while (current.dx < start.dx + width) {
      double remainingSpace = (start.dx + width) - current.dx;

      if (remainingSpace < dashHeight) {
        canvas.drawLine(current, Offset(current.dx + remainingSpace, current.dy), paint);
        break;
      } else {
        canvas.drawLine(current, Offset(current.dx + dashHeight, current.dy), paint);
        current = Offset(current.dx + (dashHeight + dashSpace), current.dy);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
