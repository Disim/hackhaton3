import 'package:flutter/material.dart';
import 'package:hackaton3/elements/constants_elements.dart';

class ClassicButton extends StatelessWidget {
  const ClassicButton(
    this.text,
    this.onTap, {
    this.height = 40,
    this.fontSize = 20,
    super.key,
  });

  final String text;
  final Function? onTap;
  final double height;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(mainColor),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(borderRadius: mediumRad))),
          onPressed: () {
            onTap != null ? onTap!() : Function;
          },
          child: Text(
            text,
            style: TextStyle(
                color: Colors.white,
                fontSize: fontSize,
                fontWeight: FontWeight.bold),
          )),
    );
  }
}
