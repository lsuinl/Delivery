import "package:dio/dio.dart" hide Headers;
import "package:restaurant/rating/model/rating_model.dart";
import "package:retrofit/retrofit.dart";

import "../../common/model/cursor_pagination_model.dart";
import "../../common/model/pagination_params.dart";

part 'restaurant_rating_repository.g.dart';

//http://ip/restaurant/:rid/rating
@RestApi()
abstract class RestaurantRatingRespository{
  factory RestaurantRatingRespository(Dio dio, {String baseUrl}) =
  _RestaurantRatingRespository;

  @GET('/')
  @Headers({
    'authorization': 'true'
  })
  Future<CursorPagination<RatingModel>> paginate({

    @Queries() PaginationParams? paginationParams = const PaginationParams(),
  });
}
