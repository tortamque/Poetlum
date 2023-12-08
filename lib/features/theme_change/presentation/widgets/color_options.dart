import 'package:flutter/material.dart';
import 'package:poetlum/features/theme_change/presentation/widgets/color_option_button.dart';

class ColorOptions{
  static const List<ColorOptionButton> colors = [
    ColorOptionButton(themeColor: Color(0xFF817DBA)),
    ColorOptionButton(themeColor: Color(0xFFA0C49D)),
    ColorOptionButton(themeColor: Color(0xFFC4DFDF)),

    ColorOptionButton(themeColor: Color(0xFFA7727D)),
    ColorOptionButton(themeColor: Color(0xFFD0B8A8)),
    ColorOptionButton(themeColor: Color(0xFF9F8772)),

    ColorOptionButton(themeColor: Colors.redAccent),
    ColorOptionButton(themeColor: Colors.blueAccent),
    ColorOptionButton(themeColor: Colors.cyanAccent),

    ColorOptionButton(themeColor: Colors.limeAccent),
    ColorOptionButton(themeColor: Colors.pinkAccent),
    ColorOptionButton(themeColor: Colors.tealAccent),

    ColorOptionButton(themeColor: Colors.greenAccent),
    ColorOptionButton(themeColor: Colors.amberAccent),
    ColorOptionButton(themeColor: Colors.indigoAccent),

    ColorOptionButton(themeColor: Colors.orangeAccent),
    ColorOptionButton(themeColor: Colors.purpleAccent),
    ColorOptionButton(themeColor: Colors.yellowAccent),

    ColorOptionButton(themeColor: Colors.lightBlueAccent),
    ColorOptionButton(themeColor: Colors.deepOrangeAccent),
    ColorOptionButton(themeColor: Colors.deepPurpleAccent),

    ColorOptionButton(themeColor: Colors.lightGreenAccent),
    ColorOptionButton(themeColor: Colors.grey),
    ColorOptionButton(themeColor: Colors.white)
  ];
}
