import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Imageslider extends StatefulWidget {
  const Imageslider({super.key});

  @override
  State<Imageslider> createState() => _ImagesliderState();
}

class _ImagesliderState extends State<Imageslider> {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      highlightColor: Colors.white,
      baseColor: Colors.grey.shade300,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          SizedBox(height: 8),
          Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              dot(),
              SizedBox(
                width: 3,
              ),
              dot(),
              SizedBox(
                width: 3,
              ),
              dot(),
              SizedBox(
                width: 3,
              ),
              dot(),
            ],
          )
        ],
      ),
    );
  }

  Widget dot() {
    return
    Container(
      height: 8,
      width: 8,
      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
    );
  }
}
