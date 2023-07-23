// import 'package:flutter/material.dart';

class Cart {
  late final int? id;
  final String? productid;
  final String? productname;
  final int? initalPrice;
  final int? productPrice;
  final int? quantity;
  // final IconData? icon;

  Cart(
      {required this.id,
      required this.productPrice,
      // required this.icon,
      required this.initalPrice,
      required this.productid,
      required this.productname,
      required this.quantity});

  Cart.fromMap(Map<dynamic, dynamic> res)
      : id = res["id"],
        productid = res["productid"],
        productname = res["productname"],
        initalPrice = res["initalPrice"],
        productPrice = res["productPrice"],
        quantity = res["quantity"]
  // ,icon = res["icon"]
  ;

  Map<String, Object?> toMap() {
    return {
      "id": id,
      "productid": productid,
      "productname": productname,
      "initalPrice": initalPrice,
      "productPrice": productPrice,
      "quantity": quantity,
      // "icon": icon
    };
  }
}
