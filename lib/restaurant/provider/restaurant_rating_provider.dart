import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant/common/model/cursor_pagination_model.dart';

class RestaurantRatingProvider extends StateNotifier<CursorPaginationBase>{
  final RestaurantRatingRepository repository;

  RestaurantRatingStateNotifier({
    required this.repository,
}):
  super(CursorPaginationLoading(),);
}