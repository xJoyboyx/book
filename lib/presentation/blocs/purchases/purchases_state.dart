part of 'purchases_bloc.dart';

abstract class PurchaseState extends Equatable {
  const PurchaseState();

  @override
  List<Object> get props => [];
}

class PurchaseInitial extends PurchaseState {}

class PurchaseInProgress extends PurchaseState {}

class PurchaseSuccess extends PurchaseState {
  final Transaction
      transaction; // o cualquier otro dato relevante de la transacción exitosa

  const PurchaseSuccess(this.transaction);

  @override
  List<Object> get props => [transaction];
}

class PurchaseFailure extends PurchaseState {
  final String error;

  const PurchaseFailure(this.error);

  @override
  List<Object> get props => [error];
}
