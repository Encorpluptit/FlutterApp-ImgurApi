import 'package:app_epicture_gregoire/Global.dart';

import 'ImgurAccountObject.dart';
import 'BotomNavigation.dart';
import 'package:flutter/material.dart';
import 'Home.dart';
import 'Account.dart';
import 'Favorites.dart';
import 'AddPost.dart';

class Heart extends StatefulWidget {
  final String token;
  BasicCall user;
  Heart({this.token, this.user});
  @override
  _Heartstate createState() => _Heartstate();
}

class _Heartstate extends State<Heart> {
  int _selectedIndex = 0;
  ImgurAccountBase account;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
      return AddPost(user: widget.user);
    }
    if (indexValue == 3) {
      return Favorites(account: account);
    }
    if (indexValue == 4) {
      return Account(account: account);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
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
      body: Center(child: returnScreen(_selectedIndex)),
      // body: Center(child: _widgetOptions.elementAt(index)),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Business',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box),
            label: 'School',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'School',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'School',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Color.fromARGB(255, 48, 71, 94),
        backgroundColor: Color.fromARGB(255, 231, 222, 200),
        onTap: _onItemTapped,
      ),
      // bottomNavigationBar: MyNavigation(
      //   index,
      //   (int val) {
      //     setState(() {
      //       index = val;
      //     });
      //   },
      // ),
    );
  }
}
