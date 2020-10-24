import 'dart:developer';

import 'package:flutter/material.dart';
import 'ImgurGaleryObject.dart';

class HomeCard extends StatefulWidget {
  ImgurGallery image;
  HomeCard({this.image});
  @override
  _HomeCardState createState() => _HomeCardState();
}

class _HomeCardState extends State<HomeCard> {
  static const Icon fav_border = Icon(Icons.favorite_border);
  static const Icon fav_fill = Icon(Icons.favorite);
  bool fav = false;

  @override
  void initState() {
    super.initState();
    fav = widget.image.favorite;
    // if (fav) {
    //   print("CARD");
    //   print(fav);
    //   inspect(widget.image);
    // }
  }

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
              width: 50.0,
              height: 50.0,
              decoration: new BoxDecoration(
                shape: BoxShape.circle,
                image: new DecorationImage(
                  fit: BoxFit.fill,
                  image: new NetworkImage(
                    "https://i.imgur.com/BoN9kdC.png",
                    // widget.image.link,
                  ),
                ),
              ),
            ),
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
          // Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          //   IconButton(
          //     color: fav
          //         ? Color.fromARGB(255, 255, 0, 0)
          //         : Color.fromARGB(255, 255, 255, 255),
          //     icon: fav ? fav_fill : fav_border,
          //     onPressed: () {
          //       widget.image.images.first
          //           .favImage(widget.image.images.first.id);
          //       widget.image.favorite_count += fav == true ? -1 : 1;
          //       setState(() {
          //         fav = !fav;
          //       });
          //     },
          //     iconSize: 45,
          //   ),
          // ]),
          // Image.network(widget.image.images.first.link),
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
                  widget.image.favGalery();
                  widget.image.images.first.favImage();
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
