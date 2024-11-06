
import 'package:json_annotation/json_annotation.dart';

part 'token_response.g.dart';

@JsonSerializable()
class TokenResponse{
  final String refreshToken;

  TokenResponse({
    required this.refreshToken,
  });

  factory TokenResponse.fromJson(Map<String, dynamic> json)
  => _$TokenResponseFromJson(json);
}