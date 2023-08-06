import 'package:flutter/material.dart';
import 'package:restaurant/common/layout/default_layout.dart';
import 'package:restaurant/product/component/product_card.dart';
import 'package:restaurant/restaurant/component/restaurant_card.dart';

class RestaurantDetailScreen extends StatelessWidget {
  const RestaurantDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        title:"불타는 떡볶이",
        child:Column(
          children: [
            RestaurantCard(
                image: Image.asset(
                    "asset/img/food/ddeok_bok_gi.jpg"),
                name: '불타는 떡볶이',
                tags: ['떡볶이','맛있음','치즈'],
                ratingsCount: 100,
                deliveryTime: 30,
                deliveryFee: 3000,
                ratings: 4.76,
              isDetail: true,
              detail: '맛있는 떡볶이',
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
              child: ProductCard(),
            )
          ],
        )
    );
  }
}
