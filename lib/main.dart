import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hs_nyc/home_page.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:hs_nyc/data.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of the application.

  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);//Locks the orientation to portrait only

    Data _data = Data();//creates a data object to be passed down the widget tree

    return ScopedModel<Data>(
      model: _data,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'NYC High School Data',
        theme: ThemeData(
          primarySwatch: Colors.yellow,
        ),
        home: HomePage(title: 'NYC HIGH SCHOOLS'),
      ),
    );
  }
}

