import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:restaurant/common/component/pagination_list_view.dart';
import 'package:restaurant/restaurant/component/restaurant_card.dart';
import 'package:restaurant/restaurant/provider/restaurant_provider.dart';
import 'package:restaurant/restaurant/view/restaurant_detail_screen.dart';
import 'package:restaurant/user/provider/auth_provider.dart';

class RestaurantScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PaginationListView(
        provider: restaurantProvider,
        itemBuilder:<RestaaurantModel>(_,index,model){
      return GestureDetector(
        onTap: () {
          context.goNamed(RestaurantDetailScreen.routeName,
            params: {'rid':model.id},
          );
        },
        child: RestaurantCard.fromModel(model: model),
      );
    });
  }
}
