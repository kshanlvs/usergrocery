class CartModel {
  String? productId;
  int? productQuantity;
  String ?userId;

  CartModel({this.productId, this.productQuantity, this.userId});

  CartModel.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productQuantity = json['product_quantity'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['product_quantity'] = this.productQuantity;
    data['user_id'] = this.userId;
    return data;
  }
}