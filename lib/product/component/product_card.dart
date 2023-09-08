import 'dart:html';

import 'package:flutter/material.dart';
import 'package:restaurant/common/const/colors.dart';
import 'package:restaurant/restaurant/model/restaurant_detail_model.dart';

class ProductCard extends StatelessWidget {
  final Image image;
  final String name;
  final String detail;
  final int price;

  const ProductCard({
    required this.image,
    required this.name,
    required this.detail,
    required this.price,
    Key? key}) : super(key: key);

  factory ProductCard.fromModel({
    required RestaurantProductModel model,
}){
    return ProductCard(image: Image.asset(
      model.imgUrl,
      width: 110,
      height: 110,
      fit: BoxFit.cover,
    ), name: model.name, detail: model.detail, price: model.price);
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight( //********
     child:  Row(
       children: [
         ClipRRect(
           borderRadius:BorderRadius.circular(8),
           child:image),
         SizedBox(width: 16),
         Expanded(
             child: Column(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               crossAxisAlignment: CrossAxisAlignment.stretch,
               children: [
                 Text(name,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                 Text(detail,maxLines: 2,overflow: TextOverflow.ellipsis, style: TextStyle(color: BODY_TEXT_COLOR,fontSize: 14),),
                 Text(price.toString(),textAlign: TextAlign.right, style: TextStyle(color:PRIMARY_COLOR,fontSize: 12,fontWeight: FontWeight.w500),)
               ],
             )
         )
       ],
     ),
    );
  }
}
