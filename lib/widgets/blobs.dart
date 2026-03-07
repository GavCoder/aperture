import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Blobs extends StatelessWidget {
  final String blobPath;
  final double svgWidth;
  final double? bottomPosition, topPosition, leftPosition, rightPosition;

  const Blobs({
    super.key,
    required this.blobPath,
    this.topPosition, // Optional parameters for positioning the blob
    this.leftPosition,
    this.bottomPosition,
    this.rightPosition,
    required this.svgWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: topPosition,
      left: leftPosition,
      bottom: bottomPosition,
      right: rightPosition,
      child: ImageFiltered(
        imageFilter: ImageFilter.blur(
          sigmaX: 8,
          sigmaY: 8,
        ),
        child: SvgPicture.asset(
          blobPath,
          width: svgWidth,
        ),
      ),
    );
  }
}
