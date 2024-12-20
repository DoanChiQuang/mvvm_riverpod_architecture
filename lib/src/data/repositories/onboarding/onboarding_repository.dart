import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'onboarding_repository.g.dart';

@Riverpod(keepAlive: true)
Future<OnboardingRepository> onboardingRepository(Ref ref) async {
  final sharedPreferences = await SharedPreferences.getInstance();
  return OnboardingRepository(sharedPreferences: sharedPreferences);
}

class OnboardingRepository {
  OnboardingRepository({
    required SharedPreferences sharedPreferences,
  }) : _sharedPreferences = sharedPreferences;

  final SharedPreferences _sharedPreferences;

  static const onboardingCompleteKey = 'onboardingComplete';

  Future<void> setOnboardingComplete() async =>
      await _sharedPreferences.setBool(onboardingCompleteKey, true);

  bool isOnboardingComplete() =>
      _sharedPreferences.getBool(onboardingCompleteKey) ?? false;
}
