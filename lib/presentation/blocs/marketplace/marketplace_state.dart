part of 'marketplace_bloc.dart';

abstract class PurchaseState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PurchaseInitial extends PurchaseState {}

class PurchasesLoaded extends PurchaseState {
  final List<Transaction> transactions;
  final List<ProductDetails> productDetails;
  PurchasesLoaded({required this.transactions, required this.productDetails});

  @override
  List<Object?> get props => [transactions, productDetails];
}
