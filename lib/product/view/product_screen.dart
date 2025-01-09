import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:restaurant/common/component/pagination_list_view.dart';
import 'package:restaurant/product/model/product_model.dart';
import 'package:restaurant/product/provider/product_provider.dart';
import 'package:restaurant/restaurant/view/restaurant_detail_screen.dart';

import '../component/product_card.dart';

class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PaginationListView<ProductModel>(
      provider: productProvider,
      itemBuilder: <ProductModel>(_, index, model) {
        return GestureDetector(
            onTap: () {
              context.goNamed(RestaurantDetailScreen.routeName,
                  params: {'rid': model.restaurant.id});
            },
            child: ProductCard.fromProductModel(model: model));
      },
    );
  }
}
