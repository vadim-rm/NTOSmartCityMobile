abstract class BalanceEvent {}

class BalanceChanged extends BalanceEvent {
  final int balance;

  BalanceChanged({required this.balance});
}

class FormSubmitted extends BalanceEvent {}
