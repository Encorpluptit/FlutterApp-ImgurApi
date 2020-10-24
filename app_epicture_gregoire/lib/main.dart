import 'package:flutter/material.dart';
import 'Heart.dart';
import 'Global.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  BasicCall user = BasicCall();
  bool trigered = false;

  @override
  void initState() {
    super.initState();
    user.initvalue();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 203, 175, 135),
        body: Center(
          child: FutureBuilder<bool>(
              future: user.fetchToken(trigered),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data == true) {
                  return Heart(user: user);
                }
                return Column(children: [
                  Container(height: 200),
                  Text(
                    "EPICTURE",
                    style: TextStyle(
                      color: Color.fromARGB(255, 48, 71, 94),
                      fontSize: 50,
                      fontFamily: 'RobotoMono',
                    ),
                  ),
                  Container(height: 200),
                  RaisedButton(
                    child: Text("Connect With Imgur"),
                    textColor: Colors.white,
                    onPressed: () {
                      setState(() {
                        trigered = true;
                      });
                    },
                    color: Color.fromARGB(255, 48, 71, 94),
                  )
                ]);
              }),
        ),
      ),
    );
  }
}
