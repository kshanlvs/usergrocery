// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:hd_mackup_studio/app/modules/widgets/shimmer_widget.dart';

// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';

// class ImageWidget extends GetView {
//   final String imageUrl;

//   const ImageWidget({@required this.imageUrl});
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       alignment: Alignment.center,
//       children: [
//         CachedNetworkImage(
//           imageUrl: "$imageUrl",
//           imageBuilder: (context, imageProvider) => Container(
//             decoration: BoxDecoration(
//               image: DecorationImage(
//                 image: imageProvider,
//                 fit: BoxFit.cover,
//                 // colorFilter: ColorFilter.mode(Colors.red, BlendMode.colorBurn),
//               ),
//             ),
//           ),

//           placeholder: (context, url) => ShimmerImage(),
//           // placeholder: (context, url) => Opacity(
//           //   opacity: .2,
//           //   child: SvgPicture.asset(
//           //     "assets/icons/Search Icon.svg",
//           //     height: 50,
//           //   ),
//           // ),
//           errorWidget: (context, url, error) => Opacity(
//             opacity: .2,
//             child: SvgPicture.asset(
//               "assets/icons/Close.svg",
//               height: 50,
//             ),
//           ),
//         )
//       ],
//     );
//   }
// }
