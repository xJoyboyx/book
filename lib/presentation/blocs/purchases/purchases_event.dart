part of 'purchases_bloc.dart';

abstract class PurchaseEvent extends Equatable {
  const PurchaseEvent();

  @override
  List<Object> get props => [];
}

class StartPurchase extends PurchaseEvent {
  final ProductDetails productDetails;

  const StartPurchase(this.productDetails);

  @override
  List<Object> get props => [productDetails];
}

class CompletePurchase extends PurchaseEvent {
  final Transaction transaction;

  const CompletePurchase(this.transaction);

  @override
  List<Object> get props => [transaction];
}

class ErrorPurchase extends PurchaseEvent {
  final String error;

  const ErrorPurchase(this.error);

  @override
  List<Object> get props => [error];
}
