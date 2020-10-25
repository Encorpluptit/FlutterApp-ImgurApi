import 'package:app_epicture_gregoire/Global.dart';

import 'ImgurAccountObject.dart';
import 'package:flutter/material.dart';
import 'Home.dart';
import 'Account.dart';
import 'Favorites.dart';
import 'AddPost.dart';
import 'Search.dart';

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

  // ignore: missing_return
  Widget returnScreen(int indexValue) {
    if (indexValue == 0) {
      return Home(user: widget.user);
    }
    if (indexValue == 1) {
      return Search(user: widget.user);
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
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Likes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Color.fromARGB(255, 48, 71, 94),
        backgroundColor: Color.fromARGB(255, 231, 222, 200),
        onTap: _onItemTapped,
      ),
    );
  }
}
