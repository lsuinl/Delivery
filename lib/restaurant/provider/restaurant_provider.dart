import 'package:restaurant/common/model/cursor_pagination_model.dart';
import 'package:restaurant/common/model/pagination_params.dart';
import 'package:restaurant/common/provider/pagination_provider.dart';
import 'package:restaurant/restaurant/model/restaurant_model.dart';
import 'package:restaurant/restaurant/repository/restaurant_respository.dart';
import 'package:riverpod/riverpod.dart';

final restaurantDetailProvider =
Provider.family<RestaurantModel?,String>((ref, id) {
 final state = ref.watch(restaurantProvider);

 if(state is! CursorPagination<dynamic>){ //데이터가 없음
   return null;
 }

  return state.data.firstWhere((element) => element.id==id);
});

final restaurantProvider = StateNotifierProvider
<RestaurantStateNotifier, CursorPaginationBase>(
    (ref){
      final repository = ref.watch(restaurantRepositoryProvider);

      final notifier = RestaurantStateNotifier(repository:repository);

      return notifier;
    }
);
class RestaurantStateNotifier extends PaginationProvider<
  RestaurantModel,//U 정의
  RestaurantRespository//T 정의
> {

  RestaurantStateNotifier({
    required super.repository,
  });

    void getDetail({
      required String id,
    }) async {
      //만약 아직 데이터가 하나도 없다면(CursorPagination이 아니라면)
      //데이터를 가져오는 시도를 한다.
      if (state is! CursorPagination) {
        await this.paginate();
      }

      //state 가 CursorPagination이 아닐때 그냥 리던하기
      if (state is! CursorPagination)
        return;

      final pState = state as CursorPagination;

      final resp = await repository.getRestaurantDetail(id: id);
      state = pState.copyWith(
          data: pState.data.map<RestaurantModel>
            ((e) => e.id == id ? resp : e).toList()
      );
    }
}
