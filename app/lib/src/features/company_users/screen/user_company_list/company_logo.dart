import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../utils/image_url_processor.dart';

class CompanyLogo extends StatelessWidget {
  const CompanyLogo({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final processedImageUrl = getLocalhostFriendlyImageUrl(imageUrl);
    return processedImageUrl.startsWith('http')
        ? CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(processedImageUrl),
          )
        : CircleAvatar(
            child: Image.asset(
              processedImageUrl,
              fit: BoxFit.cover,
            ),
          );
  }
}
