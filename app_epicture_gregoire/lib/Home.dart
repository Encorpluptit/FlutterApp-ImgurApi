import 'dart:developer';

import 'Global.dart';
import 'HomeCard.dart';
import 'package:flutter/material.dart';
import 'ImgurGalleryObject.dart';

class Home extends StatefulWidget {
  BasicCall user;
  Home({this.user});
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<ImgurGallery> gallery = new List<ImgurGallery>();
  int page = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<List<ImgurGallery>>(
        future: widget.user.getGallery(page: page.toString()),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            inspect(snapshot.data[1]);
            return ListView(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    for (var item in gallery)
                      if (item.images.first.mp4_size == null)
                        HomeCard(
                          image: item,
                        ),
                    for (var i = 0; i < 100 && i != snapshot.data.length; i++)
                      if (snapshot.data[i].images.first.mp4_size == null)
                        HomeCard(
                          image: snapshot.data[i],
                        ),
                    RaisedButton(
                      child: Text("FETCH"),
                      elevation: 10,
                      textColor: Colors.grey[700],
                      onPressed: () {
                        setState(() {
                          gallery.addAll(snapshot.data);
                          page += 1;
                        });
                      },
                      color: Color.fromARGB(255, 231, 222, 200),
                    ),
                  ],
                )
              ],
            );
          } else if (snapshot.hasError) {
            print('error');
            return Text("${snapshot.hasError}");
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
