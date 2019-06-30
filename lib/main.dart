import 'package:flutter/material.dart';
import 'package:music_flutter/colors/colors.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Music Flutter',
            home: MyHomePage(),
        );
    }
}

class MyHomePage extends StatefulWidget {
    @override
    _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                leading: IconButton(
                    color: iconColor,
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: (){},
                ),
                actions: <Widget>[
                    IconButton(
                        color: iconColor,
                        icon: Icon(Icons.menu),
                        onPressed: (){},
                    ),
                ],
            ),
            body: Column(
                children: <Widget>[
                    // round seek bar
                    RandomColor
                    // visualizer

                    // audio details

                    // controls

                ],
            ),
        );
    }
}
