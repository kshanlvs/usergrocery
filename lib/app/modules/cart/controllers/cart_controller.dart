import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:usergrocery/app/widgets/progress.dart';

import '../../../../Constants.dart';

class CartController extends GetxController {
  static CartController get to => Get.find();
  CollectionReference cartCollection =
      FirebaseFirestore.instance.collection("carts");

  RxInt totalCartItemCount = 0.obs;
  GetStorage getStorage = GetStorage();

  RxInt cartTotal = 0.obs;
  RxList<String> pmrp = <String>[].obs;
  RxList<int> p = <int>[].obs;
  RxInt sumOfCartItemsTotal = 0.obs;
// add to cart function

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

  cartDecrement({required pId, required pQuantity}) async {
    ProgressBar().start();
    await cartCollection
        .where("product_id", isEqualTo: pId)
        .get()
        .then((value) {
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

  getDataForCartCalculation() async{
    p.value = <int>[];
   await FirebaseFirestore.instance
        .collection("carts")
        .where("user_id", isEqualTo: getStorage.read(kfUid))
        .get()
        .then((value) {
      // Map<String,dynamic >? data = value.docChanges[0].doc.data();
      // print(data!['product_quantity']);
      value.docChanges.forEach((element) async {
        p.add(element.doc.get("product_quantity"));
       await getProductPrice(pId: element.doc.get("product_id"),pQty:element.doc.get("product_quantity"));
      });
    });
  }

  getProductPrice({@required pId,int?  pQty})  {
    FirebaseFirestore.instance
        .collection("product_collection")
        .doc(pId)
        .get()
        .then((value) {
      // Map<String,dynamic >? data = value.docChanges[0].doc.data();
      // print(data!['product_quantity']);
      sumOfCartItemsTotal.value = sumOfCartItemsTotal.value + (pQty!) * (int.parse(value.get("mrp")));
    
    });

    // print(pmrp);
  }

Future  getTotal() async {
 await getDataForCartCalculation();

    print(sumOfCartItemsTotal.value);
  }

  final count = 0.obs;
  @override
  void onInit() {
 
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    totalCartItemCount = 0.obs;

    cartTotal = 0.obs;
  }

  void increment() => count.value++;
}
