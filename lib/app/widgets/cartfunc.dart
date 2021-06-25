


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
  CollectionReference cartCollection = FirebaseFirestore.instance.collection("carts");


cartAdd({@required pId,@required pPrice,@required pQuantity,@required userId }){


 

  Map<String,dynamic> data = {"product_id":pId,"product_price":pPrice,"product_quantity":pQuantity,"user_id":userId};
  cartCollection.add(data);
  }
  
 

cartUpdate({@required cId,@required pQuantity}){
  
  cartCollection.doc(cId).update({"product_quantity":pQuantity});
}




