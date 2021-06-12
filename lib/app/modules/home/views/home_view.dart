import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:usergrocery/app/modules/category_wise/controllers/category_wise_controller.dart';
import 'package:usergrocery/app/modules/productdetail/controllers/productdetail_controller.dart';
import 'package:usergrocery/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
final  ProductdetailController productdetailController = Get.put(ProductdetailController());
  @override

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("ApnaBazar",style: TextStyle(color: Colors.blueGrey),),
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
        body: 
        
        
        
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "What would you like ",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.blueGrey,
                      letterSpacing: 1),
                ),
                Text(
                  "to order ???",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.blueGrey,
                      letterSpacing: 1),
                ),
                SizedBox(height: 20),
                StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("category_collection")
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(child: CircularProgressIndicator());
                      } else {
                        // List<DocumentSnapshot> catData = snapshot.data!.docs;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            GridView.count(
                              crossAxisCount: 2,
                              shrinkWrap: true,
                              childAspectRatio: 2.1,
                              physics: BouncingScrollPhysics(),
                              semanticChildCount: 2,
                              children: List.generate(4, (index) {
                                DocumentSnapshot? category =
                                    snapshot.data!.docs[index];
                                return InkWell(
                                  onTap: (){
                                        CategoryWiseController.to.categoryId.value = category.id;

                                            Get.toNamed(Routes.CATEGORY_WISE);
                                  },
                                                                  child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Stack(
                                        children: [
                                          CachedNetworkImage(
                                            imageUrl: category['theme_image'],
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                    Container(
                                              height: 100.0,
                                              padding: EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                 color:Colors.black,
                                                borderRadius:
                                                      BorderRadius.circular(10),
                                                // border: Border.all(
                                                //     color: Colors.grey),
                                                shape: BoxShape.rectangle,
                                                image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.fitWidth,
                                                  colorFilter:
                                                        new ColorFilter.mode(
                                                            Colors.black
                                                                .withOpacity(0.8),
                                                            BlendMode.dstATop),
                                                ),
                                              ),
                                            ),
                                            placeholder: (context, url) => Center(
                                                child:
                                                    CircularProgressIndicator()),
                                            errorWidget: (context, url, error) =>
                                                Icon(Icons.error),
                                          ),
                                          Center(
                                              child: Text(
                                            
                                            category['category_title'],
                                            style: TextStyle(
                                            fontSize: 14,
                                            
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ))
                                        ],
                                      )),
                                );
                              }),
                            ),
                            SizedBox(height:15),
                            InkWell(
                              onTap: (){
                                Get.toNamed(Routes.CATEGORYLIST);
                              },
                              child: Text("View All",style: TextStyle(color: Colors.grey),).paddingOnly(right:15))
                          ],
                        );
                      }
                    }),
                SizedBox(height: 20),
                Text(
                  "Popular Products",
                  style: TextStyle(color: Colors.grey, fontSize: 18),
                ),
                SizedBox(height: 20),
                StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("product_collection")
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(child: CircularProgressIndicator());
                      } else {
                        return GridView.count(
                          crossAxisCount: 2,
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          childAspectRatio: .6,
                          semanticChildCount: 2,
                          children: List.generate(
                            20,
                            (index) {
                              DocumentSnapshot? data =
                                  snapshot.data!.docs[index];
                              return InkWell(
                                onTap: ()async{
                                  ProductdetailController.to.productName.value = data['product_name'];
                                  ProductdetailController.to.productId.value = data.id;
                                  ProductdetailController.to.categoryId.value = data['category_id'];
                                  Get.toNamed(Routes.PRODUCTDETAIL);
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
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  Container(
                                            width: 100.0,
                                            height: 100.0,
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              // border: Border.all(
                                              //     color: Colors.grey),
                                              shape: BoxShape.rectangle,
                                              image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.contain),
                                            ),
                                          ),
                                          placeholder: (context, url) => Center(
                                              child: CircularProgressIndicator()),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 15),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            // Expanded(flex: 1, child: Text("hello")),
                                            Expanded(
                                              flex: 4,
                                              child: Text(
                                                "per ${data["quantity"].toString().toUpperCase()} ${data["unit"]}",
                                                style:
                                                    TextStyle(color: Colors.grey),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 15),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
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
                                                        fontSize: 16,
                                                        color: Colors.blueGrey),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 15),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15, right: 15),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
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
                            },
                          ),
                        );
                      }
                    }),
              ],
            ),
          ),
        ));
  }
}
