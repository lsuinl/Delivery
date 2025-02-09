import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant/common/const/colors.dart';
import 'package:restaurant/restaurant/model/restaurant_detail_model.dart';
import 'package:restaurant/user/provider/basket_provider.dart';

class ProductCard extends ConsumerWidget {
  final Image image;
  final String name;
  final String detail;
  final int price;
  final String id;
  final VoidCallback? onSubtract;
  final VoidCallback? onAdd;

  const ProductCard(
      {required this.image,
      required this.name,
      required this.detail,
      required this.price,
        required this.id,
      this.onSubtract,
      this.onAdd,
      Key? key})
      : super(key: key);

  factory ProductCard.fromProductModel({
    required RestaurantProductModel model,
    VoidCallback? onSubtract,
    VoidCallback? onAdd,
  }) {
    return ProductCard(
      id:model.id,
      image: Image.asset(
        model.imgUrl,
        width: 110,
        height: 110,
        fit: BoxFit.cover,
      ),
      name: model.name,
      detail: model.detail,
      price: model.price,
      onSubtract: onSubtract,
      onAdd: onAdd,
    );
  }

  factory ProductCard.fromRestaurantProductModel({
    required RestaurantProductModel model,
    VoidCallback? onSubtract,
    VoidCallback? onAdd,
  }) {
    return ProductCard(
        id:model.id,
        image: Image.asset(
          model.imgUrl,
          width: 110,
          height: 110,
          fit: BoxFit.cover,
        ),
        name: model.name,
        detail: model.detail,
        price: model.price,
      onSubtract: onSubtract,
      onAdd: onAdd
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final basket = ref.watch(basketProvider);

    return Column(children: [
      IntrinsicHeight(
        //********
        child: Row(
          children: [
            ClipRRect(borderRadius: BorderRadius.circular(8), child: image),
            SizedBox(width: 16),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  name,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                Text(
                  detail,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: BODY_TEXT_COLOR, fontSize: 14),
                ),
                Text(
                  price.toString(),
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      color: PRIMARY_COLOR,
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                )
              ],
            ))
          ],
        ),
      ),
      if (onSubtract != null && onAdd != null)
        _Footer(
            total:  (basket.firstWhere((e)=>e.product.id==id).count * basket.firstWhere((e)=>e.product.id==id).product.price).toString(),
            count: basket.firstWhere((e)=>e.product.id==id).count,
            onSubtract: onSubtract!,
            onAdd: onAdd!)
    ]);
  }
}

class _Footer extends StatelessWidget {
  final String total;
  final int count;
  final VoidCallback onSubtract;
  final VoidCallback onAdd;

  const _Footer(
      {required this.total,
      required this.count,
      required this.onSubtract,
      required this.onAdd,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '총액 $total',
          style: TextStyle(color: PRIMARY_COLOR, fontWeight: FontWeight.w500),
        ),
        Row(
          children: [
            renderButton(icon: Icons.remove, onTap: onSubtract),
            Text(
              count.toString(),
              style:
                  TextStyle(color: PRIMARY_COLOR, fontWeight: FontWeight.w500),
            ),
            renderButton(icon: Icons.add, onTap: onAdd),
          ],
        )
      ],
    );
  }

  Widget renderButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: PRIMARY_COLOR, width: 1)),
        child: InkWell(
          onTap: onTap,
          child: Icon(
            icon,
            color: PRIMARY_COLOR,
          ),
        ));
  }
}
