import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';

class CustomCachedNetworkImage extends StatefulWidget {
  final String? imageUrl;
  final String? name;
  final Widget? placeHolder;
  const CustomCachedNetworkImage(
      {super.key, this.imageUrl, this.name, this.placeHolder});

  @override
  State<CustomCachedNetworkImage> createState() =>
      _CustomCachedNetworkImageState();
}

class _CustomCachedNetworkImageState extends State<CustomCachedNetworkImage> {
  @override
  Widget build(BuildContext context) {
    return widget.imageUrl == null
        ? widget.placeHolder ?? profilePicture()
        : widget.imageUrl!.contains('http') ||
                widget.imageUrl!.contains('https')
            ? CachedNetworkImage(
                imageUrl: widget.imageUrl!,
                fit: BoxFit.cover,
                height: 110,
                width: 110,
                placeholder: (context, url) =>
                    widget.placeHolder ?? profilePicture(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              )
            : Image.file(
                File(widget.imageUrl!),
                fit: BoxFit.cover,
                height: 110,
                width: 110,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.error),
              );
  }

  Widget profilePicture() {
    return ProfilePicture(
      name: widget.name ?? '',
      radius: 36,
      fontsize: 21,
      random: true,
      count: 1,
    );
  }
}
