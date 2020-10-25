import 'dart:developer';
import 'package:flutter/material.dart';
import 'ImgurGaleryObject.dart';

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
  final Color green = Colors.green;
  final Color white = Colors.white;

  String solovote = null;
  bool fav = false;

  @override
  void initState() {
    super.initState();
    fav = widget.image.favorite;
    solovote = widget.image.vote;
  }

  @override
  Widget build(BuildContext context) {
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
                  // inspect(widget.image);
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
                color: solovote == "up" ? green : white,
                icon: Icon(Icons.arrow_circle_up),
                onPressed: () {
                  print("up");
                  widget.image.upvote().then((value) => setState(() {
                        if (widget.image.vote == null) {
                          solovote = null;
                          // widget.image.downs -= 1;
                        } else {
                          solovote = "up";
                          // widget.image.ups += 1;
                        }
                      }));
                },
              ),
              Text(widget.image.ups.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 20)),
              IconButton(
                iconSize: 45,
                color: solovote == "down" ? green : white,
                icon: Icon(Icons.arrow_circle_down),
                onPressed: () {
                  widget.image.downvote().then((value) => setState(() {
                        if (widget.image.vote == null) {
                          solovote = null;
                          // widget.image.downs -= 1;
                        } else {
                          solovote = "down";
                          // widget.image.ups += 1;
                        }
                      }));
                  print("down");
                },
              ),
              Text(widget.image.downs.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 20)),
            ],
          )
        ],
      ),
    );
  }
}

const ImgurAPIClientID = "7dbef5d1452d32b";
