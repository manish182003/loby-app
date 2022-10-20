import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  final String? imageUrl;
  final String? name;
  final Widget? placeHolder;
  const CustomCachedNetworkImage({Key? key, this.imageUrl, this.name, this.placeHolder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return imageUrl == null ? placeHolder ?? profilePicture() : CachedNetworkImage(
      imageUrl: imageUrl!,
      fit: BoxFit.cover,
      height: 110,
      width: 110,
      placeholder: (context, url) =>  placeHolder ?? profilePicture(),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }

  Widget profilePicture(){
    return ProfilePicture(
      name: name ?? '',
      radius: 31,
      fontsize: 21,
      random: true,
      count: 1,
    );
  }
}
