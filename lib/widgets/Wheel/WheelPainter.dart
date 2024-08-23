import 'dart:math';
import 'package:flutter/material.dart';

class WheelPainter extends CustomPainter {
  final List<String> items;
  final double angle;
  final double baseSize;

  WheelPainter(this.items, this.angle, this.baseSize);

  @override
  void paint(Canvas canvas, Size size) {
    final double centerX = size.width / 2;
    final double centerY = size.height / 2;
    final double radius = min(centerX, centerY);

    final Paint paint = Paint()..style = PaintingStyle.fill;

    final double sectorAngle = 2 * pi / items.length;

    for (int i = 0; i < items.length; i++) {
      final startAngle = i * sectorAngle + angle;
      final endAngle = (i + 1) * sectorAngle + angle;

      paint.color = _getColor(i);

      canvas.drawArc(
        Rect.fromCircle(center: Offset(centerX, centerY), radius: radius),
        startAngle,
        sectorAngle,
        true,
        paint,
      );

      _drawText(
          canvas, items[i], centerX, centerY, radius, startAngle, endAngle);
    }

    // Draw outer circle
    paint
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawCircle(Offset(centerX, centerY), radius, paint);

    // Draw center circle and restart icon
    _drawRestartIcon(canvas, centerX, centerY, radius);

    // Draw triangle pointer
    _drawPointer(canvas, centerX, centerY, radius);
  }

  void _drawText(Canvas canvas, String text, double centerX, double centerY,
      double radius, double startAngle, double endAngle) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(color: Colors.black, fontSize: baseSize * 0.05),
      ),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();

    final double midAngle = (startAngle + endAngle) / 2;
    final double textX =
        centerX + cos(midAngle) * radius * 0.75 - textPainter.width / 2;
    final double textY =
        centerY + sin(midAngle) * radius * 0.75 - textPainter.height / 2;

    canvas.save();
    canvas.translate(textX, textY);
    canvas.rotate(midAngle + pi / 2);
    textPainter.paint(canvas, Offset.zero);
    canvas.restore();
  }

  void _drawRestartIcon(
      Canvas canvas, double centerX, double centerY, double radius) {
    final paint = Paint()
      ..color = Colors.red[900]!
      ..style = PaintingStyle.fill;

    // Draw center circle
    canvas.drawCircle(Offset(centerX, centerY), radius * 0.15, paint);

    // Draw restart icon
    paint
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final path = Path();
    path.moveTo(centerX, centerY - radius * 0.1);
    path.lineTo(centerX + radius * 0.07, centerY - radius * 0.05);
    path.lineTo(centerX + radius * 0.03, centerY - radius * 0.05);
    path.lineTo(centerX + radius * 0.03, centerY);
    path.lineTo(centerX - radius * 0.03, centerY);
    path.lineTo(centerX - radius * 0.03, centerY - radius * 0.05);
    path.lineTo(centerX - radius * 0.07, centerY - radius * 0.05);
    path.close();

    canvas.drawPath(path, paint);
  }

  void _drawPointer(
      Canvas canvas, double centerX, double centerY, double radius) {
    final pointerPath = Path();
    pointerPath.moveTo(centerX, centerY - radius - 20);
    pointerPath.lineTo(centerX - 10, centerY - radius);
    pointerPath.lineTo(centerX + 10, centerY - radius);
    pointerPath.close();

    final paint = Paint()
      ..color = Colors.red[900]!
      ..style = PaintingStyle.fill;
    canvas.drawPath(pointerPath, paint);
  }

  Color _getColor(int index) {
    final colors = [
      Colors.yellow[300]!,
      Colors.red[300]!,
      Colors.orange[300]!,
      Colors.yellow[300]!,
      Colors.red[300]!,
      Colors.orange[300]!,
    ];
    return colors[index % colors.length];
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
