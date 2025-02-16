import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant/common/model/cursor_pagination_model.dart';
import 'package:restaurant/common/model/model_with_id.dart';
import 'package:restaurant/common/provider/pagination_provider.dart';
import 'package:restaurant/common/utils/pagination_utils.dart';

typedef PaginationWidgetBuilder<T extends IModelWithId> =
Widget Function(BuildContext context, int index, T model);

class PaginationListView<T extends IModelWithId> extends ConsumerStatefulWidget {
  final StateNotifierProvider<PaginationProvider,CursorPaginationBase> provider;
  final PaginationWidgetBuilder<T> itemBuilder;
  const PaginationListView({
    required this.provider,
    required this.itemBuilder,
    super.key});

  @override
  ConsumerState<PaginationListView> createState() => _PaginationListViewState<T>();
}

class _PaginationListViewState<T extends IModelWithId> extends ConsumerState<PaginationListView> {
  final ScrollController controller = ScrollController();

  @override
  void initState() {

    super.initState();
    controller.addListener(listener);
  }

  void listener(){
    PaginationUtils.paginate(
        controller: controller,
        provider: ref.read(widget.provider.notifier)
    );
  }

  @override
  void dispose(){
    controller.removeListener(listener);
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(widget.provider);

//최로 로딩상태
    if(state is CursorPaginationLoading){
      return Center(
        child:CircularProgressIndicator(),
      );
    }

    //에러 상태
    if(state is CursorPaginationError){
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            state.message,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16.0,),
          ElevatedButton(
              onPressed: (){
                ref.read(widget.provider.notifier).paginate(
                  forceRefetch: true
                );
              },
              child: Text("다시시도")
          )
        ],
      );
    }

    //CursorPagination, FetchingMore, Refetching ...
    final cp = state as CursorPagination<T>;

    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child:RefreshIndicator( onRefresh: ()async{
          ref.read(widget.provider.notifier).paginate(
            forceRefetch: true
          );
        },
        child:ListView.separated(
          physics: AlwaysScrollableScrollPhysics(),
          controller: controller,
          itemCount: cp.data.length+1,
          itemBuilder: (_, index) {
            if(index==cp.data.length){
              return Padding(padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                  child: Center(
                      child:cp is CursorPaginationFetchingMore?
                      CircularProgressIndicator():Text("마지막 데이터입니다 ㅠㅠ")
                  ));
            }
            final pItem = cp.data[index];
            return widget.itemBuilder(
              context,
              index,
              pItem
            );
          },

          separatorBuilder: (_, index) {
            return SizedBox(height: 16.0);
          },
        )
    ));
  }
}
