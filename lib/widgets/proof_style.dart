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
Widget primary(String title, VoidCallback onPressed, {bool outlined = false}) {
  final Widget button;
  if (outlined) {
    button = OutlinedButton(onPressed: onPressed, child: Text(title));
  } else {
    button = FilledButton(onPressed: onPressed, child: Text(title));
  }
  return SizedBox(width: double.infinity, height: 46, child: button);
}

OutlineInputBorder _fieldBorder(Color color) => OutlineInputBorder(
  borderRadius: BorderRadius.circular(4),
  borderSide: BorderSide(color: color),
);

Widget field(String hint, {String? value, bool password = false}) =>
    TextFormField(
      initialValue: value,
      obscureText: password,
      autocorrect: false,
      enableSuggestions: !password,
      style: const TextStyle(fontSize: 15),
      decoration: InputDecoration(
        hintText: hint,
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 13,
        ),
        filled: true,
        fillColor: Colors.white,
        border: _fieldBorder(line),
        enabledBorder: _fieldBorder(line),
        focusedBorder: _fieldBorder(green),
        hintStyle: const TextStyle(color: Color(0xFF8F9B95), fontSize: 15),
      ),
    );
Widget chip(String title, {bool private = false}) => Container(
  padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 3),
  decoration: BoxDecoration(
    color: private ? const Color(0xFFEEF1EF) : pale,
    borderRadius: BorderRadius.circular(20),
  ),
  child: label(title, size: 11, color: private ? muted : green),
);
Widget avatar(String name) => CircleAvatar(
  radius: 20,
  backgroundColor: switch (name) {
    'Omar' => const Color(0xFFCD8415),
    'Latrell' => const Color(0xFF7060A9),
    _ => green,
  },
  child: Text(
    name.substring(0, 1),
    style: const TextStyle(fontSize: 16, color: Colors.white),
  ),
);
// The mockups use these color blocks in place of photos.
Widget photo({bool second = false, double? height}) => Container(
  height: height,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors:
          second
              ? [const Color(0xFFE8E2D3), const Color(0xFFCEC09B)]
              : [const Color(0xFFD9EEDB), const Color(0xFFA8CEB0)],
    ),
  ),
);

// Leave action buttons visible for now; they do nothing in this checkpoint.
void uiOnly() {}
