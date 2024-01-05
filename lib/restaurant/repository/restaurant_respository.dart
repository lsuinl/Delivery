import 'package:dio/dio.dart' hide Headers;
import 'package:restaurant/restaurant/model/restaurant_detail_model.dart';
import 'package:retrofit/retrofit.dart';

part 'restaurant_respository.g.dart';


@RestApi()
abstract class RestaurantRespository{
  //http://$ip/restaurant
  factory RestaurantRespository(Dio dio, {String baseUrl})
  = _RestaurantRespository;

  // @GET('/')
  // paginate();

  @GET('/{id}')
  @Headers({
    'authorization': 'true'
  })
  Future<RestaurantDetailModel> getRestaurantDetail({
   // @Path('id') required String sid,
    @Path() required String id,
});
}
