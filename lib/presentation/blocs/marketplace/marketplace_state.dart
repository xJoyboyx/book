part of 'marketplace_bloc.dart';

abstract class MarketPlaceState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MarketPlaceInitial extends MarketPlaceState {}

class TransactionsLoaded extends MarketPlaceState {
  final List<Transaction> transactions;
  final List<ProductDetails> productDetails;
  TransactionsLoaded(
      {required this.transactions, required this.productDetails});

  @override
  List<Object?> get props => [transactions, productDetails];
}

class LoadingTransactions extends MarketPlaceState {
  @override
  List<Object?> get props => [];
}

class OnTransaction extends MarketPlaceState {
  final Transaction transaction;

  OnTransaction(this.transaction);
  @override
  List<Object?> get props => [transaction];
}
