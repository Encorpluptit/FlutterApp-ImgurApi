import 'dart:developer';

import 'package:flutter/material.dart';
import 'ImgurAcountObject.dart';
import 'ImgurGaleryObject.dart';

class Acount extends StatelessWidget {
  ImgurAccountBase account;
  Acount({this.account});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<List<ImgurGallery>>(
          future: account.getPersonalImages(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print('tezezmklre');
              inspect(snapshot.data);
              return GridView.count(
                // Create a grid with 2 columns. If you change the scrollDirection to
                // horizontal, this produces 2 rows.
                crossAxisCount: 2,
                // Generate 100 widgets that display their index in the List.
                children: List.generate(snapshot.data.length, (index) {
                  return Center(
                    child: Image.network(
                        snapshot.data.elementAt(index).images.first.link),
                  );
                }),
              );
            } else if (snapshot.hasError) {
              print('error');
              return Text("${snapshot.error}");
            }
            print("lol");
            return CircularProgressIndicator();
          }),
    );
  }

  // Widget hello() {
  //   print("hello function");
  //   FutureBuilder<List<ImgurGallery>>(
  //       future: account.getPersonalImages(),
  //       builder: (context, snapshot) {
  //         if (snapshot.hasData) {
  //           print('tezezmklre');
  //           print(snapshot.data);
  //           return ListView(
  //             children: [
  //               Column(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: <Widget>[
  //                   for (var item in snapshot.data)
  //                     if (item.images.first.mp4_size == null)
  //                       HomeCard(
  //                         urlpicture: item.images.first.link,
  //                         customHeigh: item.images.first.height,
  //                       ),
  //                 ],
  //               )
  //             ],
  //           );
  //         } else if (snapshot.hasError) {
  //           print('error');
  //           return Text("${snapshot.error}");
  //         }
  //         print("lol");
  //         return CircularProgressIndicator();
  //       });
  //   print('fair enoth');
  // }
}
