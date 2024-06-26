import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant/common/model/cursor_pagination_model.dart';
import 'package:restaurant/restaurant/component/restaurant_card.dart';
import 'package:restaurant/restaurant/provider/restaurant_provider.dart';
import 'package:restaurant/restaurant/view/restaurant_detail_screen.dart';

class RestaurantScreen extends ConsumerStatefulWidget {
  const RestaurantScreen({super.key});

  @override
  ConsumerState<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends ConsumerState<RestaurantScreen> {
  final ScrollController controller = ScrollController();

  @override
  void initstate(){
    super.initState();

    controller.addListener(scrollListener);
  }

  void scrollListener(){
    //현재 위치가 최대 길이보다 조금 덜 되는 위치까지 왔다면
    //새로운 데이터의 추가 요청
    if(controller.offset>controller.position.maxScrollExtent-300)
      ref.read(restaurantProvider.notifier).paginate(
        fetchMore: true
      );
  }

  @override
  Widget build(BuildContext context) {
    //어떤 순간에서든 restaurantProvider이 생성됨. (필요가없어지면 알아서 삭제)
    final data = ref.watch(restaurantProvider);

    //최로 로딩상태
    if(data is CursorPaginationLoading){
      return Center(
        child:CircularProgressIndicator(),
      );
    }

    //에러 상태
    if(data is CursorPaginationError){
      return Center(
        child: Text(data.message)
      );
    }

    //CursorPagination, FetchingMore, Refetching ...
    final cp = data as CursorPagination;

    return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView.separated(
            controller: controller,
                itemCount: cp.data.length+1,
                itemBuilder: (_, index) {
                if(index==cp.data.length){
                  return Padding(padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                  child: Center(
                    child:data is CursorPaginationFetchingMore?
                      CircularProgressIndicator():Text("마지막 데이터입니다 ㅠㅠ")
                  ));
                }
                  final pItem = cp.data[index];
                  return GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => RestaurantDetailScreen(id: pItem.id))),
                    child: RestaurantCard.fromModel(model: pItem),
                  );
                },
                separatorBuilder: (_, index) {
                  return SizedBox(height: 16.0);
                },
          )
    );
  }
}
