import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class CategoryWiseController extends GetxController {
  static CategoryWiseController get to => Get.find();
 
CollectionReference productCollection = FirebaseFirestore.instance.collection("product_collection");
CollectionReference categoryCollection = FirebaseFirestore.instance.collection("category_collection");

 RxString categoryId = "".obs;

RxBool searchBtnPressed = false.obs;

Future<List<DocumentChange>>  getProductCategororyWise() async{
  QuerySnapshot data =  await productCollection.where("category_id",isEqualTo: categoryId.value).get();
  return data.docChanges;
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
