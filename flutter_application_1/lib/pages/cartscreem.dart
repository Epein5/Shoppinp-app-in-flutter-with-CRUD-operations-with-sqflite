import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/cart_model.dart';
import 'package:flutter_application_1/utils/cart_provider.dart';
import 'package:flutter_application_1/utils/db_helper.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // DBhelper? db = DBhelper();
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.grey,
        centerTitle: true,
        title: const Text('Your Products'),
      ),
      body: Column(
        children: [
          FutureBuilder(
            future: cart.getCartItems(),
            builder: (context, AsyncSnapshot<List<Cart>> snapshot) {
              DBhelper db = DBhelper();
              if (snapshot.hasData) {
                return Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: Row(
                              children: [
                                // ontappedfunc(index),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      height: 100,
                                      width: 100,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors.grey),
                                      child: const Icon(Icons.smartphone)),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    // mainAxisSize: MainAxisSize.max,
                                    // mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      // Text("HAwa"),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(snapshot
                                            .data![index].productname
                                            .toString()),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(snapshot
                                            .data![index].productPrice
                                            .toString()),
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15),
                                          child: InkWell(
                                            onTap: () {},
                                            child: Ink(
                                              height: 35,
                                              width: 180,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: Colors.black),
                                              child: Center(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        int quantity = snapshot
                                                            .data![index]
                                                            .quantity!;
                                                        quantity--;
                                                        int price = snapshot
                                                            .data![index]
                                                            .initalPrice!;
                                                        int newPrice =
                                                            quantity * price;

                                                        db
                                                            .updateCartItems(Cart(
                                                                id: snapshot
                                                                    .data![
                                                                        index]
                                                                    .id,
                                                                productPrice:
                                                                    newPrice,
                                                                initalPrice: snapshot
                                                                    .data![
                                                                        index]
                                                                    .initalPrice,
                                                                productid: snapshot
                                                                    .data![
                                                                        index]
                                                                    .productid
                                                                    .toString(),
                                                                productname: snapshot
                                                                    .data![
                                                                        index]
                                                                    .productname
                                                                    .toString(),
                                                                quantity:
                                                                    quantity))
                                                            .then((value) {
                                                          if (int.parse(snapshot
                                                                  .data![index]
                                                                  .quantity
                                                                  .toString()) ==
                                                              1) {
                                                            print("aayush");
                                                            cart.reduceCounter();
                                                            cart.reduceTotalPrice(
                                                                double.parse(snapshot
                                                                    .data![
                                                                        index]
                                                                    .productPrice
                                                                    .toString()));
                                                            db.deleteCartItems(
                                                                snapshot
                                                                    .data![
                                                                        index]
                                                                    .id!);
                                                          } else {
                                                            newPrice = 0;
                                                            quantity = 0;
                                                            cart.reduceTotalPrice(
                                                                double.parse(snapshot
                                                                    .data![
                                                                        index]
                                                                    .initalPrice
                                                                    .toString()));
                                                          }
                                                        }).onError((error,
                                                                stackTrace) {});
                                                      },
                                                      child: const Icon(
                                                        Icons.remove,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    Text(
                                                      snapshot
                                                          .data![index].quantity
                                                          .toString(),
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        int quantity = snapshot
                                                            .data![index]
                                                            .quantity!;
                                                        quantity++;
                                                        int price = snapshot
                                                            .data![index]
                                                            .initalPrice!;
                                                        int new_price =
                                                            quantity * price;

                                                        db
                                                            .updateCartItems(Cart(
                                                                id: snapshot
                                                                    .data![
                                                                        index]
                                                                    .id,
                                                                productPrice:
                                                                    new_price,
                                                                initalPrice: snapshot
                                                                    .data![
                                                                        index]
                                                                    .initalPrice,
                                                                productid: snapshot
                                                                    .data![
                                                                        index]
                                                                    .productid
                                                                    .toString(),
                                                                productname: snapshot
                                                                    .data![
                                                                        index]
                                                                    .productname
                                                                    .toString(),
                                                                quantity:
                                                                    quantity))
                                                            .then((value) {
                                                          quantity = 0;
                                                          new_price = 0;
                                                          cart.addTotalPrice(
                                                              double.parse(snapshot
                                                                  .data![index]
                                                                  .initalPrice
                                                                  .toString()));
                                                        }).onError((error,
                                                                stackTrace) {
                                                          print(
                                                              error.toString());
                                                        });
                                                      },
                                                      child: const Icon(
                                                        Icons.add,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    cart.reduceCounter();
                                    cart.reduceTotalPrice(double.parse(snapshot
                                        .data![index].productPrice
                                        .toString()));
                                    db.deleteCartItems(
                                        snapshot.data![index].id!);
                                  },
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 60, 5, 0),
                                    child: Ink(
                                      decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: const Padding(
                                        padding: EdgeInsets.all(3.0),
                                        child: Icon(Icons.delete),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        }));
              } else {
                return const Center(
                  child: Text("No Items Selected"),
                );
              }
              // return Text('whatthe');
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(10)),
              width: double.infinity,
              height: 40,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text("Total Price "),
                    Text(cart.getTotalPrice().toString())
                  ]),
            ),
          )
        ],
      ),
    );
  }
}
