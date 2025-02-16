import 'package:dio/dio.dart' hide Headers;
import 'package:restaurant/common/const/data.dart';
import 'package:restaurant/common/dio/dio.dart';
import 'package:restaurant/common/model/cursor_pagination_model.dart';
import 'package:restaurant/common/model/pagination_params.dart';
import 'package:restaurant/common/repository/base_pagination_repository.dart';
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
abstract class OrderRepository implements IBasePaginationRepository {
  factory OrderRepository(Dio dio, {String baseUrl}) = _OrderRepository;

  @GET('/')
  @Headers({
    'accessToken':'true',
  })
  Future<CursorPagination<OrderModel>> paginate({
    @Queries() PaginationParams ? PaginationParams = const PaginationParams(),
});

  @POST('/')
  @Headers({
    'accessToken':'true',
  })
  Future<OrderModel> postOrder({
    @Body()  required PostOrderBody body,
});
}