import 'package:flutter/material.dart';

import '/components/components.dart';
import '/third_party/third_party.dart';

class InpaintedImage extends StatelessWidget {
  const InpaintedImage({
    super.key,
    required this.url,
  });

  final String url;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
        ),
        clipBehavior: Clip.antiAlias,
        child: Image(
          image: imageProvider,
          fit: BoxFit.contain,
        ),
      ),
      placeholder: (context, url) => Skeleton(
        isLoading: true,
        child: Container(
          height: double.maxFinite,
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          clipBehavior: Clip.antiAlias,
        ),
      ),
    );
  }
}
