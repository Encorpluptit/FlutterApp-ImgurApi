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
  bool trigerd = false;

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
        backgroundColor: Colors.black,
        body: Center(
          child: FutureBuilder<bool>(
              future: user.fetchToken(trigerd),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data == true) {
                  return Heart(user: user);
                }
                return RaisedButton(
                  child: Text("CONECT"),
                  textColor: Colors.white,
                  onPressed: () {
                    setState(() {
                      trigerd = true;
                    });
                  },
                  color: Colors.red[600],
                );
              }),
        ),
      ),
    );
  }
}
