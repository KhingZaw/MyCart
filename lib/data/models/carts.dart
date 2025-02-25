import 'package:json_annotation/json_annotation.dart';
import 'package:testing_app/data/models/product.dart';

part 'carts.g.dart';

@JsonSerializable()
class Carts {
  final int id;
  @JsonKey(toJson: _ProductToJson, fromJson: _ProductFromJson)
  final List<Product> products;
  final double total;
  final double discountedTotal;
  final int userId;
  final int totalProducts;
  final int totalQuantity;
  Carts({
    required this.id,
    required this.products,
    required this.total,
    required this.discountedTotal,
    required this.userId,
    required this.totalProducts,
    required this.totalQuantity,
  });
  // Factory constructor for JSON serialization
  factory Carts.fromJson(Map<String, dynamic> json) => _$CartsFromJson(json);

  // Method to convert object to JSON
  Map<String, dynamic> toJson() => _$CartsToJson(this);
}

// Custom serialization methods for Product list
// ignore: non_constant_identifier_names
List<Map<String, dynamic>> _ProductToJson(List<Product> products) =>
    products.map((product) => product.toJson()).toList();

// ignore: non_constant_identifier_names
List<Product> _ProductFromJson(List<dynamic> json) =>
    json.map((item) => Product.fromJson(item as Map<String, dynamic>)).toList();
