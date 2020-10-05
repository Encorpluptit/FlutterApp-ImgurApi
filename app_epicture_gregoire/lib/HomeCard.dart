import 'package:flutter/material.dart';

class HomeCard extends StatefulWidget {
  final String urlpicture;
  final int token;
  final int customHeigh;
  const HomeCard({this.urlpicture, this.token, this.customHeigh});
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
            Image.network(widget.urlpicture),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  color: fav
                      ? Color.fromARGB(255, 255, 0, 0)
                      : Color.fromARGB(255, 255, 255, 255),
                  icon: fav ? fav_fill : fav_border,
                  onPressed: () {
                    print(widget.token);
                    setState(() {
                      fav = !fav;
                    });
                  },
                ),
                IconButton(
                  color: Color.fromARGB(255, 255, 255, 255),
                  icon: Icon(Icons.comment),
                  onPressed: () {
                    //TODO : go to comment screen and send it to imgure
                    print("GO COMMENTÉ");
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
