import 'package:app_epicture_gregoire/ImgurImageObject.dart';
import 'package:flutter/material.dart';

import 'HomeCard.dart';
import 'ImgurAccountObject.dart';
import 'Account.dart';
import 'ImgurGaleryObject.dart';

class Favorites extends StatelessWidget {
  ImgurAccountBase account;

  Favorites({this.account});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<List<ImgurGallery>>(
          future: account.getFavoriteImages(),
          // future: account.getPersonalImages(),
          builder: (context, snapshot) {
            // print(snapshot.data); // TODO: Why ?
            if (snapshot.hasData) {
              print("LOOOOl");
              // inspect(snapshot.data); // TODO: Why ?
              for (var item in snapshot.data)
                print(item.images.first.link);
              return ListView(
                children: [

                Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  for (var item in snapshot.data)
                    if (item.images.first.mp4_size == null)
                      HomeCard(
                        image: item
                      ),
                  ]
                )
                ],
              );
            } else if (snapshot.hasError) {
              print('error');
              // return Text("${snapshot.error}");
              return Text("ERROR");
            }
            return CircularProgressIndicator();
          }),
    );
  }
}