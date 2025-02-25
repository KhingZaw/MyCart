import 'package:flutter/material.dart';
import 'package:testing_app/data/models/carts.dart';
import 'package:testing_app/data/services/cart_service.dart';

class CartProvider with ChangeNotifier {
  List<Carts> _carts = [];
  Carts? _cart;
  bool _isLoading = false;
  String? _error;

  List<Carts> get carts => _carts;
  Carts? get cart => _cart;
  bool get isLoading => _isLoading;
  String? get error => _error;

  final CartService _cartService = CartService();

  // Fetch all carts
  Future<void> fetchCarts() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _carts = await _cartService.getAllCartsData();
    } catch (e) {
      _error = "Failed to fetch cart list: ${e.toString()}";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Fetch a single cart by ID
  Future<void> fetchCart(int id) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _cart = await _cartService.getCartById(id: id);
    } catch (e) {
      _error = "Failed to fetch cart details: ${e.toString()}";
      _cart = null; // ✅ Reset cart data on error
    }

    _isLoading = false;
    notifyListeners();
  }
}
