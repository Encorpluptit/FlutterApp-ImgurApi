import 'package:app_epicture_gregoire/Global.dart';

import 'ImgurAcountObject.dart';
import 'BotomNavigation.dart';
import 'package:flutter/material.dart';
import 'Home.dart';
import 'Account.dart';
import 'AddPicture.dart';

class Heart extends StatefulWidget {
  final String token;
  BasicCall user;
  Heart({this.token, this.user});
  @override
  _Heartstate createState() => _Heartstate();
}

class _Heartstate extends State<Heart> {
  int index = 0;
  ImgurAccountBase account;

  @override
  void initState() {
    super.initState();
    widget.user.getMyAccount().then((val) => setState(() {
          account = val;
        }));
  }

  Widget returnScreen(int indexValue) {
    if (indexValue == 0) {
      return Home(user: widget.user);
    }
    if (indexValue == 2) {
      return AddPicture();
    }
    if (indexValue == 4) {
      return Account(account: account);
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
