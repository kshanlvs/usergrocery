import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:usergrocery/app/routes/app_pages.dart';

class Search extends StatelessWidget {
  const Search({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: InkWell(
        onTap: (){
          Get.toNamed(Routes.SEARCH);
        },
              child: Icon(
          Icons.search,
          color: Colors.grey,
          size: 30,
        ),
      ),
    );
  }
}