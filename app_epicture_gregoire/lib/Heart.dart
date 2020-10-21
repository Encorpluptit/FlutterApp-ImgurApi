import 'package:app_epicture_gregoire/Global.dart';

import 'ImgurAcountObject.dart';
import 'BotomNavigation.dart';
import 'package:flutter/material.dart';
import 'Home.dart';
import 'Acount.dart';
import 'AddPost.dart';

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

  @override
  void initState() {
    super.initState();
    widget.user.getMyAccount().then((val) => setState(() {
          acount = val;
        }));
  }

  Widget returnScreen(int indexValue) {
    if (indexValue == 0) {
      return Home(user: widget.user);
    }
    if (indexValue == 2) {
      return AddPost(user: widget.user);
    }
    if (indexValue == 4) {
      return Acount(account: acount);
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
          });
        },
      ),
    );
  }
}
