import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant/common/component/pagination_list_view.dart';
import 'package:restaurant/common/model/cursor_pagination_model.dart';
import 'package:restaurant/common/utils/pagination_utils.dart';
import 'package:restaurant/restaurant/component/restaurant_card.dart';
import 'package:restaurant/restaurant/provider/restaurant_provider.dart';
import 'package:restaurant/restaurant/view/restaurant_detail_screen.dart';

class RestaurantScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PaginationListView(
        provider: restaurantProvider,
        itemBuilder:<RestaaurantModel>(_,index,model){
      return GestureDetector(
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => RestaurantDetailScreen(id: model.id))),
        child: RestaurantCard.fromModel(model: model),
      );
    });
  }
}
