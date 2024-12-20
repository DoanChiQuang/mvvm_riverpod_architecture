import 'package:mvvm_riverpod_architecture/src/data/repositories/onboarding/onboarding_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'onboarding_viewmodel.g.dart';

@riverpod
class OnboardingViewModel extends _$OnboardingViewModel {
  late OnboardingRepository _onboardingRepository;

  @override
  Future<void> build() async {
    _onboardingRepository = ref.read(onboardingRepositoryProvider).requireValue;
  }

  Future<void> completeOnboarding() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_onboardingRepository.setOnboardingComplete);
  }
}
