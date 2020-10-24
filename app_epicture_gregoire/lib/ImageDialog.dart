import 'package:flutter/material.dart';

class ImageDialog extends StatelessWidget {
  final String src;

  const ImageDialog({Key key, this.src}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.95,
        // height: 200,
        child: FittedBox(
          child: Image.network(src),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
