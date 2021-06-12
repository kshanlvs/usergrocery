import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ProductdetailController extends GetxController {
  static ProductdetailController get to =>Get.find();
 
CollectionReference productCollection = FirebaseFirestore.instance.collection("product_collection");
RxString productId = "".obs;
RxString productName ="".obs;
RxString categoryId = "".obs;
Future<DocumentSnapshot> getProductDetails() async{
 DocumentSnapshot data = await productCollection.doc(productId.value).get();
 
 return data;
  
 }


 Future<QuerySnapshot> getRelatedProduct() async {
   QuerySnapshot data =  await productCollection.where("category_id" ,isEqualTo:categoryId.value).get();
   return data;
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
  void onClose() {}
  void increment() => count.value++;
}
