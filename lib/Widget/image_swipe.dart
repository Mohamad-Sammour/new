import 'package:flutter/material.dart';

class ImageSwip extends StatefulWidget {
  final List ? imageList;

  ImageSwip({this.imageList});


  @override
  _ImageSwipState createState() => _ImageSwipState();
}

class _ImageSwipState extends State<ImageSwip> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height:400.0,
      child:Stack(
        children: [
          PageView(
            children: [
              for(var i=0;i < widget.imageList!.length; i++)
                Container(
                  child: Image.network(
                    "${widget.imageList![i]}",
                    fit: BoxFit.cover,
                  ),
                ),
            ],
          ),
          Positioned(
            bottom: 20.0,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for(var i=0;i < widget.imageList!.length; i++)
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 5.0,
                    ),
                    width: 15.0,
                    height: 15.0,
                    color: Colors.white,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
