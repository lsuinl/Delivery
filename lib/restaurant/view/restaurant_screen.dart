import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant/restaurant/component/restaurant_card.dart';
import 'package:restaurant/restaurant/provider/restaurant_provider.dart';
import 'package:restaurant/restaurant/view/restaurant_detail_screen.dart';

class RestaurantScreen extends ConsumerWidget {
  const RestaurantScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //어떤 순간에서든 restaurantProvider이 생성됨. (필요가없어지면 알아서 삭제)
    final data = ref.watch(restaurantProvider);

    //잘못된 예외처리이지만, 현재상황으로서의 최선으로 코딩 진행,추후 수정 예정
    if(data.length==0){
      return Center(
       child: CircularProgressIndicator(),
      );
    }

    return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView.separated(
                itemCount: data.length,
                itemBuilder: (_, index) {
                  final pItem = data[index];
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
