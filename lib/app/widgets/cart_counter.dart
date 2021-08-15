import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:usergrocery/Constants.dart';
import 'package:usergrocery/app/modules/home/controllers/home_controller.dart';
import 'package:usergrocery/app/widgets/cartfunc.dart';

class CartCounter extends StatefulWidget {
  const CartCounter({
    Key? key,
    required this.id,
    required this.catId,
    required this.data,
  }) : super(key: key);

  final Map data;
  final String catId;
  final String id;

  @override
  _CartCounterState createState() => _CartCounterState();
}

class _CartCounterState extends State<CartCounter> {
  GetStorage storage = GetStorage();
  final HomeController controller1 = Get.find();

  @override
  Widget build(BuildContext context) {
    controller1.quantity.value = widget.data['product_quantity'];
    controller1.catId.value = widget.catId;
    return Expanded(
        flex: 1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: 30,
                          width: 30,
                          // color: Colors.blueGrey[900],
                          child: Card(
                            color: Colors.amber.withOpacity(.1),
                            child: InkWell(
                              onTap: () async {
                                if (controller1.quantity.value > 0) {
                                  controller1.quantity.value =
                                      controller1.quantity.value - 1;
                                  if (controller1.quantity.value >= 0) {
                                    cartDecrement(
                                        pQuantity: controller1.quantity.value,
                                        pId: widget.id);
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
                                  .where("product_id", isEqualTo: widget.id)
                                  .where("user_id",
                                      isEqualTo: storage.read(kfUid))
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (!snapshot.hasData) {
                                  return CupertinoActivityIndicator();
                                }

                                if (snapshot.hasData &&
                                    snapshot.requireData.docs.length != 0) {
                                  DocumentSnapshot? data =
                                      snapshot.data.docs[0];
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
                              onTap: () {
                                GetStorage getStorage = GetStorage();

                                controller1.quantity.value += 1;

                                cartAdd(
                                    pId: widget.id,
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
            ),
          ],
        ));
  }
}
