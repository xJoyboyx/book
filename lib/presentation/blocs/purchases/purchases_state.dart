part of 'purchases_bloc.dart';

abstract class PurchaseState extends Equatable {
  const PurchaseState();

  @override
  List<Object> get props => [];
}

class PurchaseInitial extends PurchaseState {}

class PurchaseInProgress extends PurchaseState {}

class PurchaseSuccess extends PurchaseState {
  final PurchaseDetails
      purchase; // o cualquier otro dato relevante de la transacción exitosa

  const PurchaseSuccess(this.purchase);

  @override
  List<Object> get props => [purchase];
}

class RestoringPurchase extends PurchaseState {
  final PurchaseDetails purchase;

  const RestoringPurchase(this.purchase);

  @override
  List<Object> get props => [purchase];
}

class PurchaseFailure extends PurchaseState {
  final String error;

  const PurchaseFailure(this.error);

  @override
  List<Object> get props => [error];
}
