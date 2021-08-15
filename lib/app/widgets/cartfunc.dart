import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:usergrocery/Constants.dart';
import 'package:usergrocery/app/modules/cart/controllers/cart_controller.dart';
import 'package:usergrocery/app/routes/app_pages.dart';
import 'package:usergrocery/app/widgets/progress.dart';
import 'package:usergrocery/theme/color_theme.dart';

CollectionReference cartCollection =
    FirebaseFirestore.instance.collection("carts");
CartController cartController = Get.put(CartController());

cartAdd({@required pId, @required pQuantity, @required userId}) async {
  ProgressBar().start();
  Map<String, dynamic> data = {
    "product_id": pId,
    "product_quantity": pQuantity,
    "user_id": userId
  };

  await cartCollection.get().then((value) async {
    if (value.docs.length != 0) {
      await cartCollection
          .where("product_id", isEqualTo: pId)
          .get()
          .then((value) {
        if (value.docs.length != 0) {
          cartCollection
              .doc(value.docs[0].id)
              .update({"product_quantity": pQuantity});
          ProgressBar().stop();
        } else {
          cartCollection.add(data);
          ProgressBar().stop();
        }
      });
    } else if (value.docs.length == 0) {
      await cartCollection.add(data);
      ProgressBar().stop();
    } else {
      null;
    }
  });

  ProgressBar().stop();
}

cartDecrement({required pId, required pQuantity}) async {
  ProgressBar().start();
  await cartCollection.where("product_id", isEqualTo: pId).get().then((value) {
    if (value.docs.length != 0 && pQuantity != 0) {
      cartCollection
          .doc(value.docs[0].id)
          .update({"product_quantity": pQuantity});
      ProgressBar().stop();
    } else if (pQuantity == 0) {
      cartCollection.doc(value.docs[0].id).delete();
      ProgressBar().stop();
    } else {
      null;
    }
  });
}

Future cartUpdate({@required cId, @required pQuantity}) async {
  ProgressBar().start();
  await cartCollection.doc(cId).update({"product_quantity": pQuantity});
  ProgressBar().stop();
}

Future cartDelete({@required cId}) async {
  ProgressBar().start();

  await FirebaseFirestore.instance.collection("carts").doc(cId).delete();
  ProgressBar().stop();
}

Widget btnNav() {
    List listOfcarQuantity = [];
          List listOfProductMrp = [];
              RxInt total = 0.obs;
  GetStorage getStorage = GetStorage();
  return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("carts")
          .where("user_id", isEqualTo: getStorage.read(kfUid))
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return SizedBox.shrink();
        } else if (snapshot.hasData) {
          QuerySnapshot data = snapshot.data;
      
        
          //  List listOfCartTotal = [];
          data.docs.forEach((element) {
            listOfcarQuantity.add(element['product_quantity']);
            FirebaseFirestore.instance.collection("product_collection").doc(element['product_id']).get().then((value) async {
             
                listOfProductMrp.add((value['mrp']));
                 total.value =   int.parse(listOfProductMrp.reduce((value, element) => value+element))  ;
            

                
            }); 
          });

    

          return listOfcarQuantity.isEmpty
              ? SizedBox.shrink()
              : Container(
                  height: 40,
                  width: Get.width,
                  color: Colors.deepOrange,
                  child: Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Center(
                              child: Text(
                            " ${listOfcarQuantity.reduce((value, element) => value + element)}   Item :",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ))),
                      Expanded(
                          flex: 1,
                          child: Row(
                            children: [
                              Text('\u{20B9}',
                                  style: TextStyle(
                                    color: Colors.white,
                                  )),
                             
                                   Text(
                                  total.value.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                              ),
                            ],
                          )),

                      Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () {
                            Get.toNamed(Routes.CART);
                          },
                          child: Row(
                            children: [
                              Text("VIEW CART",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(width: 5),
                              Icon(
                                Icons.shopping_bag_outlined,
                                size: 30,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),

                      //  Text(cartController.totalCartItemCount.value.toString()),
                    ],
                  ));
        } else {
          return SizedBox.shrink();
        }
      });
}

Widget buyNowBtn() {
  return Obx(() {
    if (cartController.totalCartItemCount.value == 0) {
      return SizedBox.shrink();
    } else {
      return Container(
        height: 70,
        child: Column(
          children: [
            Container(
              height: 20,
              color: textColor,
              width: Get.width,
              child: Center(
                child: Text(
                  "30 minutes garuntee delivery",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Container(
                height: 50,
                width: Get.width,
                // color: Colors.deepOrange,
                child: Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: SizedBox(
                            height: 50,
                            child: Container(
                              color: Colors.white,
                              child: Row(
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Center(
                                          child: Text(
                                        " ${cartController.totalCartItemCount.value}   Item :",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue),
                                      ))),
                                  Container(
                                    child: Expanded(
                                        flex: 1,
                                        child: Row(
                                          children: [
                                            Text('\u{20B9}',
                                                style: TextStyle(
                                                    color: Colors.blue)),
                                            Text(
                                              cartController.cartTotal.value
                                                  .toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.blue),
                                            ),
                                          ],
                                        )),
                                  ),
                                ],
                              ),
                            ))),

                    Expanded(
                      flex: 1,
                      child: SizedBox(
                        height: 50,
                        child: Container(
                          color: Colors.deepOrange,
                          child: InkWell(
                            onTap: () {
                              Get.toNamed(Routes.CHECKOUT);
                            },
                            child: Row(
                              // crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("PROCEED",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(width: 5),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )

                    // Expanded(
                    //     flex: 1,
                    //     child: Center(
                    //         child: Text(
                    //       " ${cartController.totalCartItemCount.value}   Item :",
                    //       style: TextStyle(
                    //           fontWeight: FontWeight.bold, color: Colors.white),
                    //     ))),
                    // Container(
                    //   child: Expanded(
                    //       flex: 1,
                    //       child: Row(
                    //         children: [
                    //           Text('\u{20B9}',
                    //               style: TextStyle(
                    //                 color: Colors.white,
                    //               )),
                    //           Text(
                    //             cartController.cartTotal.value.toString(),
                    //             style: TextStyle(
                    //                 fontWeight: FontWeight.bold,
                    //                 color: Colors.white),
                    //           ),
                    //         ],
                    //       )),
                    // ),

                    // Expanded(
                    //   flex: 1,
                    //   child: InkWell(
                    //     onTap: () {
                    //       Get.toNamed(Routes.CART);
                    //     },
                    //     child: Row(
                    //       children: [
                    //         Text("BUY NOW",
                    //             style: TextStyle(
                    //                 color: Colors.white,
                    //                 fontWeight: FontWeight.bold)),
                    //         SizedBox(width: 5),
                    //         Icon(
                    //           Icons.shop,
                    //           size: 30,
                    //           color: Colors.white,
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),

                    //  Text(cartController.totalCartItemCount.value.toString()),
                  ],
                )),
          ],
        ),
      );
    }
  });
}
