import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:usergrocery/app/modules/productdetail/controllers/productdetail_controller.dart';
import 'package:usergrocery/app/modules/search/controllers/search_controller.dart';
import 'package:usergrocery/app/routes/app_pages.dart';
import 'package:usergrocery/app/widgets/products_card.dart';


class SearchView extends GetView<SearchController> {

  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      
          leading: InkWell(
               
                child: Icon(Icons.arrow_back, color: Colors.amber, size: 30)),
        backgroundColor: Colors.white,
        title:SizedBox(
                  height: 40,
                  child: TextField(
                    onChanged: controller.search,
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.search),
                      contentPadding: EdgeInsets.only(left: 15, top: 5),
                      border: new OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.amber, width: 2),
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(20.0),
                        ),
                      ),
                      hintText: "Search..................",
                      hintStyle: TextStyle(color: Colors.grey),

                    ),
                  ),
                ) ,
        
      ),
      body:  SingleChildScrollView(
              child: Column(children: [
               
                Obx((){
                  if(controller.newDataList.length == 0){
                    return SizedBox.shrink();
                  }
                  else{


                      














                      return  GridView.builder(
                        
                         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: .6,
          ),
                        
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount: controller.newDataList.length,
                  itemBuilder: (BuildContext context, int index) {
                    final data = controller.newDataList[index].data() as Map;
                   return InkWell(
              onTap: () async {
                ProductdetailController.to.productName.value =
                    data['product_name'];
                ProductdetailController.to.productId.value =
                    controller.newDataList[index].id;
                ProductdetailController.to.categoryId.value =
                    data['category_id'];
                 await Get.toNamed(Routes.PRODUCTDETAIL);
              },
              child: ProductCards(data: data,id:controller.newDataList[index].id ,),
            );
                 },
                );
                  }
                
                })
               
              ]
        ),
      ),);
  }
}
