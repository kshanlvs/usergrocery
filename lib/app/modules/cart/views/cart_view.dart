import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:usergrocery/theme/color_theme.dart';

import '../controllers/cart_controller.dart';

class CartView extends GetView<CartController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Cart',style: TextStyle(color: textColor),),
                    leading: InkWell(
            onTap: (){
              Get.back();
            },
            child: Icon(Icons.arrow_back,color: Colors.amber, size: 30)),
          backgroundColor: Colors.white,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return  Dismissible (
                      key:UniqueKey(),

                                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          color: Colors.grey[200],
                          height: 100,
                          width: Get.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: 100,
                                    color: Colors.amber.withOpacity(.2),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: AspectRatio(
                                        aspectRatio: 1 / 2,
                                        child: Image.asset(
                                            //replace this with cachenetwork image
                                            "assets/images/skincare.png"),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Product title goes here",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                                      SizedBox(height: 20),
                                      Text("Rs. 200"),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                  flex: 2,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    height: 30,
                                                    width: 30,
                                                    // color: Colors.blueGrey[900],
                                                    child: Card(
                                                      color: Colors.amber
                                                          .withOpacity(.1),
                                                      child: Icon(
                                                        Icons.remove,
                                                        color: Colors.white,
                                                        size: 18,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 20,
                                                    width: 30,
                                                    color: Colors.white,
                                                    child: Center(
                                                      child: Text(
                                                        "0",
                                                        style: TextStyle(
                                                            color: Colors
                                                                .blueGrey[900]),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 30,
                                                    width: 30,
                                                    // color: Colors.blueGrey[900],
                                                    child: Card(
                                                      color: Colors.amber[800]
                                                        ,
                                                      child: Icon(
                                                        Icons.add,
                                                        color: Colors.white,
                                                        size: 18,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ))
                            ],
                          ),
                        ),
                      ),
                    );
                  })
            ],
          ),
        ));
  }
}
