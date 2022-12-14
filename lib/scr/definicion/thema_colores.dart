import 'package:flutter/material.dart';

ThemeData themaApi(String color) {
  //final celProvider = Provider.of<EstadoProvider>(context);
  //final color = "1"; // celProvider.paleta;
  ThemeData tema;
  switch (color) {
    case '1':
      tema = ThemeData(
        primaryColor: Color.fromARGB(
            226, 255, 255, 255), // Color.fromARGB(255, 3, 51, 90),
        backgroundColor: Color.fromARGB(255, 3, 51, 90),
        scaffoldBackgroundColor: Color.fromARGB(255, 2, 84, 131),
        textTheme: TextTheme(
            bodyText1: TextStyle(color: Colors.white),
            bodyText2: TextStyle(color: Color.fromARGB(232, 255, 255, 255))),
        iconTheme: IconThemeData(color: Colors.white, size: 40),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
          backgroundColor: Color.fromRGBO(192, 57, 43, 1),
          textStyle: TextStyle(fontSize: 25, color: Colors.white),
        )),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          extendedTextStyle: TextStyle(fontSize: 20, color: Colors.white),
          backgroundColor: Color.fromRGBO(192, 57, 43, 1),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: Color.fromRGBO(249, 75, 11, 1),
            selectedIconTheme:
                IconThemeData(color: Colors.green, opacity: 0.6, size: 40.0),
            unselectedIconTheme: IconThemeData(
                color: Colors.green[100], opacity: 0.6, size: 30.0)),

        // style: BorderStyle()
      );
      break;
    case '2':
      tema = ThemeData(
        primaryColor: Colors.black54,
        backgroundColor: Color.fromARGB(255, 143, 185, 168),
        scaffoldBackgroundColor: Colors.white, //Color.fromARGB(
        //  255, 225, 217, 217), //Color.fromARGB(255, 251, 246, 240),
        //Colors.grey[800], //  Color.fromRGBO(55, 57, 84, 1.0),
        textTheme: TextTheme(
            bodyText1: TextStyle(color: Colors.white),
            bodyText2: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white, size: 40),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
          backgroundColor: Color.fromRGBO(249, 75, 11, 1),
          textStyle: TextStyle(fontSize: 25, color: Colors.white),
        )),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          extendedTextStyle: TextStyle(fontSize: 20, color: Colors.white),
          backgroundColor: Color.fromRGBO(249, 75, 11, 1),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: Color.fromRGBO(249, 75, 11, 1),
            selectedIconTheme:
                IconThemeData(color: Colors.green, opacity: 0.6, size: 40.0),
            unselectedIconTheme: IconThemeData(
                color: Colors.green[100], opacity: 0.6, size: 30.0)),

        // style: BorderStyle()
      );
      break;
    // case '2':
    //   tema = ThemeData(
    //     primaryColor: Colors.white54,
    //     backgroundColor: Colors.black38, //Color.fromRGBO(55, 57, 84, 1.0),
    //     scaffoldBackgroundColor:
    //         Colors.grey[800], //  Color.fromRGBO(55, 57, 84, 1.0),
    //     textTheme: TextTheme(
    //         bodyText1: TextStyle(color: Colors.white),
    //         bodyText2: TextStyle(color: Colors.white70)),
    //     iconTheme: IconThemeData(color: Colors.white54, size: 40),
    //     elevatedButtonTheme: ElevatedButtonThemeData(
    //         style: ElevatedButton.styleFrom(
    //        backgroundColor: Color.fromRGBO(249, 75, 11, 1),
    //       textStyle: TextStyle(fontSize: 25, color: Colors.white),
    //     )),
    //     floatingActionButtonTheme: FloatingActionButtonThemeData(
    //       extendedTextStyle: TextStyle(fontSize: 20, color: Colors.white),
    //       backgroundColor: Color.fromRGBO(249, 75, 11, 1),
    //     ),
    //     bottomNavigationBarTheme: BottomNavigationBarThemeData(
    //         backgroundColor: Color.fromRGBO(249, 75, 11, 1),
    //         selectedIconTheme:
    //             IconThemeData(color: Colors.green, opacity: 0.6, size: 40.0),
    //         unselectedIconTheme: IconThemeData(
    //             color: Colors.green[100], opacity: 0.6, size: 30.0)),

    //     // style: BorderStyle()
    //   );
    //   break;

    case '3':
      tema = ThemeData(
        primaryColor: Color.fromARGB(255, 245, 247, 245),
        backgroundColor: Color.fromARGB(255, 7, 98, 89), //Color.fromARGB(
        // 255, 245, 247, 245),
        scaffoldBackgroundColor: Color.fromARGB(255, 6, 149, 133),
        textTheme: TextTheme(
            bodyText1: TextStyle(color: Colors.white),
            bodyText2: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white, size: 40),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
          backgroundColor: Color.fromRGBO(192, 57, 43, 1),
          textStyle: TextStyle(fontSize: 25, color: Colors.white),
        )),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          extendedTextStyle: TextStyle(fontSize: 20, color: Colors.white),
          backgroundColor: Color.fromRGBO(192, 57, 43, 1),
        ),

        // style: BorderStyle()
      );
      break;
    case '4':
      tema = ThemeData(
        primaryColor: Color.fromARGB(
            255, 3, 157, 246), // Color.fromRGBO(55, 57, 84, 1.0),
        backgroundColor: Colors.black,
        scaffoldBackgroundColor: Colors.black,
        //Color.fromRGBO(           39, 174, 96, 1.0), // Color.fromRGBO(220, 118, 51, 1),
        textTheme: TextTheme(
            bodyText1: TextStyle(color: Color.fromARGB(255, 3, 157, 246)),
            bodyText2: TextStyle(color: Color.fromARGB(255, 3, 157, 246))),

        iconTheme:
            IconThemeData(color: Color.fromARGB(255, 3, 157, 246), size: 40),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          extendedTextStyle: TextStyle(
            color: Colors.amber,
            fontSize: 20,
          ),
          backgroundColor: Color.fromARGB(255, 6, 81, 156),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
          backgroundColor: Color.fromARGB(255, 3, 157, 246),
          textStyle: TextStyle(fontSize: 25, color: Colors.white),
        )),
      );
      break;
    case '5':
      tema = ThemeData(
        primaryColor: Colors.black54,
        backgroundColor: Colors.white, // Color.fromARGB(255, 143, 185, 168),
        scaffoldBackgroundColor: Colors.white, //Color.fromARGB(
        //  255, 225, 217, 217), //Color.fromARGB(255, 251, 246, 240),
        //Colors.grey[800], //  Color.fromRGBO(55, 57, 84, 1.0),
        textTheme: TextTheme(
            bodyText1: TextStyle(color: Colors.black54),
            bodyText2: TextStyle(color: Colors.black54)),
        iconTheme: IconThemeData(color: Colors.black54, size: 40),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
          backgroundColor: Color.fromRGBO(249, 75, 11, 1),
          textStyle: TextStyle(fontSize: 25, color: Colors.white),
        )),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          extendedTextStyle: TextStyle(fontSize: 20, color: Colors.white),
          backgroundColor: Color.fromRGBO(249, 75, 11, 1),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: Color.fromRGBO(249, 75, 11, 1),
            selectedIconTheme:
                IconThemeData(color: Colors.green, opacity: 0.6, size: 40.0),
            unselectedIconTheme: IconThemeData(
                color: Colors.green[100], opacity: 0.6, size: 30.0)),

        // style: BorderStyle()
      );
  }
  return tema;
}
