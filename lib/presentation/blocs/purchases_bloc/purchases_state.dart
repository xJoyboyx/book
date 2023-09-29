part of 'purchases_bloc.dart';

abstract class PurchaseState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PurchaseInitial extends PurchaseState {}

class PurchasesLoaded extends PurchaseState {
  final List<Transaction> transactions;

  PurchasesLoaded({required this.transactions});

  @override
  List<Object?> get props => [transactions];
}
