import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant/common/const/colors.dart';
import 'package:restaurant/common/layout/default_layout.dart';
import 'package:restaurant/product/component/product_card.dart';
import 'package:restaurant/user/provider/basket_provider.dart';

class BasketScreen extends ConsumerWidget {
  static String get routeName => 'basket';

  const BasketScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final basket = ref.watch(basketProvider);
    final productTotal = basket.fold<int>(
      0,
      (p, n) => p + (n.product.price * n.count),
    );
    final deliveryFee = basket.first.product.restaurant.deliveryFee;

    if(basket.isEmpty)
      return DefaultLayout(
        title: '장바구니',
        child: Center(
          child: Text('장바구니가 비어있습니다')
        ),
      );

    return DefaultLayout(
        title: '장바구니',
        child: SafeArea(
            bottom: true,
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Expanded(
                        child: ListView.separated(
                      separatorBuilder: (_, index) {
                        return Divider(height: 32);
                      },
                      itemBuilder: (_, index) {
                        final model = basket[index];

                        return ProductCard.fromProductModel(
                          model: model.product,
                          onAdd: () {
                            ref
                                .read(basketProvider.notifier)
                                .addToBasket(product: model.product);
                          },
                          onSubtract: () {
                            ref
                                .read(basketProvider.notifier)
                                .remodeFromBasket(product: model.product);
                          },
                        );
                      },
                      itemCount: basket.length,
                    )),
                    Column(
                      children: [
                        Row(children: [
                          Text('장바구니 금액',
                              style: TextStyle(color: BODY_TEXT_COLOR)),
                          Text(productTotal.toString())
                        ]),
                        Row(children: [
                          Text(
                            '배달비',
                            style: TextStyle(color: BODY_TEXT_COLOR),
                          ),
                          if (basket.length > 0)
                            Text(deliveryFee
                                .toString())
                        ]),
                        Row(children: [
                          Text(
                            '총액',
                            style: TextStyle(
                                color: BODY_TEXT_COLOR,
                                fontWeight: FontWeight.w500),
                          ),
                          Text((deliveryFee+productTotal
                          ).toString())
                        ]),
                        SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                    foregroundColor: PRIMARY_COLOR),
                                child: Text('결제하기')))
                      ],
                    )
                  ],
                ))));
  }
}
