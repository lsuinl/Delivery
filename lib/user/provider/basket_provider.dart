import 'package:debounce_throttle/debounce_throttle.dart';
import 'package:restaurant/product/model/product_model.dart';
import 'package:restaurant/rating/component/rating_card.dart';
import 'package:restaurant/user/model/basket_item_model.dart';
import 'package:restaurant/user/model/patch_basket_body.dart';
import 'package:restaurant/user/repository/user_me_repository.dart';
import 'package:riverpod/riverpod.dart';
import 'package:collection/collection.dart';

final basketProvider = StateNotifierProvider<BasketProvider, List<BasketItemModel>>(
(ref){
  final repository = ref.watch(userMeRepositoryProvider);

  return BasketProvider(repository: repository);
  }
);

class BasketProvider extends StateNotifier<List<BasketItemModel>> {
  final UserMeRepository repository;
  final updateBasketDebounce = Debouncer(Duration(seconds: 1), initialValue: null, checkEquality: false);

  BasketProvider({
    required this.repository,
}) : super([]){
    updateBasketDebounce.values.listen((event){
      patchBasket();
    });
  }

  Future<void> patchBasket() async {
    await repository.patchBasket(body:
      PatchBasketBody(
          basket: state.map((e)=>
          PatchBasketBodyBasket(productId: e.product.id, count: e.count)
          ).toList()
      )
    );
  }

  Future<void> addToBasket({required ProductModel product}) async {
    final exists =
        state.firstWhereOrNull((e) => e.product.id == product.id) != null;

    if(exists){
      state = state.map(
          (e)=> e.product.id == product.id ?
          e.copyWith(count: e.count+1) :e).toList();
    }
    else{
      state = [
        ...state,
        BasketItemModel(product: product, count:1)
      ];
    }

    updateBasketDebounce.setValue(null);
  }

  Future<void> remodeFromBasket({
    required ProductModel product,
    bool isDelete = false,
  }) async{
    final exists =  state.firstWhereOrNull((e) => e.product.id == product.id) != null;

    if(exists==null)
      return;

    final existingProduct = state.firstWhere((e)=> e.product.id==product.id);

    if(existingProduct.count==1 || isDelete){
      state = state.where(
              (e)=> e.product.id != product.id ).toList();
    }
    else{
      state = state.map((e)=>
          e.product.id ==product.id?
              e.copyWith(count: e.count-1):e
      ).toList();
    }
    updateBasketDebounce.setValue(null);
  }

}
