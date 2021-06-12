import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:usergrocery/app/modules/category_wise/controllers/category_wise_controller.dart';
import 'package:usergrocery/app/routes/app_pages.dart';
import 'package:usergrocery/theme/color_theme.dart';

import '../controllers/categorylist_controller.dart';

class CategorylistView extends GetView<CategorylistController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Categories",
          style: TextStyle(color: Colors.blueGrey),
        ),
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: (){
            Get.back();
          },
            child: Icon(Icons.arrow_back, color: Colors.amber, size: 30)),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Icon(
              Icons.search,
              color: Colors.grey,
              size: 30,
            ),
          )
        ],
      ),
      body: FutureBuilder<List<DocumentChange>>(
        future: controller.getCategories(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }

          if (!snapshot.hasData) {
            return Text("Document does not exist");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                DocumentChange<Object?>? data1 = snapshot.data![index];
                DocumentSnapshot data = data1!.doc;
                return Card(
                  elevation: 0,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: CachedNetworkImage(
                          imageUrl: data['theme_image'],
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        flex: 4,
                        child: Text(
                          data['category_title'].toString().toUpperCase(),
                          style: TextStyle(color: textColor),
                        ),
                      ),
                      Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () async {
                              CategoryWiseController.to.categoryId.value =
                                  data.id;
                               Get.toNamed(Routes.CATEGORY_WISE);
                            },
                            child: Icon(
                              Icons.arrow_forward,
                              size: 20,
                              color: iconColor,
                            ),
                          ))
                    ],
                  ),
                );
              },
            );
          }
          return Text("loading..");
        },
      ),
    );
  }
}
