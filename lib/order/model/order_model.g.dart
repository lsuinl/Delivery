// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderProductModel _$OrderProductModelFromJson(Map<String, dynamic> json) =>
    OrderProductModel(
      id: json['id'] as String,
      name: json['name'] as String,
      detail: json['detail'] as String,
      imgUrl: DataUtils.pathToUrl(json['imgUrl'] as String),
      price: (json['price'] as num).toInt(),
    );

Map<String, dynamic> _$OrderProductModelToJson(OrderProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'detail': instance.detail,
      'imgUrl': instance.imgUrl,
      'price': instance.price,
    };

OrderProduceAndCountModel _$OrderProduceAndCountModelFromJson(
        Map<String, dynamic> json) =>
    OrderProduceAndCountModel(
      product:
          OrderProductModel.fromJson(json['product'] as Map<String, dynamic>),
      count: (json['count'] as num).toInt(),
    );

Map<String, dynamic> _$OrderProduceAndCountModelToJson(
        OrderProduceAndCountModel instance) =>
    <String, dynamic>{
      'product': instance.product,
      'count': instance.count,
    };

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
      id: json['id'] as String,
      products: (json['products'] as List<dynamic>)
          .map((e) =>
              OrderProduceAndCountModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPrice: (json['totalPrice'] as num).toInt(),
      restaurant:
          RestaurantModel.fromJson(json['restaurant'] as Map<String, dynamic>),
      createdAt: DataUtils.stringToDateTime(json['createdAt'] as String),
    );

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'products': instance.products,
      'totalPrice': instance.totalPrice,
      'restaurant': instance.restaurant,
      'createdAt': instance.createdAt.toIso8601String(),
    };
