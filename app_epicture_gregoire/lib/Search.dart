import 'dart:developer';

import 'package:flutter/material.dart';
import 'Global.dart';
import 'ImgurGaleryObject.dart';
import 'HomeCard.dart';

class Search extends StatefulWidget {
  BasicCall user;
  Search({this.user});
  @override
  SearchState createState() => SearchState();
}

class SearchState extends State<Search> {
  List<ImgurGallery> gallery = new List<ImgurGallery>();
  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("SEARCH");
    inspect(gallery);

    return Column(children: [
      Container(height: 10),
      TextField(
        controller: myController,
        onEditingComplete: () {
          print(myController);
          widget.user
              .searchGallery(query: myController.text)
              .then((val) => setState(() {
                    gallery.clear();
                    gallery.addAll(val);
                  }));
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
          labelText: 'Title (needed)',
          icon: Icon(Icons.search),
        ),
      ),
      if (gallery.length != 0)
        Expanded(
            // wrap in Expanded
            child: ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                for (var item in gallery)
                  if (item.images.first.mp4_size == null)
                    HomeCard(
                      image: item,
                    ),
              ],
            ),
          ],
        ))
    ]);
  }
}
