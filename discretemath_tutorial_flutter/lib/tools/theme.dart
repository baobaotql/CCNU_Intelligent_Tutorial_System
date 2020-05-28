import 'package:flutter/material.dart';

ThemeData basicTheme() {
  TextTheme _basicTextTheme(TextTheme base) {
    return base.copyWith(
        headline1: base.headline1.copyWith(
          fontFamily: 'ComicSnasMS',
          fontSize: 22.0,
        ),
        headline2: base.headline2.copyWith(
            fontSize: 20.0,
            color: Color.fromARGB(255, 22, 209, 233)
        ),
      bodyText1: base.bodyText1.copyWith(
        fontSize: 23.0
      ),
      bodyText2: base.bodyText2.copyWith(
          fontSize: 20.0
      ),
    );
  }

  final ThemeData base = ThemeData.dark();
  return base.copyWith(
      textTheme: _basicTextTheme(base.textTheme),
//      primaryColor: Color(0xff303b4d),
      primaryColor: Color(0xff0da56d),
      indicatorColor: Color(0xff63ffda),
      cardColor: Color.fromARGB(255, 48, 77, 108),
//      accentColor: Color(0xff445f7b),
//      canvasColor: Color(0xff445f7b)
  );
}

class MyColors {
  static Color goodWhite = Color.fromARGB(255, 241, 241, 241);
  static Color goodGray = Color.fromARGB(255, 191, 191, 191);
  static Color greenTitle = Color.fromARGB(255, 14, 164, 109);
  static Color orangeTitle = Color.fromARGB(255, 244, 151, 99);
  static Color blueTitle = Color.fromARGB(255, 95, 125, 139);
}