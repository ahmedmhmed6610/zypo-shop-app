import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop/utils/app_palette.dart';

itemImage(mediaUrl,
    {
    // width = 200.0,
    // height = 150.0,
    radius = 0.0,
    topOnly = false,
    fit = BoxFit.cover}) {
  return ClipRRect(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(radius),
      topRight: Radius.circular(radius),
      bottomRight: topOnly ? const Radius.circular(0) : Radius.circular(radius),
      bottomLeft: topOnly ? const Radius.circular(0) : Radius.circular(radius),
    ),
    child: CachedNetworkImage(
      fit: fit,
      imageUrl: mediaUrl,
      placeholder: (context, url) {
        return const Center(
          child: CircularProgressIndicator(color: AppPalette.lightPrimary),
        );
      },
      errorWidget: (context, url, error) {
        return const Center(
          child: Icon(Icons.error),
        );
      },
    ),
  );
}
