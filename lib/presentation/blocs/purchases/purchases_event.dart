part of 'purchases_bloc.dart';

abstract class PurchaseEvent extends Equatable {
  const PurchaseEvent();

  @override
  List<Object> get props => [];
}

class Initialized extends PurchaseEvent {
  @override
  List<Object> get props => [];
}

class StartPurchase extends PurchaseEvent {
  final PurchaseDetails purchaseDetails;
  const StartPurchase(this.purchaseDetails);

  @override
  List<Object> get props => [purchaseDetails];
}

class PurchaseInvalid extends PurchaseEvent {
  final PurchaseDetails productDetails;

  const PurchaseInvalid(this.productDetails);

  @override
  List<Object> get props => [productDetails];
}

class PurchasePending extends PurchaseEvent {
  final PurchaseDetails productDetails;

  const PurchasePending(this.productDetails);

  @override
  List<Object> get props => [productDetails];
}

class PurchaseValid extends PurchaseEvent {
  final PurchaseDetails productDetails;

  const PurchaseValid(this.productDetails);

  @override
  List<Object> get props => [productDetails];
}

class CompletePurchase extends PurchaseEvent {
  final PurchaseDetails purchaseDetails;

  const CompletePurchase(this.purchaseDetails);

  @override
  List<Object> get props => [purchaseDetails];
}

class ErrorPurchase extends PurchaseEvent {
  final String error;

  const ErrorPurchase(this.error);

  @override
  List<Object> get props => [error];
}
