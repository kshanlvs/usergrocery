import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:paginate_firestore/bloc/pagination_listeners.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:usergrocery/app/modules/productdetail/controllers/productdetail_controller.dart';
import 'package:usergrocery/app/routes/app_pages.dart';
import 'package:usergrocery/app/widgets/cartfunc.dart';
import 'package:usergrocery/app/widgets/products_card.dart';

import '../controllers/category_wise_controller.dart';

class CategoryWiseView extends GetView<CategoryWiseController> {
  final PaginateRefreshedChangeListener refreshChangeListener =
      PaginateRefreshedChangeListener();
  Future<bool> onWillPop() {
    controller.searchBtnPressed.value = false;
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      
      child: Scaffold(
        bottomNavigationBar: btnNav(),
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
              Obx(() {
                if (controller.searchBtnPressed.value) {
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
                } else {
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
              })
            ],
          ),
          body: PaginateFirestore(
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
                  ProductdetailController.to.productId?.value =
                      documentSnapshot.id;
                  ProductdetailController.to.categoryId.value =
                      data['category_id'];
                  await Get.toNamed(Routes.PRODUCTDETAIL);
                },
                child: ProductCards(data: data,id:documentSnapshot.id)
              );
            },

            query: FirebaseFirestore.instance
                .collection('product_collection')
                .where("category_id", isEqualTo: controller.categoryId.value),
            listeners: [
              refreshChangeListener,
            ],
            // to fetch real-time data
            isLive: true,
          )),
    );
  }
}
