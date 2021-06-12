import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:usergrocery/app/modules/productdetail/controllers/productdetail_controller.dart';
import 'package:usergrocery/app/routes/app_pages.dart';
import 'package:usergrocery/theme/color_theme.dart';

import '../controllers/category_wise_controller.dart';

class CategoryWiseView extends GetView<CategoryWiseController> {
  Future<bool> onWillPop(){
    controller.searchBtnPressed.value = false;
    return Future.value(true);
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: onWillPop,
          child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Obx(() {
            if (controller.searchBtnPressed.value) {
              return SizedBox(
                height: 35,
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 15, top: 5),
                    border: new OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.amber, width: 2),
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(20.0),
                      ),
                    ),
                    hintText: "Search..................",
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              );
            } else {
              return FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance
                    .collection("category_collection")
                    .doc(controller.categoryId.value)
                    .get(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text("Something went wrong");
                  }

                  if (!snapshot.hasData) {
                    return Text("Document does not exist");
                  }

                  if (snapshot.connectionState == ConnectionState.done) {
                    DocumentSnapshot<Object?>? data = snapshot.data;

                    return Text(
                      data!['category_title'],
                      style: TextStyle(color: Colors.blueGrey),
                    );
                  }

                  return Text("loading");
                },
              );
            }
          }),
          leading: InkWell(
              onTap: () {
                controller.searchBtnPressed.value = false;
                Get.back();
              },
              child: Icon(Icons.arrow_back, color: Colors.amber, size: 30)),
          elevation: 0,
          actions: [
            Obx(
              () {
                if(controller.searchBtnPressed.value){
                  return Padding(
                padding: const EdgeInsets.only(right: 15),
                child: InkWell(
                  onTap: () {
                    controller.searchBtnPressed.value =
                        !controller.searchBtnPressed.value;
                  },
                  child: Icon(
                    Icons.cancel,
                    color: Colors.amber,
                    size: 30,
                  ),
                ),
              );
                }
                else{
                  return Padding(
                padding: const EdgeInsets.only(right: 15),
                child: InkWell(
                  onTap: () {
                    controller.searchBtnPressed.value =
                        !controller.searchBtnPressed.value;
                  },
                  child: Icon(
                    Icons.search,
                    color: Colors.amber,
                    size: 30,
                  ),
                ),
              );
                }
              } 
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder<List<DocumentChange>>(
                future: controller.getProductCategororyWise(),
                builder: (_, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return 
                      

                       Padding(
                         padding: const EdgeInsets.only(top:50),
                         child: Center(
                          child:Text("ApnaBazar....",style: TextStyle(fontSize: 25,color: textColor),),
                      ),
                       );
                    
                  } else {
                    return Column(
                      children: [
                        GridView.count(
                          crossAxisCount: 2,
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          childAspectRatio: .6,
                          semanticChildCount: 2,
                          children: List.generate(
                            snapshot.data!.length,
                            (index) {
                              DocumentChange<Object?>? data1 =
                                  snapshot.data![index];
                              DocumentSnapshot data = data1.doc;
                              return InkWell(
                                onTap: ()async{
                                  ProductdetailController.to.productName.value = data['product_name'];
                                  ProductdetailController.to.productId.value = data.id;
                                  ProductdetailController.to.categoryId.value = data['category_id'];
                                 await Get.toNamed(Routes.PRODUCTDETAIL);
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
                                          imageBuilder: (context, imageProvider) =>
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
                        ),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// return ListView.builder(
//                           itemCount: snapshot.data!.length,
//                           itemBuilder: (_,index){
//                           DocumentChange<Object?>?   data1 =  snapshot.data![index];
//                           DocumentSnapshot data = data1.doc;
//                             return
//                           },);
