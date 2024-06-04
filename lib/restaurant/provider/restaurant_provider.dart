import 'package:restaurant/restaurant/model/restaurant_model.dart';
import 'package:restaurant/restaurant/model/restaurant_model.dart';
import 'package:restaurant/restaurant/repository/restaurant_respository.dart';
import 'package:riverpod/riverpod.dart';

final restaurantProvider = StateNotifierProvider
<RestaurantStateNotifier, List<RestaurantModel>>(
    (ref){
      final repository = ref.watch(restaurantRepositoryProvider);

      final notifier = RestaurantStateNotifier(repository:repository);

      return notifier;
    }
)
class RestaurantStateNotifier extends StateNotifier<List<RestaurantModel>>{
  final RestaurantRepository repository;

  RestaurantStateNotifier({
    required this.repository,
  }): super([]){
    paginate();
  }


  //페이지네이트:상태변경시 새로운 값을 업데이트하여 보여줌
  paginate() async {
    final resp = await repository.paginate();

    state = resp.data;
  }
}
