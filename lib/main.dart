import 'package:coviddata/ui/patients_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

Color _color = Color(0xFFf2f2f2); // Colors.grey[200]

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: _color,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));

    return MaterialApp(
      title: 'Covid Data',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        backgroundColor: Color.lerp(_color, Colors.black, 0.005),
        scaffoldBackgroundColor: _color,
        dialogBackgroundColor: Colors.grey[300],
        appBarTheme: AppBarTheme(
          brightness: Brightness.light,
          color: _color,
          textTheme: TextTheme(
            title: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
      ),
      home: PatientsPage(),
    );
  }
}
