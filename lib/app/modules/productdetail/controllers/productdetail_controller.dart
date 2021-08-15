import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:usergrocery/app/modules/home/controllers/home_controller.dart';

import '../../../../Constants.dart';

class ProductdetailController extends GetxController {
  static ProductdetailController get to => Get.find();

  CollectionReference productCollection =
      FirebaseFirestore.instance.collection("product_collection");
  RxString? productId = "".obs;
  RxString productName = "".obs;
  GetStorage getStorage = GetStorage();
  RxString categoryId = "".obs;
  RxMap<String, dynamic> data2 = Map<String, dynamic>().obs;
  final HomeController controller1 = Get.find();

  Future<DocumentSnapshot> getProductDetails() async {
    DocumentSnapshot data = await productCollection.doc(productId?.value).get();

    return data;
  }

  Future<QuerySnapshot> getRelatedProduct() async {
    QuerySnapshot data = await productCollection
        .where("category_id", isEqualTo: categoryId.value)
        .get();
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
