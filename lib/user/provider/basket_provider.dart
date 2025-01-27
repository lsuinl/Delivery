import 'package:restaurant/product/model/product_model.dart';
import 'package:restaurant/rating/component/rating_card.dart';
import 'package:restaurant/user/model/basket_item_model.dart';
import 'package:riverpod/riverpod.dart';
import 'package:collection/collection.dart';

final basketProvider = StateNotifierProvider<BasketProvider, List<BasketItemModel>>(
(ref){
  return BasketProvider();
  }
);

class BasketProvider extends StateNotifier<List<BasketItemModel>> {
  BasketProvider() : super([]);

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
  }
}
