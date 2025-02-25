// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'carts.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Carts _$CartsFromJson(Map<String, dynamic> json) => Carts(
      id: (json['id'] as num).toInt(),
      products: _ProductFromJson(json['products'] as List),
      total: (json['total'] as num).toDouble(),
      discountedTotal: (json['discountedTotal'] as num).toDouble(),
      userId: (json['userId'] as num).toInt(),
      totalProducts: (json['totalProducts'] as num).toInt(),
      totalQuantity: (json['totalQuantity'] as num).toInt(),
    );

Map<String, dynamic> _$CartsToJson(Carts instance) => <String, dynamic>{
      'id': instance.id,
      'products': _ProductToJson(instance.products),
      'total': instance.total,
      'discountedTotal': instance.discountedTotal,
      'userId': instance.userId,
      'totalProducts': instance.totalProducts,
      'totalQuantity': instance.totalQuantity,
    };
