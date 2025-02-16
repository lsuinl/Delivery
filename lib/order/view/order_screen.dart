import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:restaurant/common/component/pagination_list_view.dart';
import 'package:restaurant/order/component/order_card.dart';
import 'package:restaurant/order/model/order_model.dart';
import 'package:restaurant/order/provider/order_provider.dart';

class OrderScreen extends ConsumerWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PaginationListView<OrderModel>(
      provider: OrderProvider,
      itemBuilder: <OrderModel>(_,index, model){
        return OrderCard.fromModel(model: model);
      },
    );
  }
}
