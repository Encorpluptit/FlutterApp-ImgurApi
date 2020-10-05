import 'package:flutter/material.dart';
import 'ImgurAcountObject.dart';
import 'dart:async';
import 'dart:convert';
import 'HomeCard.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'ImgurGaleryObject.dart';
import 'dart:io';

class Acount extends StatelessWidget {
  final String username;
  const Acount({this.username});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(username),
    );
  }
}

// class Acount extends StatefulWidget {
//   //acount username
//   //acount client-IDs
//   final String username;
//   const Acount({this.username});
//   @override
//   _AcountState createState() => _AcountState();
// }

// class _AcountState extends State<Acount> {
//   // Future<ImgurAccountBase> acountValue;

//   // @override
//   // void initState() {
//   //   super.initState();
//   //   acountValue = getSelfAccount();
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text(widget.username),
//       // child: FutureBuilder<ImgurAccountBase>(
//       //   future: acountValue,
//       //   builder: (context, snapshot) {
//       //     if (snapshot.hasData) {
//       //       print(snapshot.data);
//       //       return Column(
//       //         children: [
//       //           Text(snapshot.data.id.toString()),
//       //           Text(snapshot.data.url),
//       //           Image.network(snapshot.data.avatar),
//       //           Text(snapshot.data.reputation.toString()),
//       //           Text(snapshot.data.reputation_name),
//       //           Text(snapshot.data.created.toString()),
//       //         ],
//       //       );
//       //     } else if (snapshot.hasError) {
//       //       print('error');
//       //       return Text("${snapshot.error}");
//       //     }
//       //     return CircularProgressIndicator();
//       //   },
//       // ),
//     );
//   }
// }
