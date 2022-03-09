import '../from_submission_status.dart';

class BalanceState {
  final FormSubmissionStatus formStatus;
  final int balance;

  BalanceState({
    required this.balance,
    this.formStatus = const InitialFormStatus(),
  });

  BalanceState copyWith({
    int? balance,
    FormSubmissionStatus? formStatus,
  }) {
    return BalanceState(
      balance: balance ?? this.balance,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}
