import 'package:retrofit/http.dart';

import '../model/cursor_pagination_model.dart';
import '../model/pagination_params.dart';

abstract class IBasePaginationRepository<T>{
  Future<CursorPagination<T>> paginate({
    @Queries() PaginationParams? paginationParams = const PaginationParams(),
  });
}