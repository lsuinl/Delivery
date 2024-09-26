import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant/common/model/cursor_pagination_model.dart';
import 'package:restaurant/common/provider/pagination_provider.dart';
import 'package:restaurant/product/model/product_model.dart';
import 'package:restaurant/product/view/product_repository.dart';

final productProvider = StateNotifierProvider<ProductStateNotifier,
CursorPaginationBase>
  ((ref){
    final repo = ref.watch(ProductRepositoryProvider);
    return ProductStateNotifier(repository: repo);
});

class ProductStateNotifier extends PaginationProvider<ProductModel, ProductRepository>{
  ProductStateNotifier({
    required super.repository
});
}