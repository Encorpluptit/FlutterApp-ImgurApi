import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:app_epicture_gregoire/Acount.dart';
import 'Global.dart';
import 'HomeCard.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'ImgurGaleryObject.dart';
import 'dart:io';

class Home extends StatefulWidget {
  BasicCall user;
  Home({this.user});
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<ImgurGallery> gallery = new List<ImgurGallery>();
  int page = 0;
  bool end = false;

  FutureBuilder<List<ImgurGallery>> hello() {
    return FutureBuilder<List<ImgurGallery>>(
      future: widget.user.getGallery(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          gallery.addAll(snapshot.data);
          return NotificationListener<ScrollNotification>(
              child: ListView(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      for (var item in gallery)
                        if (item.images.first.mp4_size == null)
                          HomeCard(
                            urlpicture: item.images.first.link,
                            customHeigh: item.images.first.height,
                          ),
                    ],
                  )
                ],
              ),
              onNotification: (notification) {
                if (end == false &&
                    notification.metrics.pixels ==
                        notification.metrics.maxScrollExtent) {
                  end = true;
                  _loadMoreItems(page);
                }
                return true;
              });
        } else if (snapshot.hasError) {
          print('error');
          return Text("${snapshot.hasError}");
        }
        return CircularProgressIndicator();
      },
    );
  }

  Future _loadMoreItems(int page) async {
    List<ImgurGallery> tmp = await widget.user.getGallery();
    setState(() {
      // gallery.clear();
      gallery.addAll(tmp);
      end = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: hello(),
    );
  }
}
