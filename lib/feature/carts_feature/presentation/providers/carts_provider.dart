import 'package:ecommerce_motion_flutter/feature/detail_products/domain/entity/detail_products_entity.dart';
import 'package:flutter/material.dart';

class CartsProvider extends ChangeNotifier {
  final List<DetailProductsEntity> _shopCart = [];
  List<DetailProductsEntity> get shopCart => _shopCart;
  

  final Map<int, int> _quantityMap = {};

  double getTotalPrice() {
    double totalPrice = 0;

    for (var cart in _shopCart) {
      totalPrice += cart.price * getQuantity(cart.id);
    }

    return totalPrice;
  }

  int getQuantity(int id) {
    return _quantityMap[id] ?? 0;
  }

  void addToCart(DetailProductsEntity product, int quantity) {
    int productId = product.id;

    bool productExistsInCart =
        _shopCart.any((cartProduct) => cartProduct.id == productId);

    if (productExistsInCart) {

      DetailProductsEntity existingCart =
          _shopCart.firstWhere((cart) => cart.id == productId);

      _quantityMap[productId] = (_quantityMap[productId] ?? 0) + quantity;
      existingCart.quantity = _quantityMap[productId]!;
    } else {

      _quantityMap[productId] = quantity;
      product.quantity = quantity;

      _shopCart.add(product);

      notifyListeners();
    }
  }

  void removeFromCart(DetailProductsEntity product) {
    int productId = product.id;

    if (_quantityMap[productId] != null && _quantityMap[productId]! > 0) {
      _quantityMap[productId] = _quantityMap[productId]! - 1;
    }

    if (_quantityMap[productId] == 0) {
      _shopCart.removeWhere((cartProduct) => cartProduct.id == productId);
    }

    notifyListeners();
  }

  void incrementQuantity(int id, int quantity) {

    DetailProductsEntity? existingCart =
        _shopCart.firstWhere((cart) => cart.id == id);

    _quantityMap[id] = (_quantityMap[id] ?? 0) + 1;
    existingCart.quantity++;
    notifyListeners();
  }

  void decrementQuantity(int id) {

    DetailProductsEntity? existingCart = _shopCart.firstWhere(
      (cart) => cart.id == id,
    );

    if (_quantityMap[id] != null && _quantityMap[id]! > 0) {
      _quantityMap[id] = _quantityMap[id]! - 1;
      existingCart.quantity--;

      if (_quantityMap[id] == 0) {
        _shopCart.removeWhere((cartProduct) => cartProduct.id == id);
      }

      notifyListeners();
    }
  }
}
