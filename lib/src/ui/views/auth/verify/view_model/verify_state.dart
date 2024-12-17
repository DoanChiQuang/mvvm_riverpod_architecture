import 'package:mvvm_riverpod_architecture/src/utils/helpers/loading_state.dart';

class VerifyState extends LoadingState {
  VerifyState(
    super.state,
    super.error,
    this.isVerified,
  );
  final bool isVerified;
}
