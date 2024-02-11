import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pinch_zoom/pinch_zoom.dart';

class ProductImage extends StatelessWidget {
  final String productImage;
  const ProductImage({required this.productImage, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: PinchZoom(
            child: CachedNetworkImage(
          imageUrl: productImage,
        )),
      ),
    );
  }
}
