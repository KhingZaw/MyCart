import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:testing_app/data/services/cart_service.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final CartService _cartService = CartService();

  Future<bool> login(String username, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      var response = await _cartService.login(username, password);
      _isLoading = false;
      notifyListeners();

      if (response["success"] == true) {
        Fluttertoast.showToast(msg: "Successfully Logged In");
        return true; // Login success
      } else {
        Fluttertoast.showToast(msg: response["message"]);
        return false; // Login failed
      }
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      Fluttertoast.showToast(msg: "Login failed: ${e.toString()}");
      return false;
    }
  }
}
