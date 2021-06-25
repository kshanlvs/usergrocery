import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:usergrocery/Constants.dart';
import 'package:usergrocery/app/modules/home/controllers/home_controller.dart';
import 'package:usergrocery/app/routes/app_pages.dart';
import 'package:usergrocery/app/widgets/cartfunc.dart';

class ProductCards extends StatefulWidget {
  const ProductCards({
    Key? key,
    required this.data,
    this.id,
    this.index,
  }) : super(key: key);

  final Map data;
  final String? id;
  final int? index;

  @override
  _ProductCardsState createState() => _ProductCardsState();
}

class _ProductCardsState extends State<ProductCards> {
  GetStorage storage = GetStorage();
  final HomeController controller1 = Get.find();

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.data["product_name"],
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
              imageUrl: widget.data['theme_image'],
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
                    "per ${widget.data["quantity"].toString().toUpperCase()} ${widget.data["unit"]}",
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
                        widget.data["mrp"],
                        style: TextStyle(fontSize: 16, color: Colors.blueGrey),
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
                          child: StreamBuilder<
                              QuerySnapshot<Map<String, dynamic>>>(
                            stream: FirebaseFirestore.instance
                                .collection("carts")
                                .where("product_id", isEqualTo: widget.id)
                                .where("user_id",
                                    isEqualTo: storage.read(kfUid))
                                .snapshots(),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (!snapshot.hasData) {
                                return Text("0");
                              }
                              if (snapshot.hasError) {
                                return Text("0");
                              } else {
                                if (snapshot.data.docs.length > 0) {
                                  DocumentSnapshot? data =
                                      snapshot.data.docs[0];
                                  controller1.catId.value =
                                      snapshot.data.docs[0].id;

                                  controller1.quantity.value =
                                      data!['product_quantity'] ?? 0;
                                }

                                return Obx(() {
                                  if (controller1.quantity.value == 0) {
                                    return Text("0");
                                  } else {
                                    return Text(
                                        controller1.quantity.value.toString());
                                  }
                                });
                              }
                            },
                          ),

                          // ,
                        ),
                      ),
                      Container(
                        height: 25,
                        width: 40,
                        color: Color(0xFFF5BA27),
                        child: InkWell(
                          onTap: () {
                            GetStorage getStorage = GetStorage();

                            if (controller1.quantity.value == 0) {
                            

                              controller1.quantity.value += 1;

                              cartAdd(
                                  pId: widget.id,
                                  pPrice: widget.data['mrp'],
                                  pQuantity: controller1.quantity.value,
                                  userId: getStorage.read(kfUid));
                            } else {
                              controller1.quantity.value += 1;
                                
                              cartUpdate(
                                  cId: controller1.catId.value,
                                  pQuantity: controller1.quantity.value);
                            }
                          },
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 15,
                          ),
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
    );
  }
}
