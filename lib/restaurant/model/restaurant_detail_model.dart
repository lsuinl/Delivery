import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:restaurant/common/utils/data_utils.dart';
import 'package:restaurant/restaurant/model/restaurant_model.dart';
import '../../common/const/data.dart';
part 'restaurant_detail_model.g.dart';

//상속을 통한 중복 방지
@JsonSerializable()
class RestaurantDetailModel extends RestaurantModel {
  final String detail;
  final List<RestaurantProductModel> products;

  RestaurantDetailModel(
      {required super.id,
      required super.name,
      required super.thumbUrl,
      required super.tags,
      required super.priceRange,
      required super.ratings,
      required super.ratingsCount,
      required super.deliveryTime,
      required super.deliveryFee,
      required this.detail,
      required this.products});

  factory RestaurantDetailModel.fromJson(Map<String,dynamic>json)
  =>_$RestaurantDetailModelFromJson(json);
}

//map를 통한 번거로움을 줄여줄 미니 모델생성
@JsonSerializable()
class RestaurantProductModel {
  final String id;
  final String name;
  @JsonKey(fromJson: DataUtils.pathToUrl)
  final String imgUrl;
  final String detail;
  final int price;

  RestaurantProductModel(
      {required this.id,
      required this.name,
      required this.imgUrl,
      required this.detail,
      required this.price});

  factory RestaurantProductModel.fromJson(Map<String, dynamic> json)
  => _$RestaurantProductModelFromJson(json);
}
