import 'package:json_annotation/json_annotation.dart';

part 'pagination_params.g.dart';

@JsonSerializable()
class PaginationParams{
  final String? after;
  final int? count;

  PaginationParams({
    this.after,
    this.count,
});

  //특정값만 바꾸고 싶을때 활용
  PaginationParams copyWith({
    String? after,
    int? count,
}){
    return PaginationParams(
      after: after ?? this.after,
      count: count?? this.count,
    );
  }

  factory PaginationParams.fromJson(Map<String,dynamic> json)
  => _$PaginationParamsFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationParamsToJson(this);
}