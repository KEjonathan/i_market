// providers/cart_provider.dart

import 'package:flutter/material.dart';
import 'package:i_market/cart/c_model.dart';
import 'package:i_market/items/item_model.dart';


class CartProvider with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => {..._items};

  int get itemCount => _items.length;

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.totalPrice;
    });
    return total;
  }

  void addItem(Item item) {
    if (_items.containsKey(item.name)) {
      _items.update(
        item.name,
        (existingCartItem) => CartItem(
          item: existingCartItem.item,
          quantity: existingCartItem.quantity + 1,
        ),
      );
    } else {
      _items.putIfAbsent(
        item.name,
        () => CartItem(
          item: item,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String itemId) {
    _items.remove(itemId);
    notifyListeners();
  }

  void clearCart() {
    _items = {};
    notifyListeners();
  }
}
