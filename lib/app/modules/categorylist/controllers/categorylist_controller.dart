import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class CategorylistController extends GetxController {
  CollectionReference categoryCollection = FirebaseFirestore.instance.collection("category_collection");
 

  Future<List<DocumentChange<Object?>>> getCategories()async{
     QuerySnapshot  data = await categoryCollection.get();
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
