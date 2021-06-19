
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:usergrocery/app/widgets/product_details.dart';
import 'package:usergrocery/theme/color_theme.dart';

import '../controllers/productdetail_controller.dart';

class ProductdetailView extends GetView<ProductdetailController> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: InkWell(
              onTap: () {
                // controller.searchBtnPressed.value = false;
                Get.back();
              },
              child: Icon(Icons.arrow_back, color: iconColor, size: 30)),
          centerTitle: true,
         
              
            
          
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body:SingleChildScrollView(
            child: ProductDetailWidget(),
          ));
  }
}

