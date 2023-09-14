part of 'purchases_bloc.dart';

abstract class PurchaseEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadPurchases extends PurchaseEvent {}
