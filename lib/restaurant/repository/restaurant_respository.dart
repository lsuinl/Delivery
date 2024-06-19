import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant/common/dio/dio.dart';
import 'package:restaurant/common/model/cursor_pagination_model.dart';
import 'package:restaurant/common/model/pagination_params.dart';
import 'package:restaurant/restaurant/model/restaurant_detail_model.dart';
import 'package:retrofit/retrofit.dart';
import '../../common/const/data.dart';
part 'restaurant_respository.g.dart';

final restaurantRepositoryProvider = Provider(
    (ref){
      final dio = ref.watch(dioProvider);
      final repository = RestaurantRespository(dio, baseUrl: 'http://$ip/restaurant');
    }
);

@RestApi()

abstract class RestaurantRespository{
  //http://$ip/restaurant
  factory RestaurantRespository(Dio dio, {String baseUrl})
  = _RestaurantRespository;

  @GET('/')
  @Headers({
    'authorization': 'true'
  })
  Future<CursorPagination<RestaurantDetailModel>> paginate({
    //const왜안돼
   @Queries() PaginationParams? paginationParams = const PaginationParams(),
});

  @GET('/{id}')
  @Headers({
    'authorization': 'true'
  })
  Future<RestaurantDetailModel> getRestaurantDetail({
   // @Path('id') required String sid,
    @Path() required String id,
});
}
