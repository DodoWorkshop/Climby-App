import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'authentication.freezed.dart';

@freezed
class Authentication with _$Authentication {
  const factory Authentication({
    required UserProfile profile,
    required String jwt,
  }) = _Authentication;
}
