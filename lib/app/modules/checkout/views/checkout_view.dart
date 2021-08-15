import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:usergrocery/app/models/address_model.dart';
import 'package:usergrocery/app/models/cart_model.dart';

import 'package:usergrocery/app/modules/checkout/controllers/checkout_controller.dart';

import 'package:usergrocery/theme/color_theme.dart';

import '../../../../Constants.dart';

class CheckoutView extends GetView<CheckoutController> {
  final GetStorage getStorage = GetStorage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // bottomNavigationBar: buyNowBtn(),
        appBar: AppBar(
          title: Text(
            'Order Summary',
            style: TextStyle(color: textColor),
          ),
          leading: InkWell(
              onTap: () {
                Get.back();
              },
              child: Icon(Icons.arrow_back, color: Colors.amber, size: 30)),
          backgroundColor: Colors.white,
          centerTitle: true,
        ),
        body: PaginateFirestore(
          header: SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Select Delivery Address",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  FutureBuilder<QuerySnapshot>(
                    future: FirebaseFirestore.instance
                        .collection("address")
                        .where("state", isEqualTo: "west bengal")
                        .get(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
                        //  var data = snapshot.data;

                        //  List<DocumentChange<Object?>> data  = snapshot.data!.docChanges ;
                        //     Map<String,dynamic> datas =   data[0].doc.data() as   Map<String,dynamic>;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        
                            ListView.builder(
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              itemCount: snapshot.data!.docChanges.length,
                              itemBuilder: (BuildContext context, int index) {
                                Map<String, dynamic> data =
                                    snapshot.data!.docs[index].data()
                                        as Map<String, dynamic>;
                                AddressModel addressModel =
                                    AddressModel.fromJson(data);
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                        Obx(() => CheckboxListTile(
                                  onChanged: (value) {
                                    controller.checked.value = value!;
                                  },
                                  activeColor: Colors.deepOrange,
                                  tileColor: Colors.grey[200],
                                  subtitle: Text("Default Address"),
                                  value: controller.checked.value,
                                  title: Text("Deliver To This Address"),
                                  checkColor: Colors.white,
                                )),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 15, top: 5),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            addressModel.city!.toUpperCase(),
                                            style: TextStyle(fontSize: 18),
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            addressModel.address!,
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            addressModel.buildingApartmentName! +
                                                ",",
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                              addressModel.state! +
                                                  " " +
                                                  addressModel.pinCode.toString(),
                                              style: TextStyle()),
                                          SizedBox(height: 5),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                            Divider(),
                            OutlinedButton(
                                onPressed: () {},
                                child: Text(
                                  "Add new address",
                                  style: TextStyle(color: textColor),
                                ))
                          ],
                        );
                      } else {
                        return Text("something went wrong");
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          // Use SliverAppBar in header to make it sticky
          // header: SliverToBoxAdapter(
          //     child: Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.start,
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Text(
          //         'What would you',
          //         style: TextStyle(
          //             color: textColor,
          //             fontSize: 26,
          //             fontWeight: FontWeight.bold),
          //       ),
          //       Text(
          //         "like to Order??",
          //         style: TextStyle(
          //             color: textColor,
          //             fontSize: 20,
          //             fontWeight: FontWeight.bold),
          //       ),
          //       SizedBox(height: 20),
          //       Center(
          //         child: new Container(
          //           height: 140,
          //           child: Container(
          //               // margin: EdgeInsets.symmetric(vertical: 20.0),
          //               height: 140.0,
          //               child: StreamBuilder<QuerySnapshot>(
          //                 stream: FirebaseFirestore.instance
          //                     .collection("category_collection")
          //                     .snapshots(),
          //                 builder: (BuildContext context, snapshot) {
          //                   if (snapshot.hasError) {
          //                     return Text("Something went wrong");
          //                   }

          //                   if (snapshot.hasData) {
          //                     List<QueryDocumentSnapshot<Object?>> data =
          //                         snapshot.data!.docs;

          //                     return ListView.builder(
          //                       itemCount: data.length,
          //                       scrollDirection: Axis.horizontal,
          //                       itemBuilder:
          //                           (BuildContext context, int index) {
          //                         DocumentSnapshot datas = data[index];
          //                         return InkWell(
          //                           onTap: (){
          //                             CategoryWiseController.to.categoryId.value = datas.id;
          //                             Get.toNamed(Routes.CATEGORY_WISE);
          //                           },
          //                                                                 child: Padding(
          //                             padding: const EdgeInsets.all(8.0),
          //                             child: Column(
          //                               children: [
          //                                 Container(
          //                                   width: 80,
          //                                   decoration: BoxDecoration(
          //                                     shape: BoxShape.circle,
          //                                     gradient: LinearGradient(
          //                                       colors: [
          //                                            Colors.white,
          //                                           Colors.amber,

          //                                       ],
          //                                       begin: const FractionalOffset(
          //                                           0.0, 0.0),
          //                                       end: const FractionalOffset(
          //                                           0.0, 1.2),
          //                                       stops: [0.0, 1.0],
          //                                       tileMode: TileMode.clamp,
          //                                     ),
          //                                   ),

          //                                   // color: Colors.black.withOpacity(.7),
          //                                   child: Column(
          //                                     mainAxisAlignment: MainAxisAlignment.center,
          //                                     children: [
          //                                       Padding(
          //                                         padding: const EdgeInsets.all(12.0),
          //                                         child: Image.asset(images[index],height: 50,width: 50,),
          //                                       ),
          //                                       // Center(
          //                                       //   child: Padding(
          //                                       //     padding: const EdgeInsets.only(top:15),
          //                                       //     child: Text(
          //                                       //         datas['category_title']
          //                                       //             .toString()
          //                                       //             .toUpperCase(),
          //                                       //         style: TextStyle(
          //                                       //             fontWeight: FontWeight.bold,
          //                                       //             color: Colors.blueGrey,fontSize: 10)),
          //                                       //   ),
          //                                       // ),
          //                                     ],
          //                                   ),
          //                                 ),

          //                                 SizedBox(height:10),
          //                                   SizedBox(
          //                                     height: 40,
          //                                     width: 50,
          //                                     child: Text(
          //                                                 datas['category_title']
          //                                                     .toString()
          //                                                     .toUpperCase(),
          //                                                     maxLines: 2,
          //                                                     overflow: TextOverflow.ellipsis,
          //                                                 style: TextStyle(
          //                                                     fontWeight: FontWeight.bold,
          //                                                     color: Colors.blueGrey,fontSize: 9,)),
          //                                   ),

          //                               ],
          //                             ),
          //                           ),
          //                         );
          //                       },
          //                     );
          //                   }

          //                   return Text("loading");
          //                 },
          //               )),
          //         ),
          //       ),
          //       SizedBox(height: 20),
          //       Text("All Products",
          //           style: TextStyle(color: Colors.grey, fontSize: 24,fontWeight: FontWeight.bold)),
          //     ],
          //   ),
          // )),
          footer: SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  
                  children: [
                      Text(
                    "Payment Details",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 10,right: 10),
                      child: Table(
                        
                        border:TableBorder.all(color: textColor,) ,
                        children: [
            TableRow(
              
              children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Total Items"),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text("2")),
                      ),
            ]),
            
            TableRow(children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Total"),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text("599")),
                      ),
            ]),
          ]),
                    ),
                  ],
                ),
              )),
          // item builder type is compulsory.
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: .6,
          ),
          itemBuilderType:
              PaginateBuilderType.listView, //Change types accordingly
          itemBuilder: (index, context, documentSnapshot) {
            final data = documentSnapshot.data() as Map<String, dynamic>;
            controller.cartModel.value = CartModel.fromJson(data);

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Colors.white,
                height: 100,
                width: Get.width,
                child: FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection("product_collection")
                      .doc(controller.cartModel.value.productId.toString())
                      .get(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      return SizedBox.shrink();
                    } else {
                      DocumentSnapshot productData = snapshot.data;
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Card(
                              elevation: 0,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: AspectRatio(
                                    aspectRatio: 2 / 3,
                                    child: CachedNetworkImage(
                                      imageUrl: productData['theme_image'],
                                    )),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${productData['product_name']}",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 5),
                                  Text("Rs.${productData['mrp']}"),
                                  SizedBox(height: 10),
                                  Text("Qty : ${data['product_quantity']}"),

                                  
                                  // CartCounter(data: data,id:productData.id,catId:documentSnapshot.id),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),
              ),
            );
          },

          // orderBy is compulsory to enable pagination
          query: FirebaseFirestore.instance
              .collection('carts')
              .where("user_id", isEqualTo: getStorage.read(kfUid)),

          // listeners: [
          //   refreshChangeListener,

          // ],
          // to fetch real-time data
          isLive: true,
        ));

    // SingleChildScrollView(
    //   child: Column(
    //     children: [
    //       ListView.builder(
    //           shrinkWrap: true,
    //           physics: BouncingScrollPhysics(),
    //           itemCount: 10,
    //           itemBuilder: (context, index) {
    //             return  Dismissible (
    //               key:UniqueKey(),

    //                                   child: Padding(
    //                 padding: const EdgeInsets.all(8.0),
    //                 child: Container(
    //                   color: Colors.grey[200],
    //                   height: 100,
    //                   width: Get.width,
    //                   child: Row(
    //                     mainAxisAlignment: MainAxisAlignment.start,
    //                     children: [
    //                       Expanded(
    //                         flex: 2,
    //                         child: Padding(
    //                           padding: const EdgeInsets.all(8.0),
    //                           child: Container(
    //                             width: 100,
    //                             color: Colors.amber.withOpacity(.2),
    //                             child: Padding(
    //                               padding: const EdgeInsets.all(8.0),
    //                               child: AspectRatio(
    //                                 aspectRatio: 1 / 2,
    //                                 child: Image.asset(
    //                                     //replace this with cachenetwork image
    //                                     "assets/images/skincare.png"),
    //                               ),
    //                             ),
    //                           ),
    //                         ),
    //                       ),
    //                       Expanded(
    //                         flex: 2,
    //                         child: Padding(
    //                           padding: const EdgeInsets.all(8.0),
    //                           child: Column(
    //                             crossAxisAlignment: CrossAxisAlignment.start,
    //                             children: [
    //                               Text("Product title goes here",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
    //                               SizedBox(height: 20),
    //                               Text("Rs. 200"),
    //                             ],
    //                           ),
    //                         ),
    //                       ),
    //                       Expanded(
    //                           flex: 2,
    //                           child: Column(
    //                             mainAxisAlignment: MainAxisAlignment.center,
    //                             children: [
    //                               Expanded(
    //                                 flex: 1,
    //                                 child: Row(
    //                                   children: [
    //                                     Expanded(
    //                                       flex: 1,
    //                                       child: Row(
    //                                         mainAxisAlignment:
    //                                             MainAxisAlignment.center,
    //                                         children: [
    //                                           Container(
    //                                             height: 30,
    //                                             width: 30,
    //                                             // color: Colors.blueGrey[900],
    //                                             child: Card(
    //                                               color: Colors.amber
    //                                                   .withOpacity(.1),
    //                                               child: Icon(
    //                                                 Icons.remove,
    //                                                 color: Colors.white,
    //                                                 size: 18,
    //                                               ),
    //                                             ),
    //                                           ),
    //                                           Container(
    //                                             height: 20,
    //                                             width: 30,
    //                                             color: Colors.white,
    //                                             child: Center(
    //                                               child: Text(
    //                                                 "0",
    //                                                 style: TextStyle(
    //                                                     color: Colors
    //                                                         .blueGrey[900]),
    //                                               ),
    //                                             ),
    //                                           ),
    //                                           Container(
    //                                             height: 30,
    //                                             width: 30,
    //                                             // color: Colors.blueGrey[900],
    //                                             child: Card(
    //                                               color: Colors.amber[800]
    //                                                 ,
    //                                               child: Icon(
    //                                                 Icons.add,
    //                                                 color: Colors.white,
    //                                                 size: 18,
    //                                               ),
    //                                             ),
    //                                           )
    //                                         ],
    //                                       ),
    //                                     ),
    //                                   ],
    //                                 ),
    //                               ),
    //                             ],
    //                           ))
    //                     ],
    //                   ),
    //                 ),
    //               ),
    //             );
    //           })
    //     ],
    //   ),
    // ));
  }
}
