import 'dart:developer';

import 'package:app_epicture_gregoire/ImgurImageObject.dart';
import 'package:flutter/material.dart';

import 'HomeCard.dart';
import 'ImgurAccountObject.dart';
import 'ImgurGaleryObject.dart';

class Favorites extends StatelessWidget {
  ImgurAccountBase account;

  Favorites({this.account});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<List<ImgurGallery>>(
          future: account.getFavoriteImages(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      for (var item in snapshot.data)
                        if (item.images.first.mp4_size == null)
                          HomeCard(image: item),
                    ],
                  )
                ],
              );
            } else if (snapshot.hasError) {
              return Text("ERROR");
            }
            return CircularProgressIndicator();
          }),
    );
  }
}
