// import 'dart:math';

import 'package:flutter_application_1/models/cart_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io' as io;
import 'package:path/path.dart';

class DBhelper {
  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDatabase();
    return _db;
  }

  initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'cart.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) {
    db.execute(
        'CREATE TABLE cart(id INTEGER PRIMARY KEY , productid VARCHAR UNIQUE,productname TEXT,initalPrice INTEGER,productPrice INTEGER,quantity INTEGER )');
  }

  Future<Cart> insert(Cart cart) async {
    var dbclient = await db;
    // await dbclient!.insert('cart', cart.toMap());
    // return cart;
    if (dbclient == null) {
      // Handle a case where the database initialization failed
      print(cart.toMap());
      throw Exception("Database not initialized.");
    }
    await dbclient.insert('cart', cart.toMap());
    return cart;
  }

  Future<List<Cart>> getCartItems() async {
    var dbclient = await db;
    final List<Map<String, Object?>> queryrequest =
        await dbclient!.query('cart');
    return queryrequest.map((e) => Cart.fromMap(e)).toList();
  }

  Future<int> deleteCartItems(int id) async {
    var dbclient = await db;
    return await dbclient!.delete('cart', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateCartItems(Cart cart) async {
    var dbclient = await db;
    return await dbclient!
        .update('cart', cart.toMap(), where: 'id = ?', whereArgs: [cart.id]);
  }
}
