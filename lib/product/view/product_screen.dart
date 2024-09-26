import 'package:flutter/material.dart';
import 'package:restaurant/common/component/pagination_list_view.dart';
import 'package:restaurant/product/component/product_card.dart';
import 'package:restaurant/product/model/product_model.dart';
import 'package:restaurant/product/provider/product_provider.dart';


class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PaginationListView<ProductModel>  (
      provider: productProvider,
      itemBuilder: <ProductModel>(_,index,model){
        return ProductCard.fromProductModel(model: model);
      },
    );
  }
}

