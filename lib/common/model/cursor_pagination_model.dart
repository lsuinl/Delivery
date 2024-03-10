//왜안되는거딩
//flutter pub run build_runner watch
import 'package:json_annotation/json_annotation.dart';
import '../../restaurant/model/restaurant_model.dart';

part 'cursor_pagination_model.g.dart';

@JsonSerializable(
  genericArgumentFactories: true //제너릭을 고려한 코드를 생성할 수 있도록 함.
)
class CursorPagination<T>{
  final CursorPaginationMeta meta;
  final List<T> data;

  CursorPagination({
    required this.meta,
    required this.data
});
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

  factory CursorPaginationMeta.fromJson(Map<String, dynamic> json)=>
      _$CursorPaginationMetaFromJson(json);

}