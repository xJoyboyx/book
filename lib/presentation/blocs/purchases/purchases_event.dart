part of 'purchases_bloc.dart';

abstract class PurchaseEvent extends Equatable {
  const PurchaseEvent();

  @override
  List<Object> get props => [];
}

class StartPurchase extends PurchaseEvent {
  final String
      productId; // o cualquier otro dato necesario para iniciar la compra

  const StartPurchase(this.productId);

  @override
  List<Object> get props => [productId];
}

class CompletePurchase extends PurchaseEvent {
  final String
      transactionId; // o cualquier otro dato necesario para completar la compra

  const CompletePurchase(this.transactionId);

  @override
  List<Object> get props => [transactionId];
}

class ErrorPurchase extends PurchaseEvent {
  final String error;

  const ErrorPurchase(this.error);

  @override
  List<Object> get props => [error];
}
