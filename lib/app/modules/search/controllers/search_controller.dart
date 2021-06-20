

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
    final ScrollController scrollController = ScrollController();
  static SearchController get to =>Get.find();
  CollectionReference productCollection = FirebaseFirestore.instance.collection("product_collection");
  RxList<String> searchData = <String>[].obs;
  RxList tempData = [].obs;
   List<DocumentSnapshot> sdata = <DocumentSnapshot>[];
    RxList<DocumentSnapshot> newDataList = <DocumentSnapshot>[].obs;
     RxList<DocumentSnapshot> tdata = <DocumentSnapshot>[].obs;
 
  Future searchDataList()async{
    
  QuerySnapshot<Object?> data = await productCollection.get();

  sdata = data.docs;
  print(sdata);



  }



  search(String value){
  if(value.isEmpty){
    newDataList.value = <DocumentSnapshot>[];
  }
  else{
     newDataList.value = List.from(sdata);
 newDataList.value = sdata.where((string) => string['product_name'].toLowerCase().contains(value.toLowerCase())).take(50).toList();

   
    
    // print(newDataList[0].data());
  }
  
 
  }
  int initcount = 0;



   

  
  final count = 0.obs;
  @override
  

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
