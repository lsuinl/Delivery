import 'package:json_annotation/json_annotation.dart';
import 'package:restaurant/common/model/model_with_id.dart';
import 'package:restaurant/common/utils/data_utils.dart';
import 'package:restaurant/restaurant/model/restaurant_model.dart';

part 'order_model.g.dart';

@JsonSerializable()
class OrderProductModel {
  final String id;
  final String name;
  final String detail;
  @JsonKey(
    fromJson: DataUtils.pathToUrl,
  )
  final String imgUrl;
  final int price;

  OrderProductModel({
    required this.id,
    required this.name,
    required this.detail,
    required this.imgUrl,
    required this.price,
  });

  factory OrderProductModel.fromJson(Map<String, dynamic> json)
  => _$OrderProductModelFromJson(json);
}

@JsonSerializable()
class OrderProduceAndCountModel{
  final OrderProductModel product;
  final int count;

  OrderProduceAndCountModel({
    required this.product,
    required this.count,
  });
  
  factory OrderProduceAndCountModel.fromJson(Map<String, dynamic> json)
  => _$OrderProduceAndCountModelFromJson(json);
}


@JsonSerializable()
class OrderModel implements IModelWithId{
  final String id;
  final List<OrderProduceAndCountModel> products;
  final int totalPrice;
  final RestaurantModel restaurant;
  @JsonKey(
    fromJson: DataUtils.stringToDateTime
  )
  final DateTime createdAt;

  OrderModel({
    required this.id,
    required this.products,
    required this.totalPrice,
    required this.restaurant,
    required this.createdAt,
});
  factory OrderModel.fromJson(Map<String, dynamic> json)
  => _$OrderModelFromJson(json);
}