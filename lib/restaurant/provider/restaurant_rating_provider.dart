import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant/common/model/cursor_pagination_model.dart';
import 'package:restaurant/common/provider/pagination_provider.dart';
import 'package:restaurant/rating/model/rating_model.dart';
import 'package:restaurant/restaurant/provider/restaurant_provider.dart';
import 'package:restaurant/restaurant/repository/restaurant_rating_respository.dart';


final RestaurantRatingProvider = StateNotifierProvider.family<
    RestaurantRatingStateNotifier,
  CursorPaginationBase,
String>(
        (ref,id){
          final repo = ref.watch(RestaurantRatingRespositoryProvider(id));

          return RestaurantRatingStateNotifier(repository:repo);
        }
);

class RestaurantRatingStateNotifier
    extends PaginationProvider<RatingModel, RestaurantRatingRespository>{

  RestaurantRatingStateNotifier({
    required super.repository
  });
}