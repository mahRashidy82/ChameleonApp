import 'package:flutter/material.dart';

class MyTextButton extends StatelessWidget {
  const MyTextButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.size,
    this.color,
    this.colortext = Colors.white,
    this.fontWeight = FontWeight.normal,
    this.textAlign = TextAlign.center,
  }) : super(key: key);
  final VoidCallback onPressed;
  final String text;
  final Size? size;
  final Color? color;
  final Color? colortext;
  final FontWeight fontWeight;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(color),
        fixedSize: MaterialStateProperty.all(
          size,
        ),
        shape: MaterialStateProperty.all<BeveledRectangleBorder>(
            BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        )),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(color: colortext, fontWeight: fontWeight),
        textAlign: textAlign,
      ),
    );
  }
}
