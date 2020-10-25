import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'ImgurAccountObject.dart';
import 'ImgurGalleryObject.dart';
import 'package:http/http.dart' as http;

class HomeCard extends StatefulWidget {
  String id;
  ImgurGallery image;
  HomeCard({this.image, this.id});
  @override
  _HomeCardState createState() => _HomeCardState();
}

class _HomeCardState extends State<HomeCard> {
  static const Icon fav_border = Icon(Icons.favorite_border);
  static const Icon fav_fill = Icon(Icons.favorite);
  bool fav = false;
  String avatar = "https://i.imgur.com/BoN9kdC.png";

  @override
  void initState() {
    super.initState();
    fav = widget.image.favorite;
    // fetchavatar(widget.image.account_url).then((value) => () {
    //       setState(() {
    //         avatar = value.avatar;
    //       });
    //     });
    // if (fav) {
    //   print("CARD");
    //   print(fav);
    //   inspect(widget.image);
    // }
  }

  // Future<ImgurAccountBase> fetchavatar(String username) async {
  //   final response = await http.get(
  //     "https://api.imgur.com/3/account/$username",
  //     headers: {HttpHeaders.authorizationHeader: "Client-ID $ImgurAPIClientID"},
  //   );
  //   return ImgurAccountBase.fromJson(
  //       json.decode(response.body)["data"], "", false);
  // }

  @override
  Widget build(BuildContext context) {
    // inspect(widget.image);
    return Card(
      elevation: 5,
      color: Color.fromARGB(255, 50, 50, 50),
      child: Column(
        children: [
          Container(height: 5),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Container(width: 10),
            Container(
              width: 30,
            ),
            Text(
              widget.image.account_url,
              style: TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
                fontSize: 20,
              ),
            ),
          ]),
          Container(height: 5),
          Image.network(widget.image.images.first.link),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                iconSize: 45,
                color: fav == true
                    ? Color.fromARGB(255, 255, 0, 0)
                    : Color.fromARGB(255, 255, 255, 255),
                icon: fav == true ? fav_fill : fav_border,
                onPressed: () {
                  if (widget.image.in_gallery == false &&
                      widget.image.favorite == true) {
                    print("id CONDITION");
                    print(widget.id);
                    print("not in gallery and favorite");
                    widget.image.favGalery(widget.id);
                  } else {
                    widget.image.favGalery(widget.image.id);
                  }
                  widget.image.images.first.favImage();
                  print("ON TOUCH");
                  inspect(widget.image);
                  widget.image.favorite_count +=
                      widget.image.favorite == true ? -1 : 1;
                  setState(() {
                    fav = !fav;
                  });
                },
              ),
              Text(widget.image.favorite_count.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 20)),
              IconButton(
                iconSize: 45,
                color: Color.fromARGB(255, 255, 255, 255),
                icon: Icon(Icons.comment),
                onPressed: () {
                  //TODO : go to comment screen and send it to imgure
                  print("GO COMMENTER");
                },
              ),
              Text(widget.image.comment_count.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 20))
            ],
          )
        ],
      ),
    );
  }
}

const ImgurAPIClientID = "7dbef5d1452d32b";
