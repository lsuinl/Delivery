import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant/common/model/cursor_pagination_model.dart';
import 'package:restaurant/restaurant/component/restaurant_card.dart';
import 'package:restaurant/restaurant/provider/restaurant_provider.dart';
import 'package:restaurant/restaurant/view/restaurant_detail_screen.dart';

class RestaurantScreen extends ConsumerWidget {
  const RestaurantScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //어떤 순간에서든 restaurantProvider이 생성됨. (필요가없어지면 알아서 삭제)
    final data = ref.watch(restaurantProvider);

    //로딩상태
    if(data is CursorPaginationLoading){
      return Center(
        child:CircularProgressIndicator(),
      );
    }
    //데이터가 들어왔다고 가정하고 데이터를 불러옵니다.
    final cp = data as CursorPagination;

    return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView.separated(
                itemCount: cp.data.length,
                itemBuilder: (_, index) {
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
