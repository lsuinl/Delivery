import 'dart:ui';

import 'package:json_annotation/json_annotation.dart';
import 'package:restaurant/common/utils/data_utils.dart';

part 'user_model.g.dart';

abstract class UserModelBase{}

class UserModelLoading extends UserModelBase{}
class UserModelError extends UserModelBase{
  final String message;

  UserModelError({
    required this.message,
});

}

@JsonSerializable()
class UserModel extends UserModelBase{
final String id;
final String username;
@JsonKey(
  fromJson: DataUtils.pathToUrl
)
final String imageUrl;

UserModel({
required this.id,
required this.username,
required this.imageUrl,
});
factory UserModel.fromJson(Map<String,dynamic> json)
=> _$UserModelFromJson(json);
}
//펍빌드워치어쩌고하기~