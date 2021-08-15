import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:usergrocery/app/modules/cart/controllers/cart_controller.dart';

import 'package:usergrocery/app/modules/home/controllers/home_controller.dart';
import 'package:usergrocery/app/widgets/cartfunc.dart';

import '../../Constants.dart';


class ProductDetailCardCounter extends GetView {
   ProductDetailCardCounter({
    Key? key,
    required this.data,
    this.id,
    // this.index,
  }) : super(key: key);

  final Map data;
  final String? id;
  // final int? index;

  final HomeController controller1 = Get.find();
  final GetStorage storage = GetStorage();
  final CartController cartController = Get.put(CartController());


  @override
  Widget build(BuildContext context) {
   
    return Expanded(
      flex: 2,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 30,
                  width: 30,
                  // color: Colors.blueGrey[900],
                  child: Card(
                    color: Colors.amber.withOpacity(.1),
                    child: InkWell(
                      onTap: (){
                        if(controller1.quantity.value > 0){
                                controller1.quantity.value = controller1.quantity.value -1;
                                if(controller1.quantity.value >=0){
                                cartDecrement(pQuantity: controller1.quantity.value,pId: id);
                            }
                             }

                      },
                      child: Icon(
                        Icons.remove,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ),
                Container(
                        height: 25,
                        width: 30,
                        color: Colors.grey[200],
                        child: Center(
                          child: StreamBuilder<
                              QuerySnapshot<Map<String, dynamic>>>(
                            stream: FirebaseFirestore.instance
                                .collection("carts")
                                .where("product_id", isEqualTo:id)
                                .where("user_id",
                                    isEqualTo: storage.read(kfUid))
                                .snapshots(),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (!snapshot.hasData) {
                                return CupertinoActivityIndicator();
                              }

                             if (!snapshot.hasData) {
                                return CupertinoActivityIndicator();
                              }

                              if (snapshot.hasData &&
                                  snapshot.requireData.docs.length != 0) {
                                DocumentSnapshot? data = snapshot.data.docs[0];
                                // controller1.catId.value =
                                //     snapshot.data.docs[0].id;

                                controller1.quantity.value =
                                    data!['product_quantity'] ?? 0;
                                return Text(
                                    data['product_quantity'].toString());
                              } else if (snapshot.requireData.docs.length ==
                                  0) {
                                return Text("0");
                              } else {
                                return SizedBox.shrink();
                              }
                            
                            },
                          ),

                          // ,
                        ),
                      ),
                Container(
                  height: 30,
                  width: 30,
                  // color: Colors.blueGrey[900],
                  child: Card(
                    color: Colors.amber[800],
                    child: InkWell(
                 
                       onTap: () async {
                            //if the user doesn't have any itmes in cart
                              GetStorage getStorage = GetStorage();

                             controller1.quantity.value +=1;

                            cartAdd(
                                pId: id,
                                pQuantity: controller1.quantity.value,
                                userId: getStorage.read(kfUid));

                          },
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
