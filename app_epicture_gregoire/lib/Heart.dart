import 'dart:developer';
import 'dart:ffi';

import 'package:app_epicture_gregoire/ImgurGaleryObject.dart';
import 'package:app_epicture_gregoire/Global.dart';

import 'ImgurAcountObject.dart';
import 'BotomNavigation.dart';
import 'package:flutter/material.dart';
import 'Home.dart';
import 'Acount.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';

class Heart extends StatefulWidget {
  final String token;
  BasicCall user;
  Heart({this.token, this.user});
  @override
  _Heartstate createState() => _Heartstate();
}

class _Heartstate extends State<Heart> {
  int index = 0;
  ImgurAccountBase acount;

  //todo: get le acount id et toute les info ici pour les repartir partout
  @override
  void initState() {
    inspect(widget.user);
    super.initState();
    widget.user.getMyAccount().then((val) => setState(() {
          acount = val;
        }));
  }

  // static List<Widget> _widgetOptions = <Widget>[
  //   Home(user: widget.user),
  //   Text(
  //     'Index 1: search',
  //   ),
  //   Text(
  //     'Index 2: add',
  //   ),
  //   Text(
  //     'Index 3: like',
  //   ),
  //   Acount(),
  // ];

  Widget returnScreen(int indexValue) {
    if (indexValue == 0) {
      return Home(user: widget.user);
    }
    if (indexValue == 4) {
      return Acount(username: acount.url);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Epicture',
          style: TextStyle(
            color: Color.fromARGB(255, 48, 71, 94),
          ),
        ),
        toolbarHeight: 40.00,
        backgroundColor: Color.fromARGB(255, 231, 222, 200),
      ),
      body: Center(child: returnScreen(index)),
      // body: Center(child: _widgetOptions.elementAt(index)),
      bottomNavigationBar: MyNavigation(
        index,
        (int val) {
          setState(() {
            index = val;
            print(index);
          });
        },
      ),
    );
  }
}

// Future<ImgurAccountBase> getSelfAccount() async {
//   // if (_isLoggedIn == false) {
//   //   print("Not loggedin");
//   //   throw Exception("Not loggedin");
//   // }
//   String _accessToken = "";
//   String client_id = "4307dca97df57f9";
//   final response = await http.get(
//     "https://api.imgur.com/3/account/Lerimeur",
//     headers: {HttpHeaders.authorizationHeader: "Client-ID $client_id"},
//   );
//   return ImgurAccountBase.fromJson(
//       json.decode(response.body)["data"], _accessToken, true);
// }
