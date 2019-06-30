import 'package:flutter/material.dart';
import 'package:fluttery/framing.dart';
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
          onPressed: () {},
        ),
        actions: <Widget>[
          IconButton(
            color: iconColor,
            icon: Icon(Icons.menu),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          // round seek bar
          RandomColorBlock(
            width: double.infinity,
            height: 100,
          ),

          // visualizer
          RandomColorBlock(
            width: double.infinity,
            height: 125,
          ),

          // audio details
          Container(
            color: accentColor,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RichText(
                  text: TextSpan(
                    text: '',
                    children: [
                      TextSpan(
                        text: 'Song Title\n',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 4,
                            height: 1.5),
                      ),
                      TextSpan(
                        text: 'Artist name, Album name',
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.75),
                            fontSize: 12,
                            letterSpacing: 3,
                            height: 1.5),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // controls
          RandomColorBlock(
            width: double.infinity,
            height: 100,
          ),
        ],
      ),
    );
  }
}
