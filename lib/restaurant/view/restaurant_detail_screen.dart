import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant/common/dio/dio.dart';
import 'package:restaurant/common/layout/default_layout.dart';
import 'package:restaurant/product/component/product_card.dart';
import 'package:restaurant/restaurant/component/restaurant_card.dart';
import 'package:restaurant/restaurant/model/restaurant_detail_model.dart';
import 'package:restaurant/restaurant/repository/restaurant_respository.dart';

import '../../common/const/data.dart';

class RestaurantDetailScreen extends ConsumerWidget {
  final String id;

  const RestaurantDetailScreen({required this.id, Key? key}) : super(key: key);

  Future<RestaurantDetailModel> getRestaurantDetail(WidgetRef ref) async {
    final dio = ref.watch(dioProvider);

    final repository = RestaurantRespository(dio, baseUrl: 'http://$ip/restaurant');

    return repository.getRestaurantDetail(id: id);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultLayout(
        title: "불타는 떡볶이",
        child: FutureBuilder<RestaurantDetailModel>(
            future: getRestaurantDetail(ref),
            builder: (_, AsyncSnapshot<RestaurantDetailModel> snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }

              return CustomScrollView(
                slivers: [
                  renderTop(model: snapshot.data!),
                  renderLabel(),
                  renderProduct(products: snapshot.data!.products)
                ],
              );
            }));
  }

  SliverPadding renderLabel() {
    return SliverPadding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        sliver: SliverToBoxAdapter(
          child: Text(
            "메뉴",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ));
  }

  SliverPadding renderProduct({
    required List<RestaurantProductModel> products,
}) {
    return SliverPadding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
          (context, index) {
            final model =products[index];
            return Padding(
              padding: EdgeInsets.only(top: 16),
              child: ProductCard.fromModel(model: model),
            );
          },
          childCount: products.length,
        )));
  }

  SliverToBoxAdapter renderTop({
    required RestaurantDetailModel model,
  }) {
    return SliverToBoxAdapter(
      child: RestaurantCard.fromModel(
        model: model,
        isDetail: true,
      ),
    );
  }
}
