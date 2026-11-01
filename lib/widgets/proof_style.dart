import 'package:flutter/material.dart';

const ink = Color(0xFF1C2824);
const green = Color(0xFF1E5935);
const pale = Color(0xFFDCEEDC);
const paper = Color(0xFFF6F8F5);
const muted = Color(0xFF63716B);
const line = Color(0xFFE1E6E1);

Text label(
  String value, {
  double size = 14,
  Color color = ink,
  bool bold = false,
}) => Text(
  value,
  style: TextStyle(
    fontSize: size,
    color: color,
    fontWeight: bold ? FontWeight.w700 : FontWeight.w400,
  ),
);
Widget gap([double height = 14]) => SizedBox(height: height);
Widget card(Widget child, {EdgeInsets padding = const EdgeInsets.all(16)}) =>
    Container(
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: line.withValues(alpha: .6)),
        boxShadow: [
          BoxShadow(
            color: ink.withValues(alpha: .035),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
