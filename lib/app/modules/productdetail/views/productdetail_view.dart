import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:usergrocery/app/routes/app_pages.dart';
import 'package:usergrocery/theme/color_theme.dart';

import '../controllers/productdetail_controller.dart';

class ProductdetailView extends GetView<ProductdetailController> {
   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override

  
  Widget build(BuildContext context) {

  
    return Scaffold(

      key: _scaffoldKey,
      
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: InkWell(
              onTap: () {
                // controller.searchBtnPressed.value = false;
                Get.back();
              },
              child: Icon(Icons.arrow_back, color: iconColor, size: 30)),
          centerTitle: true,
          title: Obx(() {
            return Column(
              children: [
                Text(
                  controller.productName.value,
                  style: TextStyle(fontSize: 20, color: textColor),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  controller.productName.value,
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            );
          }),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: GetX<ProductdetailController>(
          builder: (_) {
            return SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FutureBuilder<DocumentSnapshot>(
                future: controller.getProductDetails(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return Text("Loading....");
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    return Column(
                      children: [
                        SizedBox(height: 20),
                        Center(
                          child: Card(
                            elevation: 0,
                            child: CachedNetworkImage(
                              imageUrl: snapshot.data['theme_image'],
                              height: 200,
                              width: 200,
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "\u20B9",
                              style: TextStyle(fontSize: 16, color: iconColor),
                            ),
                            // SizedBox(width: 5),
                            Text(
                              snapshot.data['mrp'],
                              style: TextStyle(fontSize: 30, color: textColor),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 25,
                                    width: 60,
                                    color: Colors.white,
                                    child: Icon(
                                      Icons.remove,
                                      color: iconColor,
                                      size: 18,
                                    ),
                                  ),
                                  Container(
                                    height: 25,
                                    width: 60,
                                    color: iconColor,
                                    child: Center(
                                      child: Text(
                                        "0",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 25,
                                    width: 60,
                                    color: Colors.white,
                                    child: Icon(
                                      Icons.add,
                                      color: iconColor,
                                      size: 18,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Text(
                          snapshot.data['product_details'],
                          style: TextStyle(fontSize: 18, color: textColor),
                        ),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              snapshot.data['quantity'],
                              style:
                                  TextStyle(fontSize: 15, color: Colors.grey),
                            ),
                            SizedBox(width: 5),
                            Text(
                              snapshot.data['unit'],
                              style:
                                  TextStyle(fontSize: 15, color: Colors.grey),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        SizedBox(
                          height: 50,
                          width: 250,
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            elevation: 10,
                            color: Colors.blueGrey[900],
                            child: Center(
                              child: Text(
                                "ADD TO CART",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Popular Products",
                          style: TextStyle(color: Colors.grey, fontSize: 18),
                        ),
                        // FutureBuilder<QuerySnapshot>(
                        //   future: controller.getRelatedProduct(),
                        //   builder:
                        //       (BuildContext context, AsyncSnapshot snapshot) {
                        //     if (snapshot.hasError) {
                        //       return Text("Something went wrong");
                        //     }

                        //     if (!snapshot.hasData) {
                        //       return Text("Document does not exist");
                        //     }

                        //     if (snapshot.connectionState ==
                        //         ConnectionState.done) {
                        //       List<DocumentSnapshot<Object?>> singleData =
                        //           snapshot.data.docs;
                        //       return ListView.builder(
                        //         shrinkWrap: true,
                        //         // scrollDirection: Axis.horizontal,
                        //         physics: BouncingScrollPhysics(),
                        //         itemCount: singleData.length,
                        //         itemBuilder: (BuildContext context, int index) {
                        //           DocumentSnapshot data = singleData[index];
                        //           return Container(
                        //             height: 400,
                        //             child: InkWell(
                        //               onTap: () async {
                        //                 controller.productId.value = data.id;

                        //                 await controller.getProductDetails();
                        //                 controller.categoryId.value =
                        //                     data['category_id'];
                        //                 controller.productName.value =
                        //                     data['product_name'];
                        //                 // Navigator.push(
                        //                 //   context,
                        //                 //   MaterialPageRoute(
                                            
                        //                 //       builder: (context) =>
                        //                 //           ProductdetailView())
                        //                 // );
                        //                 // Navigator.of(context);
                                        
                        //                 Get.toNamed(Routes.PRODUCTDETAIL,preventDuplicates: false,);
                        //               },
                        //               child: Card(
                        //                 shape: RoundedRectangleBorder(
                        //                   borderRadius:
                        //                       BorderRadius.circular(15),
                        //                 ),
                        //                 child: Column(
                        //                   children: [
                        //                     Padding(
                        //                       padding:
                        //                           const EdgeInsets.all(8.0),
                        //                       child: Text(
                        //                         data["product_name"],
                        //                         overflow: TextOverflow.ellipsis,
                        //                         style: TextStyle(
                        //                           fontWeight: FontWeight.bold,
                        //                           fontSize: 13,
                        //                           color: Colors.black87,
                        //                         ),
                        //                       ),
                        //                     ),
                        //                     Text(
                        //                       "Short detail",
                        //                       style: TextStyle(
                        //                         fontSize: 12,
                        //                         color: Colors.grey,
                        //                       ),
                        //                     ),
                        //                     SizedBox(
                        //                       height: 5,
                        //                     ),
                        //                     SizedBox(
                        //                       height: 100,
                        //                       width: 120,
                        //                       child: CachedNetworkImage(
                        //                         imageUrl: data['theme_image'],
                        //                         imageBuilder:
                        //                             (context, imageProvider) =>
                        //                                 Container(
                        //                           width: 100.0,
                        //                           height: 100.0,
                        //                           padding: EdgeInsets.all(10),
                        //                           decoration: BoxDecoration(
                        //                             borderRadius:
                        //                                 BorderRadius.circular(
                        //                                     10),
                        //                             // border: Border.all(
                        //                             //     color: Colors.grey),
                        //                             shape: BoxShape.rectangle,
                        //                             image: DecorationImage(
                        //                                 image: imageProvider,
                        //                                 fit: BoxFit.contain),
                        //                           ),
                        //                         ),
                        //                         placeholder: (context, url) =>
                        //                             Center(
                        //                                 child:
                        //                                     CircularProgressIndicator()),
                        //                         errorWidget:
                        //                             (context, url, error) =>
                        //                                 Icon(Icons.error),
                        //                       ),
                        //                     ),
                        //                     SizedBox(height: 10),
                        //                     Padding(
                        //                       padding: const EdgeInsets.only(
                        //                           left: 15),
                        //                       child: Row(
                        //                         mainAxisAlignment:
                        //                             MainAxisAlignment.start,
                        //                         children: [
                        //                           // Expanded(flex: 1, child: Text("hello")),
                        //                           Expanded(
                        //                             flex: 4,
                        //                             child: Text(
                        //                               "per ${data["quantity"].toString().toUpperCase()} ${data["unit"]}",
                        //                               style: TextStyle(
                        //                                   color: Colors.grey),
                        //                             ),
                        //                           )
                        //                         ],
                        //                       ),
                        //                     ),
                        //                     SizedBox(height: 10),
                        //                     Padding(
                        //                       padding: const EdgeInsets.only(
                        //                           left: 15),
                        //                       child: Row(
                        //                         mainAxisAlignment:
                        //                             MainAxisAlignment.start,
                        //                         children: [
                        //                           Expanded(
                        //                             flex: 1,
                        //                             child: Row(
                        //                               children: [
                        //                                 Text(
                        //                                   "\u20B9",
                        //                                   style: TextStyle(
                        //                                     fontWeight:
                        //                                         FontWeight.bold,
                        //                                   ),
                        //                                 ),
                        //                                 SizedBox(
                        //                                   width: 10,
                        //                                 ),
                        //                                 Text(
                        //                                   data["mrp"],
                        //                                   style: TextStyle(
                        //                                       fontSize: 16,
                        //                                       color: Colors
                        //                                           .blueGrey),
                        //                                 ),
                        //                               ],
                        //                             ),
                        //                           )
                        //                         ],
                        //                       ),
                        //                     ),
                        //                     SizedBox(height: 15),
                        //                     Padding(
                        //                       padding: const EdgeInsets.only(
                        //                           left: 15, right: 15),
                        //                       child: Row(
                        //                         children: [
                        //                           Expanded(
                        //                             flex: 1,
                        //                             child: Row(
                        //                               mainAxisAlignment:
                        //                                   MainAxisAlignment
                        //                                       .center,
                        //                               children: [
                        //                                 Container(
                        //                                   height: 25,
                        //                                   width: 40,
                        //                                   color:
                        //                                       Color(0xFFF5BA27),
                        //                                   child: Icon(
                        //                                     Icons.remove,
                        //                                     color: Colors.white,
                        //                                     size: 15,
                        //                                   ),
                        //                                 ),
                        //                                 Container(
                        //                                   height: 25,
                        //                                   width: 30,
                        //                                   color:
                        //                                       Colors.grey[200],
                        //                                   child: Center(
                        //                                     child: Text("0"),
                        //                                   ),
                        //                                 ),
                        //                                 Container(
                        //                                   height: 25,
                        //                                   width: 40,
                        //                                   color:
                        //                                       Color(0xFFF5BA27),
                        //                                   child: Icon(
                        //                                     Icons.add,
                        //                                     color: Colors.white,
                        //                                     size: 15,
                        //                                   ),
                        //                                 )
                        //                               ],
                        //                             ),
                        //                           ),
                        //                         ],
                        //                       ),
                        //                     ),
                        //                     SizedBox(height: 10),
                        //                   ],
                        //                 ),
                        //               ),
                        //             ),
                        //           );
                        //         },
                        //       );
                        //     }
                        //     return Text("Loading....");
                        //   },
                        // ),
                      ],
                    );
                  }
                  return Text("loading...");
                },
              ),
            ],
          ),
        );
          }
        )
        );
        
        
        
        
  }
}
