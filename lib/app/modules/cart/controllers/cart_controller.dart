import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../Constants.dart';

class CartController extends GetxController {
  static CartController get to => Get.find();
  CollectionReference cartCollection =
      FirebaseFirestore.instance.collection("carts");

  RxInt totalCartItemCount = 0.obs;
  GetStorage getStorage = GetStorage();

  RxInt cartTotal = 0.obs;



  Future getCartItemsTotal() async {




    
    RxList listOfCarttotal = [].obs;
 
    await FirebaseFirestore.instance
        .collection('carts').where("user_id",isEqualTo:getStorage.read(kfUid))
        .get()
        .then((QuerySnapshot querySnapshot) {
             totalCartItemCount.value = 0;
      querySnapshot.docs.forEach((doc) {
        if (querySnapshot.docs.length > 0) {
          listOfCarttotal.add(doc['product_quantity']);
          getCartTotal(doc["product_id"], doc['product_quantity']);
        }
      });
      if (querySnapshot.docs.length > 0) {
        totalCartItemCount.value = listOfCarttotal.reduce((a, b) => a + b);
      }
    });
  }

  Future getCartItemsTotalForDecrement() async {
    RxList listOfCarttotal = [].obs;
    totalCartItemCount.value = 0;
    await FirebaseFirestore.instance
        .collection('carts').where("user_id",isEqualTo:getStorage.read(kfUid))
        .get()
        .then((QuerySnapshot querySnapshot) {
             totalCartItemCount.value = 0;
      querySnapshot.docs.forEach((doc) {
        if (querySnapshot.docs.length > 0) {
          listOfCarttotal.add(doc['product_quantity']);
          getCartTotal(doc["product_id"], doc['product_quantity']);
        }
      });
      if(querySnapshot.docs.length>0){
      
         totalCartItemCount.value = listOfCarttotal.reduce((a, b) => a + b);
        //  print(totalCartItemCount.value);
      }
      else if(querySnapshot.docs.length == 0){
        totalCartItemCount.value = 0;
      }
      else{
         totalCartItemCount.value = 0;
      }
    });

   
  }

  getCartTotal(String id, int productQuantity) {

 
    FirebaseFirestore.instance
        .collection("product_collection")
        .doc(id)
        .get()
        .then((value) {
             
            
      Map<String, dynamic>? data = value.data();
      var mrp = data!['mrp']; // here im getting  the mrp of the product 

      // cart total will be mrp * quantty

      
      cartTotal.value = 0;
      
     cartTotal.value = int.parse(mrp) * productQuantity;
    });
     
      
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
