import 'package:flutter/material.dart';
import 'package:restaurant/common/const/colors.dart';

import '../model/order_model.dart';

class OrderCard extends StatelessWidget {
  final DateTime orderDate;
  final Image image;
  final String name;
  final String productsDetail;
  final int price;

  const OrderCard({
    required this.orderDate,
    required this.image,
    required this.name,
    required this.productsDetail,
    required this.price,
    super.key});

  factory OrderCard.fromModel({
    required OrderModel model,
  }){
    final productDetail = model.products.length<2? model.products.first.product.name: '${model.products.first.product.name} 외 ${model.products.length-1}개';
    return OrderCard(orderDate: model.createdAt,
        image: Image.network(
          model.restaurant.thumbUrl,
          height: 50,
          width: 50,
          fit: BoxFit.cover ,
        ),
        name: model.restaurant.name,
        productsDetail: productDetail,
        price: model.totalPrice);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('${orderDate.year}.${orderDate.month.toString().padLeft(
            2, '0')}.${orderDate.day.toString().padLeft(2, '0')} '),
        const SizedBox(height: 8,),
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: image,
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: TextStyle(
                        fontSize: 14
                    )),
                Text('$productsDetail $price원',
                  style: TextStyle(
                      color: BODY_TEXT_COLOR,
                      fontWeight: FontWeight.w300
                  ),)
              ],
            )
          ],
        )
      ],
    );
  }
}
