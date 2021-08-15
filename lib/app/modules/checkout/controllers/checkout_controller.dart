import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:usergrocery/app/models/cart_model.dart';


class CheckoutController extends GetxController {
static CheckoutController get to => Get.find();
   CollectionReference productCollection = FirebaseFirestore.instance.collection("product_collection");
      CollectionReference cartCollection = FirebaseFirestore.instance.collection("carts");
    GetStorage getStorage = GetStorage();
   Rx<CartModel> cartModel = CartModel().obs;
   RxBool checked = false.obs;

  //  Future getDataForOrderSummery() async{
  //  await  cartCollection.where("user_id",isEqualTo:getStorage.read(kfUid)).get().then((value) {
  //     Map<String,dynamic> data = value.docChanges[0].doc.data() as Map<String,dynamic>;
  //     cartModel.value =  CartModel.fromJson(data);

  //     print(cartModel.value.productId);
  //     print(cartModel.value.productQuantity);
  //  });
  //     // productCollection.where("field")
  //  }

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
