import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    String? uid,
    String? email,
    bool? emailVerified,
    String? displayName,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, Object?> json) =>
      _$UserModelFromJson(json);

  factory UserModel.fromUser(User? user) => UserModel(
        uid: user?.uid,
        email: user?.email,
        emailVerified: user?.emailVerified,
        displayName: user?.displayName,
      );
}
