import "package:dio/dio.dart" hide Headers;
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:restaurant/common/dio/dio.dart";
import "package:restaurant/common/repository/base_pagination_repository.dart";
import "package:restaurant/rating/model/rating_model.dart";
import "package:retrofit/retrofit.dart";

import "../../common/model/cursor_pagination_model.dart";
import "../../common/model/pagination_params.dart";

part 'restaurant_rating_repository.g.dart';

final RestaurantRatingRespositoryProvider = Provider.family<
RestaurantRatingRespository,
String
>((ref,id){
  final dio = ref.watch(dioProvider);
  
  return RestaurantRatingRespository((dio, baseUrl: 'http://$ip/restaurant/$id/rating'));
})

//http://ip/restaurant/:rid/rating
@RestApi()
abstract class RestaurantRatingRespository implements
IBasePaginationRepository<RatingModel>{
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
