part of 'purchases_bloc.dart';

abstract class PurchaseState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PurchaseInitial extends PurchaseState {}

class PurchasesLoaded extends PurchaseState {
  final List<ProductDetails> iapDetails;

  PurchasesLoaded({required this.iapDetails});

  @override
  List<Object?> get props => [iapDetails];
}
