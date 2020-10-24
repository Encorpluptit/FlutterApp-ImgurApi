import 'dart:developer';

import 'package:app_epicture_gregoire/ImgurImageObject.dart';
import 'package:flutter/material.dart';

import 'HomeCard.dart';
import 'ImgurAccountObject.dart';
import 'ImgurGaleryObject.dart';

class Favorites extends StatelessWidget {
  ImgurAccountBase account;
  int index = 0;
  Favorites({this.account});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<List<ImgurGallery>>(
          future: account.getFavoriteImages(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print("hello");
              inspect(snapshot.data);
              return ListView(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      for (var index = 0; index < snapshot.data.length; index++)
                        if (snapshot.data[index].images.first.mp4_size == null)
                          if (snapshot.data[index].in_gallery == false)
                            HomeCard(
                              image: snapshot.data[index],
                              id: snapshot.data[index - 1].id,
                            )
                      //todo donner a la card l'id du truc avant pour del l'autre oue je me comprend tavu
                      // for (var item in snapshot.data)
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
