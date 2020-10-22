import 'package:flutter/material.dart';

import 'Account.dart';
import 'ImgurAcountObject.dart';
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
              print("LOOOOl");
              // inspect(snapshot.data); // TODO: Why ?
              return Container(
                  child: Wrap(
                      children: List.generate(
                        snapshot.data.length,
                            (index) {
                          print("image OK");
                          print(snapshot.data
                              .elementAt(index)
                              .images
                              .first
                              .link);
                          return AccountCardImage(
                            src: snapshot.data
                                .elementAt(index)
                                .images
                                .first
                                .link,
                          );
                        },
                      )));

              // return GridView.count(
              //   // Create a grid with 2 columns. If you change the scrollDirection to
              //   // horizontal, this produces 2 rows.
              //   crossAxisCount: 2,
              //   // Generate 100 widgets that display their index in the List.
              //   children: List.generate(snapshot.data.length, (index) {
              //     print("LOOOOl2");
              //     return Center(
              //       child: Image.network(
              //           snapshot.data
              //               .elementAt(index)
              //               .images
              //               .first
              //               .link),
              //     );
              //   }),
              // );

            } else if (snapshot.hasError) {
              print('error');
              return Text("${snapshot.error}");
            }
            return CircularProgressIndicator();
          }),
    );
  }
}