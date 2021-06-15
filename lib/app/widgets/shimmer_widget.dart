// import 'package:flutter/material.dart';
// import 'package:shimmer/shimmer.dart';

// class ShimmerList extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     int offset = 0;
//     int time = 800;

//     return SafeArea(
//       child: ListView.builder(
//         shrinkWrap: true,
//         itemCount: 6,
//         itemBuilder: (BuildContext context, int index) {
//           offset += 5;
//           time = 800 + offset;

//           print(time);

//           return Padding(
//               padding: EdgeInsets.symmetric(horizontal: 15),
//               child: Shimmer.fromColors(
//                 highlightColor: Colors.white,
//                 baseColor: Colors.grey[300],
//                 child: ShimmerLayout(),
//                 period: Duration(milliseconds: time),
//               ));
//         },
//       ),
//     );
//   }
// }

// class ShimmerLayout extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     double containerWidth = 200;
//     double containerHeight = 15;

//     return Container(
//       margin: EdgeInsets.symmetric(vertical: 7.5),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: <Widget>[
//           Container(
//             decoration: BoxDecoration(
//                 color: Colors.grey,
//                 borderRadius: BorderRadius.all(Radius.circular(8.0))),
//             height: 80,
//             width: 80,
//           ),
//           //SizedBox(width: 10,),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               Container(
//                 height: containerHeight,
//                 width: containerWidth,
//                 color: Colors.grey,
//               ),
//               SizedBox(height: 5),
//               Container(
//                 height: containerHeight,
//                 width: containerWidth,
//                 color: Colors.grey,
//               ),
//               SizedBox(height: 5),
//               Container(
//                 height: containerHeight,
//                 width: containerWidth * 0.75,
//                 color: Colors.grey,
//               )
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }

// class ShimmerImage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: MediaQuery.of(context).size.width,
//       // height: 400.0,
//       child: Shimmer.fromColors(
//         child: Container(
//           color: Colors.grey,
//         ),
//         highlightColor: Colors.white,
//         baseColor: Colors.grey[300],
//         direction: ShimmerDirection.ltr,
//       ),
//     );
//   }
// }

// // class WallpaperImage extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Stack(
// //       children: <Widget>[
// //         wallpaper(context),
// //         Align(
// //           alignment: Alignment.bottomCenter,
// //           child: Container(
// //             margin: EdgeInsets.only(bottom: 25),
// //             child: shimmerText(),
// //           ),
// //         )
// //       ],
// //     );
// //   }

// class ShimmerText extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Shimmer.fromColors(
//       baseColor: Colors.grey[500],
//       highlightColor: Colors.white,
//       child: Text(
//         "> Slide to unlock",
//         style: TextStyle(fontSize: 25),
//       ),
//     );
//   }
// }

// //   wallpaper(BuildContext context) {
// //     return Container(
// //       height: MediaQuery.of(context).size.height,
// //       width: double.infinity,
// //       child: Image.asset(
// //         "wallpaper.jpg",
// //         fit: BoxFit.cover,
// //       ),
// //     );
// //   }
// // }
// class LoadingListPage extends StatefulWidget {
//   @override
//   _LoadingListPageState createState() => _LoadingListPageState();
// }

// class _LoadingListPageState extends State<LoadingListPage> {
//   bool _enabled = true;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Loading List'),
//       ),
//       body: Container(
//         width: double.infinity,
//         padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
//         child: Column(
//           mainAxisSize: MainAxisSize.max,
//           children: <Widget>[
//             Expanded(
//               child: Shimmer.fromColors(
//                 baseColor: Colors.grey[300],
//                 highlightColor: Colors.grey[100],
//                 enabled: _enabled,
//                 child: ListView.builder(
//                   itemBuilder: (_, __) => Padding(
//                     padding: const EdgeInsets.only(bottom: 8.0),
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Container(
//                           width: 48.0,
//                           height: 48.0,
//                           color: Colors.white,
//                         ),
//                         const Padding(
//                           padding: EdgeInsets.symmetric(horizontal: 8.0),
//                         ),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: <Widget>[
//                               Container(
//                                 width: double.infinity,
//                                 height: 8.0,
//                                 color: Colors.white,
//                               ),
//                               const Padding(
//                                 padding: EdgeInsets.symmetric(vertical: 2.0),
//                               ),
//                               Container(
//                                 width: double.infinity,
//                                 height: 8.0,
//                                 color: Colors.white,
//                               ),
//                               const Padding(
//                                 padding: EdgeInsets.symmetric(vertical: 2.0),
//                               ),
//                               Container(
//                                 width: 40.0,
//                                 height: 8.0,
//                                 color: Colors.white,
//                               ),
//                             ],
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                   itemCount: 6,
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 8.0),
//               child: FlatButton(
//                   onPressed: () {
//                     setState(() {
//                       _enabled = !_enabled;
//                     });
//                   },
//                   child: Text(
//                     _enabled ? 'Stop' : 'Play',
//                     style: Theme.of(context).textTheme.button.copyWith(
//                         fontSize: 18.0,
//                         color: _enabled ? Colors.redAccent : Colors.green),
//                   )),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
