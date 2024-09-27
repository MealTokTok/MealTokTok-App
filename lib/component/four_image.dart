import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Widget buildFourImage(
    List<String> imageList, double widthOfOne, double heightOfOne) {
  return Container(
      width: widthOfOne * 2,
      height: heightOfOne * 2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: imageList.length != 4
          ? const SizedBox(height: 0)
          : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: imageList[0],
                      width: widthOfOne,
                      height: heightOfOne,
                    ),
                  ),
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(10),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: imageList[1],
                      width: widthOfOne,
                      height: heightOfOne,
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: imageList[2],
                      width: widthOfOne,
                      height: heightOfOne,
                    ),
                  ),
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(10),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: imageList[3],
                      width: widthOfOne,
                      height: heightOfOne,
                    ),
                  )
                ],
              )
            ]));
}
