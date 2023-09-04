import 'package:flutter/foundation.dart';
import 'package:restaurant/restaurant/model/restaurant_model.dart';

import '../../common/const/data.dart';

//상속을 통한 중복 방지
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

  factory RestaurantDetailModel.fromJson({
    required Map<String, dynamic> json,
  }) {
    return RestaurantDetailModel(
        id: json['id'],
        name: json['name'],
        thumbUrl: "http://$ip${json['thumbUrl']}",
        tags: List<String>.from(json['tags']),
        priceRange: RestaurantPriceRange.values
            .firstWhere((e) => e.name == json['priceRange']),
        ratings: json['ratings'],
        ratingsCount: json['ratingsCount'],
        deliveryTime: json['deliveryTime'],
        deliveryFee: json['deliveryFee'],
        detail: json['detail'],
        products: json['products'].map<RestaurantProductModel>((x) => RestaurantProductModel(
              id: x['id'],
              name: x['name'],
              imgUrl: x['imgUrl'],
              detail: x['detail'],
              price: x['price'],
            )).toList(),
    );
  }
}

//map를 통한 번거로움을 줄여줄 미니 모델생성
class RestaurantProductModel {
  final String id;
  final String name;
  final String imgUrl;
  final String detail;
  final int price;

  RestaurantProductModel(
      {required this.id,
      required this.name,
      required this.imgUrl,
      required this.detail,
      required this.price});
}
