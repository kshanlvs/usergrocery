import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:paginate_firestore/bloc/pagination_listeners.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:get/get.dart';
import 'package:usergrocery/app/modules/category_wise/controllers/category_wise_controller.dart';
import 'package:usergrocery/app/modules/home/controllers/home_controller.dart';
import 'package:usergrocery/app/modules/productdetail/controllers/productdetail_controller.dart';
import 'package:usergrocery/app/routes/app_pages.dart';
import 'package:usergrocery/app/widgets/products_card.dart';
import 'package:usergrocery/app/widgets/search_btn.dart';
import 'package:usergrocery/theme/color_theme.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final ProductdetailController productdetailController =
      Get.put(ProductdetailController());
  final PaginateRefreshedChangeListener refreshChangeListener =
      PaginateRefreshedChangeListener();


      

  final List<String> images = [
    "assets/images/cleaning.png",
    "assets/images/snack.png",
    "assets/images/water.png",
    "assets/images/snack.png",
    "assets/images/healthy-food.png",
    "assets/images/grocery.png",
    "assets/images/skincare.png",
    "assets/images/pet-food.png",
    "assets/images/soft-drink.png",
    "assets/images/soft-drink.png",
    "assets/images/soft-drink.png",
    "assets/images/soft-drink.png",
    "assets/images/soft-drink.png",
    "assets/images/soft-drink.png",
  ];

  // final List<Color> colors = [
  //       Colors.green,
  //   Colors.orange,
  //   Colors.red,
  //        Colors.green,
  //   Colors.orange,
  //   Colors.red,
  //        Colors.green,
  //   Colors.orange,
  //   Colors.red,
  //        Colors.green,
  //   Colors.orange,
  //   Colors.red,

  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
        appBar: AppBar(
          title: Text(
            "bag2door",
            style: TextStyle(color: Colors.blueGrey),
          ),
          backgroundColor: Colors.white,
          leading: InkWell(
              onTap: () {
                Get.toNamed(Routes.CART);
              },
              child: Icon(Icons.shopping_cart, color: Colors.amber, size: 30)),
          elevation: 0,
          actions: [Search()],
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
                    height: 140,
                    child: Container(
                        // margin: EdgeInsets.symmetric(vertical: 20.0),
                        height: 140.0,
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
                                itemBuilder: (BuildContext context, int index) {
                                  DocumentSnapshot datas = data[index];
                                  return InkWell(
                                    onTap: () {
                                      CategoryWiseController
                                          .to.categoryId.value = datas.id;
                                      Get.toNamed(Routes.CATEGORY_WISE);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Container(
                                            width: 80,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              gradient: LinearGradient(
                                                colors: [
                                                  Colors.white,
                                                  Colors.amber,
                                                ],
                                                begin: const FractionalOffset(
                                                    0.0, 0.0),
                                                end: const FractionalOffset(
                                                    0.0, 1.2),
                                                stops: [0.0, 1.0],
                                                tileMode: TileMode.clamp,
                                              ),
                                            ),

                                            // color: Colors.black.withOpacity(.7),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      12.0),
                                                  child: Image.asset(
                                                    images[index],
                                                    height: 50,
                                                    width: 50,
                                                  ),
                                                ),
                                                // Center(
                                                //   child: Padding(
                                                //     padding: const EdgeInsets.only(top:15),
                                                //     child: Text(
                                                //         datas['category_title']
                                                //             .toString()
                                                //             .toUpperCase(),
                                                //         style: TextStyle(
                                                //             fontWeight: FontWeight.bold,
                                                //             color: Colors.blueGrey,fontSize: 10)),
                                                //   ),
                                                // ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          SizedBox(
                                            height: 40,
                                            width: 50,
                                            child: Text(
                                                datas['category_title']
                                                    .toString()
                                                    .toUpperCase(),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.blueGrey,
                                                  fontSize: 9,
                                                )),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            }

                            return Text("loading");
                          },
                        )),
                  ),
                ),
                SizedBox(height: 20),
                Text("All Products",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 24,
                        fontWeight: FontWeight.bold)),
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
                await Get.toNamed(Routes.PRODUCTDETAIL);
              },
              child: ProductCards(
                data: data,
                id: documentSnapshot.id,
                index: index,
              ),
            );
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
