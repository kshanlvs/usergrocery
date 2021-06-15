import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:paginate_firestore/bloc/pagination_listeners.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:get/get.dart';
import 'package:usergrocery/app/modules/home/controllers/home_controller.dart';
import 'package:usergrocery/app/modules/productdetail/controllers/productdetail_controller.dart';
import 'package:usergrocery/theme/color_theme.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final ProductdetailController productdetailController =
      Get.put(ProductdetailController());
  final PaginateRefreshedChangeListener refreshChangeListener =
      PaginateRefreshedChangeListener();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "ApnaBazar",
            style: TextStyle(color: Colors.blueGrey),
          ),
          backgroundColor: Colors.white,
          leading: Icon(Icons.shopping_cart, color: Colors.amber, size: 30),
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Icon(
                Icons.search,
                color: Colors.grey,
                size: 30,
              ),
            )
          ],
        ),
        body: PaginateFirestore(
          // Use SliverAppBar in header to make it sticky
          header: SliverToBoxAdapter(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'What would you',
                  style: TextStyle(
                      color: textColor,
                      fontSize: 26,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "like to Order??",
                  style: TextStyle(
                      color: textColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Center(
                  child: new Container(
                    height: 100,
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      children: <Widget>[
                        Container(
                            // margin: EdgeInsets.symmetric(vertical: 20.0),
                            height: 100.0,
                            child: StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection("category_collection")
                                  .snapshots(),
                              builder: (BuildContext context, snapshot) {
                                if (snapshot.hasError) {
                                  return Text("Something went wrong");
                                }

                                if (snapshot.hasData) {
                                  List<QueryDocumentSnapshot<Object?>> data =
                                      snapshot.data!.docs;

                                  return ListView.builder(
                                    itemCount: data.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      DocumentSnapshot datas = data[index];
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                  Colors.amber,
                                                Colors.white,
                                              
                                              ],
                                              begin: const FractionalOffset(
                                                  0.0, 0.0),
                                              end: const FractionalOffset(
                                                  1.8, 0.0),
                                              stops: [0.0, 1.0],
                                              tileMode: TileMode.clamp,
                                            ),
                                          ),

                                          // color: Colors.black.withOpacity(.7),
                                          child: Center(
                                            child: Padding(
                                              padding: const EdgeInsets.all(12.0),
                                              child: Text(
                                                  datas['category_title']
                                                      .toString()
                                                      .toUpperCase(),
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.blueGrey)),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                }

                                return Text("loading");
                              },
                            )),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text("All Products",
                    style: TextStyle(color: Colors.grey, fontSize: 18)),
              ],
            ),
          )),
          // footer: SliverToBoxAdapter(child: Text('FOOTER')),
          // item builder type is compulsory.
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: .6,
          ),
          itemBuilderType:
              PaginateBuilderType.gridView, //Change types accordingly
          itemBuilder: (index, context, documentSnapshot) {
            final data = documentSnapshot.data() as Map;
            return InkWell(
              onTap: () async {
                ProductdetailController.to.productName.value =
                    data['product_name'];
                ProductdetailController.to.productId.value =
                    documentSnapshot.id;
                ProductdetailController.to.categoryId.value =
                    data['category_id'];
                //  await Get.toNamed(Routes.PRODUCTDETAIL);
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        data["product_name"],
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    Text(
                      "Short detail",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      height: 100,
                      width: 120,
                      child: CachedNetworkImage(
                        imageUrl: data['theme_image'],
                        imageBuilder: (context, imageProvider) => Container(
                          width: 100.0,
                          height: 100.0,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            // border: Border.all(
                            //     color: Colors.grey),
                            shape: BoxShape.rectangle,
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.contain),
                          ),
                        ),
                        placeholder: (context, url) =>
                            Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // Expanded(flex: 1, child: Text("hello")),
                          Expanded(
                            flex: 4,
                            child: Text(
                              "per ${data["quantity"].toString().toUpperCase()} ${data["unit"]}",
                              style: TextStyle(color: Colors.grey),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Row(
                              children: [
                                Text(
                                  "\u20B9",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  data["mrp"],
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.blueGrey),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 25,
                                  width: 40,
                                  color: Color(0xFFF5BA27),
                                  child: Icon(
                                    Icons.remove,
                                    color: Colors.white,
                                    size: 15,
                                  ),
                                ),
                                Container(
                                  height: 25,
                                  width: 30,
                                  color: Colors.grey[200],
                                  child: Center(
                                    child: Text("0"),
                                  ),
                                ),
                                Container(
                                  height: 25,
                                  width: 40,
                                  color: Color(0xFFF5BA27),
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 15,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            );

            //  Card(
            //                   child: Column(
            //                     children: [
            //                       Row(
            //                         crossAxisAlignment: CrossAxisAlignment.start,
            //                         children: [
            //                           Expanded(
            //                             flex: 1,
            //                             child: Padding(
            //                               padding: const EdgeInsets.all(8.0),
            //                               child: CachedNetworkImage(
            //                                 height: 100,
            //                                 width: 100,
            //                                 memCacheHeight: 100,
            //                                 memCacheWidth: 100,
            //                                 imageUrl: data['theme_image'],
            //                                 imageBuilder:
            //                                     (context, imageProvider) =>
            //                                         Container(
            //                                   width: 100.0,
            //                                   height: 100.0,
            //                                   padding: EdgeInsets.all(10),
            //                                   decoration: BoxDecoration(
            //                                     borderRadius:
            //                                         BorderRadius.circular(10),
            //                                     // border: Border.all(
            //                                     //     color: Colors.grey),
            //                                     shape: BoxShape.rectangle,
            //                                     image: DecorationImage(
            //                                         image: imageProvider,
            //                                         fit: BoxFit.contain),
            //                                   ),
            //                                 ),
            //                                 placeholder: (context, url) => Center(
            //                                     child:
            //                                         CircularProgressIndicator()),
            //                                 errorWidget: (context, url, error) =>
            //                                     Icon(Icons.error),
            //                               ),
            //                             ),
            //                           ),
            //                           Expanded(
            //                             flex: 2,
            //                             child: Padding(
            //                               padding: const EdgeInsets.all(10.0),
            //                               child: Column(
            //                                 crossAxisAlignment:
            //                                     CrossAxisAlignment.start,
            //                                 children: [
            //                                   Text(
            //                                     data['product_name'],
            //                                     style:
            //                                         TextStyle(color: Colors.grey),
            //                                   ),
            //                                   SizedBox(height: 5),
            //                                   Text(
            //                                     "${data['quantity']} ${data['unit']} ",
            //                                     style:
            //                                         TextStyle(color: Colors.grey),
            //                                   ),
            //                                   SizedBox(height: 5),
            //                                   Text(
            //                                     "\u{20B9} ${data['mrp']}  ",
            //                                     style: TextStyle(
            //                                       color: Colors.black,
            //                                     ),
            //                                   ),
            //                                 ],
            //                               ),
            //                             ),
            //                           ),
            //                         ],
            //                       ),
            //                       Padding(
            //                         padding: const EdgeInsets.all(8.0),
            //                         child: Divider(thickness: 2),
            //                       ),
            //                       Padding(
            //                         padding: const EdgeInsets.only(
            //                             right: 10, bottom: 10),
            //                         child: Row(
            //                           mainAxisAlignment: MainAxisAlignment.end,
            //                           children: [
            //                             InkWell(
            //                               onTap: () {
            //                                 // ProductEditController.to.pId.value =
            //                                 //     documentSnapshot.id;
            //                                 //     Get.toNamed(Routes.PRODUCT_EDIT);

            //                               },
            //                               child: Text("EDIT",style: TextStyle(color: Colors.green),)
            //                             ),
            //                             SizedBox(width: 15),
            //                             InkWell(
            //                               onTap: () {
            //                                 showDialog(
            //                                   context: context,
            //                                   builder: (context) {
            //                                     return AlertDialog(
            //                                       title: Text(
            //                                         'Are You Sure??',
            //                                         style: TextStyle(
            //                                             fontSize: 16,
            //                                             color: Colors.green),
            //                                       ),
            //                                       content: Text(
            //                                         'Product Will Be Deleted Permanently  ..',
            //                                         style: TextStyle(
            //                                             color: Colors.grey),
            //                                       ),
            //                                      actions: <Widget>[
            //                                         FlatButton(
            //                                           onPressed: () {
            //                                             FirebaseFirestore.instance
            //                                                 .collection(
            //                                                     "product_collection")
            //                                                 .doc(documentSnapshot.id)
            //                                                 .delete();
            //                                             Get.back();
            //                                             // Fluttertoast.showToast(
            //                                             //     msg:
            //                                             //         'Product Deleted Successfully');
            //                                           },
            //                                           child: Text("CONFIRM",
            //                                               style: TextStyle(
            //                                                 color: Colors.orange,
            //                                               )),
            //                                         ),
            //                                         FlatButton(
            //                                             onPressed: () =>
            //                                                 Get.back(),
            //                                             child: Text(
            //                                               'CANCEL',
            //                                               style: TextStyle(
            //                                                   color: Colors.grey),
            //                                             )),
            //                                       ],
            //                                     );
            //                                   },
            //                                 );
            //                                 // FirebaseFirestore.instance
            //                                 //     .collection("product_collection")
            //                                 //     .doc(data.id)
            //                                 //     .delete();
            //                               },
            //                               child: Text("DELETE",style: TextStyle(color: Colors.orange),)
            //                             ),
            //                             SizedBox(width: 10),
            //                             // Icon(
            //                             //   Icons.arrow_forward,
            //                             //   color: Colors.grey,
            //                             // ),
            //                           ],
            //                         ),
            //                       ),
            //                     ],
            //                   ),
            //                 );
          },
          // orderBy is compulsory to enable pagination
          query: FirebaseFirestore.instance.collection('product_collection'),
          listeners: [
            refreshChangeListener,
          ],
          // to fetch real-time data
          isLive: true,
        ));
  }
}

// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';

// class HomeView extends GetView<HomeController>{
//      final PaginateRefreshedChangeListener refreshChangeListener = PaginateRefreshedChangeListener();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         floatingActionButtonLocation:
//             FloatingActionButtonLocation.miniStartFloat,
//         floatingActionButton: SizedBox(
//           height: 50,
//           width: 50,
//           child: InkWell(
//             onTap: () {
//               // Get.toNamed(Routes.CREATE_PRODUCT);
//             },
//             child: Card(
//               color: Colors.white,
//               child: Center(
//                   child: Icon(
//                 Icons.add,
//                 color: Colors.orange,
//               )),
//             ),
//           ),
//         ),
//       appBar: AppBar(
//         title: Text('All Product List'),
//         centerTitle: true,
//       ),
//       body:     RefreshIndicator(
//         child:  PaginateFirestore(
//         // Use SliverAppBar in header to make it sticky
//         // header: SliverToBoxAdapter(child: Text('HEADER')),
//         // footer: SliverToBoxAdapter(child: Text('FOOTER')),
//         // item builder type is compulsory.
//         gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 5.0,
//                 childAspectRatio: .6,
//                 mainAxisSpacing: 5.0,
//               ),

//         itemBuilderType:
//             PaginateBuilderType.gridView, //Change types accordingly
//         itemBuilder: (index, context, documentSnapshot) {
//           final data = documentSnapshot.data() as Map;
//           return InkWell(
//                                 onTap: ()async{
//                                   ProductdetailController.to.productName.value = data['product_name'];
//                                   ProductdetailController.to.productId.value = documentSnapshot.id;
//                                   ProductdetailController.to.categoryId.value = data['category_id'];
//                                 //  await Get.toNamed(Routes.PRODUCTDETAIL);
//                                 },
//                                                               child: Card(
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(15),
//                                   ),
//                                   child: Column(
//                                     children: [
//                                       Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: Text(
//                                           data["product_name"],
//                                           overflow: TextOverflow.ellipsis,
//                                           style: TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 13,
//                                             color: Colors.black87,
//                                           ),
//                                         ),
//                                       ),
//                                       Text(
//                                         "Short detail",
//                                         style: TextStyle(
//                                           fontSize: 12,
//                                           color: Colors.grey,
//                                         ),
//                                       ),
//                                       SizedBox(
//                                         height: 5,
//                                       ),
//                                       SizedBox(
//                                         height: 100,
//                                         width: 120,
//                                         child: CachedNetworkImage(
//                                           imageUrl: data['theme_image'],
//                                           imageBuilder: (context, imageProvider) =>
//                                               Container(
//                                             width: 100.0,
//                                             height: 100.0,
//                                             padding: EdgeInsets.all(10),
//                                             decoration: BoxDecoration(
//                                               borderRadius:
//                                                   BorderRadius.circular(10),
//                                               // border: Border.all(
//                                               //     color: Colors.grey),
//                                               shape: BoxShape.rectangle,
//                                               image: DecorationImage(
//                                                   image: imageProvider,
//                                                   fit: BoxFit.contain),
//                                             ),
//                                           ),
//                                           placeholder: (context, url) => Center(
//                                               child: CircularProgressIndicator()),
//                                           errorWidget: (context, url, error) =>
//                                               Icon(Icons.error),
//                                         ),
//                                       ),
//                                       SizedBox(height: 10),
//                                       Padding(
//                                         padding: const EdgeInsets.only(left: 15),
//                                         child: Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.start,
//                                           children: [
//                                             // Expanded(flex: 1, child: Text("hello")),
//                                             Expanded(
//                                               flex: 4,
//                                               child: Text(
//                                                 "per ${data["quantity"].toString().toUpperCase()} ${data["unit"]}",
//                                                 style:
//                                                     TextStyle(color: Colors.grey),
//                                               ),
//                                             )
//                                           ],
//                                         ),
//                                       ),
//                                       SizedBox(height: 10),
//                                       Padding(
//                                         padding: const EdgeInsets.only(left: 15),
//                                         child: Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.start,
//                                           children: [
//                                             Expanded(
//                                               flex: 1,
//                                               child: Row(
//                                                 children: [
//                                                   Text(
//                                                     "\u20B9",
//                                                     style: TextStyle(
//                                                       fontWeight: FontWeight.bold,
//                                                     ),
//                                                   ),
//                                                   SizedBox(
//                                                     width: 10,
//                                                   ),
//                                                   Text(
//                                                     data["mrp"],
//                                                     style: TextStyle(
//                                                         fontSize: 16,
//                                                         color: Colors.blueGrey),
//                                                   ),
//                                                 ],
//                                               ),
//                                             )
//                                           ],
//                                         ),
//                                       ),
//                                       SizedBox(height: 15),
//                                       Padding(
//                                         padding: const EdgeInsets.only(
//                                             left: 15, right: 15),
//                                         child: Row(
//                                           children: [
//                                             Expanded(
//                                               flex: 1,
//                                               child: Row(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment.center,
//                                                 children: [
//                                                   Container(
//                                                     height: 25,
//                                                     width: 40,
//                                                     color: Color(0xFFF5BA27),
//                                                     child: Icon(
//                                                       Icons.remove,
//                                                       color: Colors.white,
//                                                       size: 15,
//                                                     ),
//                                                   ),
//                                                   Container(
//                                                     height: 25,
//                                                     width: 30,
//                                                     color: Colors.grey[200],
//                                                     child: Center(
//                                                       child: Text("0"),
//                                                     ),
//                                                   ),
//                                                   Container(
//                                                     height: 25,
//                                                     width: 40,
//                                                     color: Color(0xFFF5BA27),
//                                                     child: Icon(
//                                                       Icons.add,
//                                                       color: Colors.white,
//                                                       size: 15,
//                                                     ),
//                                                   )
//                                                 ],
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                       SizedBox(height: 10),
//                                     ],
//                                   ),
//                                 ),
//                               );

//           //  Card(
//           //                   child: Column(
//           //                     children: [
//           //                       Row(
//           //                         crossAxisAlignment: CrossAxisAlignment.start,
//           //                         children: [
//           //                           Expanded(
//           //                             flex: 1,
//           //                             child: Padding(
//           //                               padding: const EdgeInsets.all(8.0),
//           //                               child: CachedNetworkImage(
//           //                                 height: 100,
//           //                                 width: 100,
//           //                                 memCacheHeight: 100,
//           //                                 memCacheWidth: 100,
//           //                                 imageUrl: data['theme_image'],
//           //                                 imageBuilder:
//           //                                     (context, imageProvider) =>
//           //                                         Container(
//           //                                   width: 100.0,
//           //                                   height: 100.0,
//           //                                   padding: EdgeInsets.all(10),
//           //                                   decoration: BoxDecoration(
//           //                                     borderRadius:
//           //                                         BorderRadius.circular(10),
//           //                                     // border: Border.all(
//           //                                     //     color: Colors.grey),
//           //                                     shape: BoxShape.rectangle,
//           //                                     image: DecorationImage(
//           //                                         image: imageProvider,
//           //                                         fit: BoxFit.contain),
//           //                                   ),
//           //                                 ),
//           //                                 placeholder: (context, url) => Center(
//           //                                     child:
//           //                                         CircularProgressIndicator()),
//           //                                 errorWidget: (context, url, error) =>
//           //                                     Icon(Icons.error),
//           //                               ),
//           //                             ),
//           //                           ),
//           //                           Expanded(
//           //                             flex: 2,
//           //                             child: Padding(
//           //                               padding: const EdgeInsets.all(10.0),
//           //                               child: Column(
//           //                                 crossAxisAlignment:
//           //                                     CrossAxisAlignment.start,
//           //                                 children: [
//           //                                   Text(
//           //                                     data['product_name'],
//           //                                     style:
//           //                                         TextStyle(color: Colors.grey),
//           //                                   ),
//           //                                   SizedBox(height: 5),
//           //                                   Text(
//           //                                     "${data['quantity']} ${data['unit']} ",
//           //                                     style:
//           //                                         TextStyle(color: Colors.grey),
//           //                                   ),
//           //                                   SizedBox(height: 5),
//           //                                   Text(
//           //                                     "\u{20B9} ${data['mrp']}  ",
//           //                                     style: TextStyle(
//           //                                       color: Colors.black,
//           //                                     ),
//           //                                   ),
//           //                                 ],
//           //                               ),
//           //                             ),
//           //                           ),
//           //                         ],
//           //                       ),
//           //                       Padding(
//           //                         padding: const EdgeInsets.all(8.0),
//           //                         child: Divider(thickness: 2),
//           //                       ),
//           //                       Padding(
//           //                         padding: const EdgeInsets.only(
//           //                             right: 10, bottom: 10),
//           //                         child: Row(
//           //                           mainAxisAlignment: MainAxisAlignment.end,
//           //                           children: [
//           //                             InkWell(
//           //                               onTap: () {
//           //                                 // ProductEditController.to.pId.value =
//           //                                 //     documentSnapshot.id;
//           //                                 //     Get.toNamed(Routes.PRODUCT_EDIT);

//           //                               },
//           //                               child: Text("EDIT",style: TextStyle(color: Colors.green),)
//           //                             ),
//           //                             SizedBox(width: 15),
//           //                             InkWell(
//           //                               onTap: () {
//           //                                 showDialog(
//           //                                   context: context,
//           //                                   builder: (context) {
//           //                                     return AlertDialog(
//           //                                       title: Text(
//           //                                         'Are You Sure??',
//           //                                         style: TextStyle(
//           //                                             fontSize: 16,
//           //                                             color: Colors.green),
//           //                                       ),
//           //                                       content: Text(
//           //                                         'Product Will Be Deleted Permanently  ..',
//           //                                         style: TextStyle(
//           //                                             color: Colors.grey),
//           //                                       ),
//           //                                      actions: <Widget>[
//           //                                         FlatButton(
//           //                                           onPressed: () {
//           //                                             FirebaseFirestore.instance
//           //                                                 .collection(
//           //                                                     "product_collection")
//           //                                                 .doc(documentSnapshot.id)
//           //                                                 .delete();
//           //                                             Get.back();
//           //                                             // Fluttertoast.showToast(
//           //                                             //     msg:
//           //                                             //         'Product Deleted Successfully');
//           //                                           },
//           //                                           child: Text("CONFIRM",
//           //                                               style: TextStyle(
//           //                                                 color: Colors.orange,
//           //                                               )),
//           //                                         ),
//           //                                         FlatButton(
//           //                                             onPressed: () =>
//           //                                                 Get.back(),
//           //                                             child: Text(
//           //                                               'CANCEL',
//           //                                               style: TextStyle(
//           //                                                   color: Colors.grey),
//           //                                             )),
//           //                                       ],
//           //                                     );
//           //                                   },
//           //                                 );
//           //                                 // FirebaseFirestore.instance
//           //                                 //     .collection("product_collection")
//           //                                 //     .doc(data.id)
//           //                                 //     .delete();
//           //                               },
//           //                               child: Text("DELETE",style: TextStyle(color: Colors.orange),)
//           //                             ),
//           //                             SizedBox(width: 10),
//           //                             // Icon(
//           //                             //   Icons.arrow_forward,
//           //                             //   color: Colors.grey,
//           //                             // ),
//           //                           ],
//           //                         ),
//           //                       ),
//           //                     ],
//           //                   ),
//           //                 );
//         },
//         // orderBy is compulsory to enable pagination
//         query: FirebaseFirestore.instance.collection('product_collection'),
//         listeners: [
//             refreshChangeListener,
//           ],
//         // to fetch real-time data
//         isLive: true,
//       ),
//         onRefresh: () async {
//           refreshChangeListener.refreshed = true;
//         },

//       )
//     );
//   }
// }
