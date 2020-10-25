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
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData(
          primaryColor: Colors.grey[800],
        ),
        child: Column(children: [
          Container(height: 10),
          TextField(
            controller: myController,
            onEditingComplete: () {
              widget.user
                  .searchGallery(query: myController.text)
                  .then((val) => setState(() {
                        gallery.clear();
                        gallery.addAll(val);
                      }));
            },
            cursorColor: Color.fromARGB(255, 48, 71, 94),
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
              labelText: 'Title (needed)',
              icon: Icon(Icons.search),
            ),
          ),
          if (gallery.length != 0)
            Expanded(
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
        ]));
  }
}
