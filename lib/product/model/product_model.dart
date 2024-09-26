import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:restaurant/common/model/model_with_id.dart';
import 'package:restaurant/restaurant/model/restaurant_model.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel implements IModelWithId{
  final String id;
  final String name;//이름 
  final String detail;//상세정보
  final String imgUrl;//주소
  final int price;//가격
  final RestaurantModel restaurant;//레스토랑 정보

  ProductModel({
    required this.id,
    required this.name,
    required this.detail,
    required this.imgUrl,
    required this.price,
    required this.restaurant,
});
  factory ProductModel.fromJson(Map<String, dynamic> json)
  => _$ProductModelFromJson(json);
}