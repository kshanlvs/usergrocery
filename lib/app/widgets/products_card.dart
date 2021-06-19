import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProductCards extends StatefulWidget {
  const ProductCards({
    Key? key,
    required this.data,
  }) : super(key: key);

  final Map data;

  @override
  _ProductCardsState createState() => _ProductCardsState();
}

class _ProductCardsState extends State<ProductCards> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.data["product_name"],
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: Colors.black87,
              ),
            ),
          ),
          Text(
            "Short detail",
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          SizedBox(
            height: 100,
            width: 120,
            child: CachedNetworkImage(
              imageUrl: widget.data['theme_image'],
              imageBuilder: (context, imageProvider) => Container(
                width: 100.0,
                height: 100.0,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  // border: Border.all(
                  //     color: Colors.grey),
                  shape: BoxShape.rectangle,
                  image: DecorationImage(
                      image: imageProvider, fit: BoxFit.contain),
                ),
              ),
              placeholder: (context, url) =>
                  Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Expanded(flex: 1, child: Text("hello")),
                Expanded(
                  flex: 4,
                  child: Text(
                    "per ${widget.data["quantity"].toString().toUpperCase()} ${widget.data["unit"]}",
                    style: TextStyle(color: Colors.grey),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      Text(
                        "\u20B9",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        widget.data["mrp"],
                        style: TextStyle(
                            fontSize: 16, color: Colors.blueGrey),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 25,
                        width: 40,
                        color: Color(0xFFF5BA27),
                        child: Icon(
                          Icons.remove,
                          color: Colors.white,
                          size: 15,
                        ),
                      ),
                      Container(
                        height: 25,
                        width: 30,
                        color: Colors.grey[200],
                        child: Center(
                          child: Text("0"),
                        ),
                      ),
                      Container(
                        height: 25,
                        width: 40,
                        color: Color(0xFFF5BA27),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 15,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}