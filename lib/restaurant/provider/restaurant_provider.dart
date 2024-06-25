import 'package:restaurant/common/model/cursor_pagination_model.dart';
import 'package:restaurant/common/model/pagination_params.dart';
import 'package:restaurant/restaurant/model/restaurant_model.dart';
import 'package:restaurant/restaurant/repository/restaurant_respository.dart';
import 'package:riverpod/riverpod.dart';

final restaurantProvider = StateNotifierProvider
<RestaurantStateNotifier, CursorPaginationBase>(
    (ref){
      final repository = ref.watch(restaurantRepositoryProvider);

      final notifier = RestaurantStateNotifier(repository:repository);

      return notifier;
    }
);
class RestaurantStateNotifier extends StateNotifier<CursorPaginationBase>{
  final RestaurantRespository repository;

  RestaurantStateNotifier({
    required this.repository,
  }): super(CursorPaginationLoading()){
    paginate();
  }


  //페이지네이트:상태변경시 새로운 값을 업데이트하여 보여줌
  paginate({
    int fetchCount =20,
    //추가로 데이터 더 가져오기
    //true면 추가하고, false면 첫 데이터(새로고침/현재 상태를 덮어씌움)
    bool fetchMore = false,
    //강제로 다시 로딩
    //true면, 강제로 CurpaginationLoading
    bool forceRefetch = false,
}) async {
    //1. CurPagination상태 - 정상적으로 데이터가 있음
    //2. CurPaginationLoading - 데이터 로딩중(현재 캐시 없음)
    //3. CurpaginationError - 에러
    //4. CurpaginationRefetching - 첫번째 데이터부터 다시 데이터 가져오기
    //5. CurPaginationFetchMore - 추가 데이터 paginate해오라는 요청을 받은 경우

    //q바로 반환하는 상황
    //1. hasmore= false(기존 상태에서 이미 다음데이터가 없다는 것을 받은 경우)
    //2. 로딩중- fetchMore : true
  //        fetchMore가 아닐때 - 새로고침의 의도가 있을 수 있음
    if(state is CursorPagination && !forceRefetch){
        final pStatge = state as CursorPagination;//강제형변환(자동완성을 위하여)
        if(!pStatge.meta.hasMore){
          return;
        }
    }
    final isLoading = state is CursorPaginationLoading; //처음로딩
    final isRefetching = state is CursorPaginationRefetching; //데이터는 받아왔지만 유저가 새로고침을 요청한 경우
    final isFetchingMore = state is CursorPaginationRefetching; //추가로딩

    //2번의 반환상황
    if(fetchMore && (isLoading || isRefetching||isFetchingMore)){
      return;
    }

    //paginationParams 생성
    PaginationParams paginationParams = PaginationParams(
      count: fetchCount,
    );

    //fetchMore
    //데이터를 추가로 더 가져오는 상황
    if(fetchMore){
      final pState = state as CursorPagination;

      //이미 들고있는 속성들을 유지한채로 클래스만 변경.
      state = CursorPaginationFetchingMore(
          meta: pState.meta,
          data: pState.data
      );

      //after넣어주기
      paginationParams = paginationParams.copyWith(
        after: pState.data.last.id;
      );
    }
    final resp = await repository.paginate(
      paginationParams: paginationParams,
    );

    if(state is CursorPaginationFetchingMore){
      final pState = state as CursorPaginationFetchingMore;
    }

    //기존에 있던 데이터 + 새로 들어온 데이터를 합쳐서 저장.
    state = resp.copyWith(
      data: [
        ...pState.data,
        ...resp.data,
      ],
    );
  }
}
