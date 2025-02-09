import 'package:dio/dio.dart' hide Headers;
import 'package:restaurant/common/const/data.dart';
import 'package:restaurant/common/dio/dio.dart';
import 'package:restaurant/order/model/order_model.dart';
import 'package:restaurant/order/model/post_order_body.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod/riverpod.dart';

part 'order_repository.g.dart';

final OrderRepositoryProvider = Provider<OrderRepository>(
    (ref) {
      final dio = ref.watch(dioProvider);
      return OrderRepository(dio, baseUrl: 'http://$ip/order');
    }
);

//http://$ip/order
@RestApi()
abstract class OrderRepository{
  factory OrderRepository(Dio dio, {String baseUrl}) = _OrderRepository;

  @POST('/')
  @Headers({
    'accessToken':'true',
  })
  Future<OrderModel> postOrder({
    @Body()  required PostOrderBody body,
});
}