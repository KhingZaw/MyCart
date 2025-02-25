import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  final int id;
  final String title;
  final double price;
  final int quantity;
  final double total;
  final double discountPercentage;
  final double discountedTotal;
  final String thumbnail;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.quantity,
    required this.total,
    required this.discountPercentage,
    required this.discountedTotal,
    required this.thumbnail,
  });
  // Factory constructor for JSON deserialization
  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  // Method for JSON serialization
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
