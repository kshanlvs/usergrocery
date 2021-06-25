import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:usergrocery/app/modules/productdetail/controllers/productdetail_controller.dart';
import 'package:usergrocery/app/routes/app_pages.dart';
import 'package:usergrocery/app/widgets/products_card.dart';
import 'package:usergrocery/theme/color_theme.dart';

class ProductDetailWidget extends StatefulWidget {
  final ProductdetailController controller = Get.find();

  @override
  _ProductDetailWidgetState createState() => _ProductDetailWidgetState();
}

class _ProductDetailWidgetState extends State<ProductDetailWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        FutureBuilder<DocumentSnapshot>(
          future: widget.controller.getProductDetails(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Text("Loading....");
            } else if (snapshot.connectionState == ConnectionState.done) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                  Center(
                      child: Text(
                          "${snapshot.data['quantity']} ${snapshot.data['unit']}",style: TextStyle(fontSize: 16),)),

                  SizedBox(height: 10),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 15, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                                flex: 3,
                                child: Row(
                                  children: [
                                    Text(
                                      "\u20B9",
                                      style: TextStyle(
                                          fontSize: 16, color: iconColor),
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      snapshot.data['mrp'],
                                      style: TextStyle(
                                          fontSize: 30, color: Colors.black),
                                    ),
                                  ],
                                )),
                            Expanded(
                              flex: 2,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                    Expanded(
                                              flex: 1,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    height: 30,
                                                    width: 30,
                                                    // color: Colors.blueGrey[900],
                                                    child: Card(
                                                      color: Colors.amber
                                                          .withOpacity(.1),
                                                      child: Icon(
                                                        Icons.remove,
                                                        color: Colors.white,
                                                        size: 18,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 20,
                                                    width: 30,
                                                    color: Colors.white,
                                                    child: Center(
                                                      child: Text(
                                                        "0",
                                                        style: TextStyle(
                                                            color: Colors
                                                                .blueGrey[900]),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 30,
                                                    width: 30,
                                                    // color: Colors.blueGrey[900],
                                                    child: Card(
                                                      color: Colors.amber[800]
                                                        ,
                                                      child: Icon(
                                                        Icons.add,
                                                        color: Colors.white,
                                                        size: 18,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height:10),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                snapshot.data['product_name'],
                                style:
                                    TextStyle(color: textColor, fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height:5),
                        Row(children: [
                          Expanded(
                              flex: 1,
                              child: RatingBar.builder(
                                itemSize: 15,
                                initialRating: 3,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemPadding:
                                    EdgeInsets.symmetric(horizontal: 2.0),
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {
                                  print(rating);
                                },
                              )),
                        ]),
                  
                        SizedBox(height: 5),
                        Text(
                          "Product Description",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          snapshot.data['product_details'],
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    ),
                  ),
                
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 30,right: 30),
                    child: Divider(color: Colors.grey,),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 20),
                    child: Text(
                      "Related Products",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Center(
                    child: new Container(
                      height: 300,
                      child: Container(
                          // margin: EdgeInsets.symmetric(vertical: 20.0),
                          height: 300.0,
                          child: FutureBuilder<QuerySnapshot>(
                            future: widget.controller.getRelatedProduct(),
                            builder: (BuildContext context,
                                AsyncSnapshot snapshot) {
                              if (snapshot.hasError) {
                                return Text("Something went wrong");
                              }

                              if (snapshot.hasData) {
                                List<DocumentSnapshot<Object?>> singleData =
                                    snapshot.data.docs;

                                if (singleData.length >= 10) {
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    physics: BouncingScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 10,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      DocumentSnapshot data =
                                          singleData[index];
                                      return InkWell(
                                        onTap: () async {
                                          widget.controller.productId
                                              .value = data.id;

                                          await widget.controller
                                              .getProductDetails();
                                          widget.controller.categoryId
                                              .value = data['category_id'];
                                          widget.controller.productName
                                              .value = data['product_name'];
                                          Get.toNamed(
                                            Routes.PRODUCTDETAIL,
                                            preventDuplicates: false,
                                          );
                                        },
                                        child: Container(
                                          width: 200,

                                          // color: Colors.black.withOpacity(.7),
                                          child: ProductCards(id: data.id,data: data.data() as Map),
                                          
                                          
                                          
                                          
                                          
                                          // Card(
                                          //   shape: RoundedRectangleBorder(
                                          //     borderRadius:
                                          //         BorderRadius.circular(10),
                                          //   ),
                                          //   child: Column(
                                          //     children: [
                                          //       Padding(
                                          //         padding:
                                          //             const EdgeInsets.all(
                                          //                 8.0),
                                          //         child: Text(
                                          //           data["product_name"],
                                          //           overflow: TextOverflow
                                          //               .ellipsis,
                                          //           style: TextStyle(
                                          //             fontWeight:
                                          //                 FontWeight.bold,
                                          //             fontSize: 13,
                                          //             color: Colors.black87,
                                          //           ),
                                          //         ),
                                          //       ),
                                          //       Text(
                                          //         "Short detail",
                                          //         style: TextStyle(
                                          //           fontSize: 12,
                                          //           color: Colors.grey,
                                          //         ),
                                          //       ),
                                          //       SizedBox(
                                          //         height: 5,
                                          //       ),
                                          //       SizedBox(
                                          //         height: 100,
                                          //         width: 120,
                                          //         child: CachedNetworkImage(
                                          //           imageUrl:
                                          //               data['theme_image'],
                                          //           imageBuilder: (context,
                                          //                   imageProvider) =>
                                          //               Container(
                                          //             width: 100.0,
                                          //             height: 100.0,
                                          //             padding:
                                          //                 EdgeInsets.all(
                                          //                     10),
                                          //             decoration:
                                          //                 BoxDecoration(
                                          //               borderRadius:
                                          //                   BorderRadius
                                          //                       .circular(
                                          //                           10),
                                          //               // border: Border.all(
                                          //               //     color: Colors.grey),
                                          //               shape: BoxShape
                                          //                   .rectangle,
                                          //               image: DecorationImage(
                                          //                   image:
                                          //                       imageProvider,
                                          //                   fit: BoxFit
                                          //                       .contain),
                                          //             ),
                                          //           ),
                                          //           placeholder: (context,
                                          //                   url) =>
                                          //               Center(
                                          //                   child:
                                          //                       CircularProgressIndicator()),
                                          //           errorWidget: (context,
                                          //                   url, error) =>
                                          //               Icon(Icons.error),
                                          //         ),
                                          //       ),
                                          //       SizedBox(height: 10),
                                          //       Padding(
                                          //         padding:
                                          //             const EdgeInsets.only(
                                          //                 left: 15),
                                          //         child: Row(
                                          //           mainAxisAlignment:
                                          //               MainAxisAlignment
                                          //                   .start,
                                          //           children: [
                                          //             // Expanded(flex: 1, child: Text("hello")),
                                          //             Expanded(
                                          //               flex: 4,
                                          //               child: Text(
                                          //                 "per ${data["quantity"].toString().toUpperCase()} ${data["unit"]}",
                                          //                 style: TextStyle(
                                          //                     color: Colors
                                          //                         .grey),
                                          //               ),
                                          //             )
                                          //           ],
                                          //         ),
                                          //       ),
                                          //       SizedBox(height: 10),
                                          //       Padding(
                                          //         padding:
                                          //             const EdgeInsets.only(
                                          //                 left: 15),
                                          //         child: Row(
                                          //           mainAxisAlignment:
                                          //               MainAxisAlignment
                                          //                   .start,
                                          //           children: [
                                          //             Expanded(
                                          //               flex: 1,
                                          //               child: Row(
                                          //                 children: [
                                          //                   Text(
                                          //                     "\u20B9",
                                          //                     style:
                                          //                         TextStyle(
                                          //                       fontWeight:
                                          //                           FontWeight
                                          //                               .bold,
                                          //                     ),
                                          //                   ),
                                          //                   SizedBox(
                                          //                     width: 10,
                                          //                   ),
                                          //                   Text(
                                          //                     data["mrp"],
                                          //                     style: TextStyle(
                                          //                         fontSize:
                                          //                             16,
                                          //                         color: Colors
                                          //                             .blueGrey),
                                          //                   ),
                                          //                 ],
                                          //               ),
                                          //             )
                                          //           ],
                                          //         ),
                                          //       ),
                                          //       SizedBox(height: 15),
                                          //       Padding(
                                          //         padding:
                                          //             const EdgeInsets.only(
                                          //                 left: 15,
                                          //                 right: 15),
                                          //         child: Row(
                                          //           children: [
                                          //             Expanded(
                                          //               flex: 1,
                                          //               child: Row(
                                          //                 mainAxisAlignment:
                                          //                     MainAxisAlignment
                                          //                         .center,
                                          //                 children: [
                                          //                   Container(
                                          //                     height: 25,
                                          //                     width: 40,
                                          //                     color: Color(
                                          //                         0xFFF5BA27),
                                          //                     child: Icon(
                                          //                       Icons
                                          //                           .remove,
                                          //                       color: Colors
                                          //                           .white,
                                          //                       size: 15,
                                          //                     ),
                                          //                   ),
                                          //                   Container(
                                          //                     height: 25,
                                          //                     width: 30,
                                          //                     color: Colors
                                          //                             .grey[
                                          //                         200],
                                          //                     child: Center(
                                          //                       child: Text(
                                          //                           "0"),
                                          //                     ),
                                          //                   ),
                                          //                   Container(
                                          //                     height: 25,
                                          //                     width: 40,
                                          //                     color: Color(
                                          //                         0xFFF5BA27),
                                          //                     child: Icon(
                                          //                       Icons.add,
                                          //                       color: Colors
                                          //                           .white,
                                          //                       size: 15,
                                          //                     ),
                                          //                   )
                                          //                 ],
                                          //               ),
                                          //             ),
                                          //           ],
                                          //         ),
                                          //       ),
                                          //       SizedBox(height: 10),
                                          //     ],
                                          //   ),
                                          // ),
                                        ),
                                      );
                                    },
                                  );
                                } else {
                                  return Center(
                                      child:
                                          Text("Happy Shopping........"));
                                }
                              }

                              return Text("loading");
                            },
                          )),
                    ),
                  ),
                ],
              );
            }
            return Text("loading...");
          },
        ),
      ],
    );
  }
}
