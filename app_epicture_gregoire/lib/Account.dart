import 'package:flutter/material.dart';

import 'ImgurAcountObject.dart';
import 'ImgurGaleryObject.dart';

class Account extends StatelessWidget {
  ImgurAccountBase account;

  Account({this.account});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<List<ImgurGallery>>(
          future: account.getPersonalImages(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 110,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        // image: DecorationImage(
                        // image: AssetImage(profile.imageUrl), fit: BoxFit.cover),
                        // image: AssetImage(account.getPersonalImages().first.link), fit: BoxFit.cover),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        // profile.title,
                        'COUCOU',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 20),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      alignment: Alignment.center,
                      child: Text(
                        // profile.subtitle,
                        'LOL',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Text(
                                // profile.totalPost,
                                '1337',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              Text('Post')
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Text(
                                // profile.totalFollowers,
                                '42',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              Text('Followers')
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Text(
                                '4242',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              Text('Following')
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                        child: Wrap(
                            children: List.generate(
                      snapshot.data.length,
                      (index) {
                        return Center(
                          child: Image.network(
                              snapshot.data.elementAt(index).images.first.link),
                        );
                      },
                      // children: <Widget>[
                      //   for (var item in snapshot.data)
                      //     if (item.images.first.mp4_size == null)
                      //       HomeCard(
                      //         urlpicture: item.images.first.link,
                      //         customHeigh: item.images.first.height,
                      //       ),
                      //   for (int i = 0; i < snapshot.data.length; i++)
                      //     GestureDetector(
                      //       onTap: () {
                      //         // profile = AppData.profiles[i];
                      //         // setState(() {});
                      //       },
                      //       child: Container(
                      //         height: MediaQuery
                      //             .of(context)
                      //             .size
                      //             .width / 3,
                      //         width: MediaQuery
                      //             .of(context)
                      //             .size
                      //             .width / 3,
                      //         decoration: BoxDecoration(
                      //             image: DecorationImage(
                      //                 image: AssetImage(
                      //                     AppData.profiles[i].imageUrl),
                      //                 fit: BoxFit.cover)),
                      //       ),
                      //     )
                      // ],
                    )))
                  ],
                ),
              );
              // print('tezezmklre');
              // inspect(snapshot.data);
              // return GridView.count(
              //   // Create a grid with 2 columns. If you change the scrollDirection to
              //   // horizontal, this produces 2 rows.
              //   crossAxisCount: 2,
              //   // Generate 100 widgets that display their index in the List.
              //   children: List.generate(snapshot.data.length, (index) {
              //     return Center(
              //       child: Image.network(
              //           snapshot.data.elementAt(index).images.first.link),
              //     );
              //   }),
              // );
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
