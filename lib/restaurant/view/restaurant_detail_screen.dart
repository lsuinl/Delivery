import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant/common/layout/default_layout.dart';
import 'package:restaurant/product/component/product_card.dart';
import 'package:restaurant/restaurant/component/restaurant_card.dart';
import 'package:restaurant/restaurant/model/restaurant_detail_model.dart';
import 'package:restaurant/restaurant/model/restaurant_model.dart';
import 'package:restaurant/restaurant/provider/restaurant_provider.dart';
import 'package:restaurant/restaurant/repository/restaurant_respository.dart';
import 'package:skeletons/skeletons.dart';


class RestaurantDetailScreen extends ConsumerStatefulWidget {
  final String id;

  const RestaurantDetailScreen({required this.id,super.key});

  @override
  ConsumerState<RestaurantDetailScreen> createState() => _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState extends ConsumerState<RestaurantDetailScreen> {

  @override
  void initstate(){
    super.initState();
    ref.read(restaurantProvider.notifier).getDetail(id:widget.id);
  }

  @override
Widget build(BuildContext context){
    final state = ref.watch(restaurantDetailProvider(widget.id));
    if(state==null){
      return DefaultLayout(child: Center(child:CircularProgressIndicator()));
    }
    return DefaultLayout(
        title: "불타는 떡볶이",
        child: CustomScrollView(
          slivers: [
            renderTop(model: state),
            if(state is! RestaurantDetailModel)renderLoading(),
            if(state is RestaurantDetailModel)renderLabel(),
            if(state is RestaurantDetailModel)renderProduct(products: state.products)
          ],
        )
            );
  }

  SliverPadding renderLoading(){
    return SliverPadding(padding: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
        sliver:  SliverList(
        delegate: SliverChildListDelegate(
        List.generate(
          3,
        (index)=>
            Padding(padding: EdgeInsets.only(bottom:32),
            child:
            SkeletonParagraph(
        style: SkeletonParagraphStyle(
        lines:5,
        padding: EdgeInsets.zero,
        ))))
    ),
    ),
    );
  }

  SliverPadding renderLabel() {
    return SliverPadding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        sliver: SliverToBoxAdapter(
          child: Text(
            "메뉴",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ));
  }

  SliverPadding renderProduct({
    required List<RestaurantProductModel> products,
}) {
    return SliverPadding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
          (context, index) {
            final model =products[index];
            return Padding(
              padding: EdgeInsets.only(top: 16),
              child: ProductCard.fromModel(model: model),
            );
          },
          childCount: products.length,
        )));
  }

  SliverToBoxAdapter renderTop({
    required RestaurantModel model,
  }) {
    return SliverToBoxAdapter(
      child: RestaurantCard.fromModel(
        model: model,
        isDetail: true,
      ),
    );
  }
}
