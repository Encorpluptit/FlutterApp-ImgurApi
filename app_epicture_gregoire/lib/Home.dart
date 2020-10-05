import 'dart:async';
import 'dart:convert';
import 'Global.dart';
import 'HomeCard.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'ImgurGaleryObject.dart';
import 'dart:io';

class Home extends StatelessWidget {
  BasicCall user;
  List<ImgurGallery> gallery;
  Home({this.user});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<List<ImgurGallery>>(
        future: user.getGallery(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            gallery = snapshot.data;
            return ListView(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    for (var item in snapshot.data)
                      if (item.images.first.mp4_size == null)
                        HomeCard(
                          urlpicture: item.images.first.link,
                          customHeigh: item.images.first.height,
                        ),
                  ],
                )
              ],
            );
          } else if (snapshot.hasError) {
            print('error');
            return Text("${snapshot.error}");
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
// class Home extends StatefulWidget {
//   List<ImgurGallery> homeGalery;
//   @override
//   _HomeState createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: FutureBuilder<List<ImgurGallery>>(
//         future: futureAlbum,
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             return ListView(
//               children: [
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     for (var item in snapshot.data)
//                       if (item.images.first.mp4_size == null)
//                         HomeCard(
//                           urlpicture: item.images.first.link,
//                           customHeigh: item.images.first.height,
//                         ),
//                   ],
//                 )
//               ],
//             );
//           } else if (snapshot.hasError) {
//             print('error');
//             return Text("${snapshot.error}");
//           }
//           return CircularProgressIndicator();
//         },
//       ),
//     );
//   }
// }
