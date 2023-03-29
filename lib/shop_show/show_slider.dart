import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

class Show_slider extends StatelessWidget {
  final String imageUrl;
  const Show_slider({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: CachedNetworkImage(
        imageUrl: '$imageUrl',
        progressIndicatorBuilder: (context, url, DownloadProgress) =>
            Shimmer.fromColors(
          highlightColor: Colors.white,
          baseColor: Colors.grey.shade300,
          child: Container(
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
        ),
        fit: BoxFit.cover,
        width: double.infinity,
      ),
    );
  }
}
