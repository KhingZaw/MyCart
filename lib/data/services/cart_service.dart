import 'dart:convert';
import 'dart:io';
import 'package:testing_app/data/models/carts.dart';
import 'package:http/http.dart' as http;
import 'package:testing_app/data/services/local_service.dart';

class CartService {
  final String baseUrl = "https://dummyjson.com";

  Future<Map<String, dynamic>> login(String username, String password) async {
    try {
      var response = await http.post(
        Uri.parse("$baseUrl/auth/login"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "username": username.trim(),
          "password": password.trim(),
        }),
      );

      if (response.statusCode == 200) {
        var userData = jsonDecode(response.body);
        if (userData.containsKey("accessToken")) {
          String accessToken = userData["accessToken"];

          await LocalService().saveUserData(userData);
          await LocalService().saveAccessToken(accessToken);

          return {"success": true, "data": userData};
        } else {
          return {"success": false, "message": "Access token not found"};
        }
      } else if (response.statusCode == 400) {
        return {"success": false, "message": "Incorrect username or password"};
      } else {
        return {"success": false, "message": "Login failed: ${response.body}"};
      }
    } on SocketException {
      return {"success": false, "message": "No internet connection"};
    } on FormatException {
      return {"success": false, "message": "Invalid response format"};
    } catch (e) {
      return {"success": false, "message": "Unexpected error: $e"};
    }
  }

  /// Get all carts data
  Future<List<Carts>> getAllCartsData() async {
    try {
      var response = await http.get(Uri.parse("$baseUrl/carts"));

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        if (data.containsKey("carts")) {
          return (data["carts"] as List)
              .map((cart) => Carts.fromJson(cart))
              .toList();
        } else {
          throw Exception("No carts data found");
        }
      } else {
        throw Exception("Failed to load carts: ${response.body}");
      }
    } catch (e) {
      throw Exception("Error fetching carts: $e");
    }
  }

  // Get cart details by ID
  Future<Carts> getCartById({required int id}) async {
    try {
      var response = await http.get(Uri.parse("$baseUrl/carts/$id"));

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return Carts.fromJson(data);
      } else {
        throw Exception("Failed to load cart with ID $id: ${response.body}");
      }
    } catch (e) {
      throw Exception("Error fetching cart by ID: $e");
    }
  }
}
