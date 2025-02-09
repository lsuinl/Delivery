import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant/common/layout/default_layout.dart';

class BasketScreen extends ConsumerWidget {
  static String get routeName =>'basket';

  const BasketScreen({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {

    return DefaultLayout(
      title: '장바구니',
      child: Column(

      )
    );
  }
}
