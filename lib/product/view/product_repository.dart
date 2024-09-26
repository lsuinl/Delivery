 import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant/common/dio/dio.dart' hide Headers;
import 'package:restaurant/common/model/cursor_pagination_model.dart';
import 'package:restaurant/common/model/pagination_params.dart';
import 'package:restaurant/product/model/product_model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:restaurant/common/repository/base_pagination_repository.dart';
import '../../common/const/data.dart';

part 'product_repository.g.dart';

final ProductRepositoryProvider = Provider<ProductRepository>((ref) {
  final dio = ref.watch(dioProvider);

  return ProductRepository(dio,baseUrl: 'http://$ip/product');
 });

//http://$ip/product
@RestApi()
abstract class ProductRepository<T> implements IBasePaginationRepository<ProductModel>{
  factory ProductRepository(Dio dio, {String baseUrl}) =
      _ProductRepository;

  @GET('/')
  @Headers({'accessToken':'true'})
  Future<CursorPagination<ProductModel>> paginate({
    @Queries() PaginationParams? PaginationParams = const PaginationParams(),
  });
}

