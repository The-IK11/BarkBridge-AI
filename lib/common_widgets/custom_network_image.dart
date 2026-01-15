// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:shimmer/shimmer.dart';

// import '../networks/endpoints.dart';

// class CustomNetworkImage extends StatelessWidget {
//   final String? imageUrl;
//   final String fallbackAssetPath;
//   final double? width;
//   final double? height;
//   final BoxFit fit;
//   final bool includeBase;
//   final bool isCircular;
//   final BorderRadius? borderRadius;

//   const CustomNetworkImage({
//     super.key,
//     required this.imageUrl,
//     this.fallbackAssetPath = 'assets/images/error_image.png',
//     this.width,
//     this.height,
//     this.fit = BoxFit.cover,
//     this.includeBase = false,
//     this.isCircular = false,
//     this.borderRadius,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final borderRadiusValue = isCircular
//         ? BorderRadius.circular((width ?? height ?? 50) / 2)
//         : (borderRadius ?? BorderRadius.zero);

//     return Card(
//       elevation: 4.w,
//       shape: RoundedRectangleBorder(borderRadius: borderRadiusValue),
//       child: ClipRRect(
//         borderRadius: borderRadiusValue,
//         child: imageUrl == null || imageUrl!.isEmpty
//             ? Image.asset(
//                 fallbackAssetPath,
//                 width: width,
//                 height: height,
//                 fit: fit,
//               )
//             : CachedNetworkImage(
//                 imageUrl: includeBase ? '$baseUrl/$imageUrl' : imageUrl!,
//                 width: width,
//                 height: height,
//                 fit: fit,
//                 placeholder: (context, url) => _buildShimmerPlaceholder(),
//                 errorWidget: (context, url, error) => Image.asset(
//                   fallbackAssetPath,
//                   width: width,
//                   height: height,
//                   fit: fit,
//                 ),
//               ),
//       ),
//     );
//   }

//   Widget _buildShimmerPlaceholder() {
//     return Shimmer.fromColors(
//       baseColor: Colors.grey[300]!,
//       highlightColor: Colors.grey[100]!,
//       child: Container(width: width, height: height, color: Colors.white),
//     );
//   }

//   /// Optional: Static helper for CircleAvatar or DecorationImage use
//   static ImageProvider getImageProvider(
//     String? url, {
//     bool includeBase = true,
//   }) {
//     if (url == null || url.isEmpty) {
//       return const AssetImage('assets/images/error_image.png');
//     }
//     return CachedNetworkImageProvider(includeBase ? '$baseUrl/$url' : url);
//   }
// }
