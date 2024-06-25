//왜안되는거딩
//flutter pub run build_runner watch
import 'package:json_annotation/json_annotation.dart';
import '../../restaurant/model/restaurant_model.dart';

part 'cursor_pagination_model.g.dart';

//상속했기 때문에 반환하면 이 타입이 나온다는 점이 중요.(OOP)
abstract class CursorPaginationBase{}

//문제 발생시 에러 메세지
class CursorPaginationError extends CursorPaginationBase{
  final String message;

  CursorPaginationError({
    required this.message,
  });
}

//로딩중. 데이터가 이 타입이라는 것만 있어도 로딩중임을 알 수 있음
//따라서 딱히 데이터를 넣는 등의 작업 필요 x
class CursorPaginationLoading extends CursorPaginationBase{}

@JsonSerializable(
  genericArgumentFactories: true //제너릭을 고려한 코드를 생성할 수 있도록 함.
)
class CursorPagination<T> extends CursorPaginationBase{
  final CursorPaginationMeta meta;
  final List<T> data;

  CursorPagination({
    required this.meta,
    required this.data
});

  CursorPagination copyWith({
     CursorPaginationMeta? meta,
     List<T>? data,
}){
    return CursorPagination(
      meta: meta??this.meta,
      data: data?? this.data,
    );
  }

  factory CursorPagination.fromJson(Map<String, dynamic> json, T Function(Object? json) fromJsonT)=>
      _$CursorPaginationFromJson(json,fromJsonT);

}

@JsonSerializable()
class CursorPaginationMeta{
  final int count;
  final bool hasMore;

  CursorPaginationMeta({
    required this.count,
    required this.hasMore,
});

  CursorPaginationMeta copyWith({
     int? count,
     bool? hasMore,
}){
    return CursorPaginationMeta(
      count: count??this.count,
      hasMore: hasMore??this.hasMore,
    );
  }

  factory CursorPaginationMeta.fromJson(Map<String, dynamic> json)=>
      _$CursorPaginationMetaFromJson(json);

}

//새로고침기능(이미 데이터가 있는 상태에서 새로고침을 하기 때문에
//아까와 같은 Base대신 CursorPagination을 extends함
//물론 CursorPagination도 base를 extend하기때문에 둘다 만족함!
class CursorPaginationRefetching<T> extends CursorPagination<T> {
  CursorPaginationRefetching({
    required super.meta,
    required super.data,
  });
}

//리스트의 맨 아래로 내려서, 추가 데이터 요청
class CursorPaginationFetchingMore<T> extends CursorPagination<T>{
  CursorPaginationFetchingMore({
    required super.meta,
    required super.data,
  });
}