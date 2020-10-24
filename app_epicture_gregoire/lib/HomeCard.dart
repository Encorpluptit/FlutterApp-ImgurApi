import 'dart:developer';

import 'package:flutter/material.dart';
import 'ImgurGaleryObject.dart';

class HomeCard extends StatefulWidget {
  final ImgurGallery image;
  const HomeCard({this.image});
  @override
  _HomeCardState createState() => _HomeCardState();
}

class _HomeCardState extends State<HomeCard> {
  static const Icon fav_border = Icon(Icons.favorite_border);
  static const Icon fav_fill = Icon(Icons.favorite);
  bool fav = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      child: Card(
        elevation: 5,
        color: Color.fromARGB(255, 50, 50, 50),
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Container(
                width: 30.0,
                height: 30.0,
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
                  fontSize: 13,
                ),
              ),
            ]),
            Image.network(widget.image.images.first.link),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  color: widget.image.favorite == true
                      ? Color.fromARGB(255, 255, 0, 0)
                      : Color.fromARGB(255, 255, 255, 255),
                  icon: widget.image.favorite == true ? fav_fill : fav_border,
                  onPressed: () {
                    widget.image.images.first.favImage(widget.image.images.first.id.toString());
                    widget.image.favorite_count += widget.image.favorite == true ? -1 : 1 ;
                    setState(() {
                      widget.image.favorite = !widget.image.favorite;
                    });
                  },
                ),
                Text(widget.image.favorite_count.toString(),
                    style: TextStyle(color: Colors.white)),
                IconButton(
                  color: Color.fromARGB(255, 255, 255, 255),
                  icon: Icon(Icons.comment),
                  onPressed: () {
                    //TODO : go to comment screen and send it to imgure
                    print("GO COMMENTER");
                  },
                ),
                Text(widget.image.comment_count.toString(),
                    style: TextStyle(color: Colors.white))
              ],
            )
          ],
        ),
      ),
    );
  }
}
