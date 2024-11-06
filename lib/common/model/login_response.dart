
import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse{
  final String refreshToken;
  final String accessToken;

  LoginResponse({
    required this.accessToken,
    required this.refreshToken,
});

  factory LoginResponse.fromJson(Map<String, dynamic> json)
  => _$LoginResponseFromJson(json);
}