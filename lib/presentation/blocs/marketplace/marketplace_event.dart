part of 'marketplace_bloc.dart';

abstract class MarketplaceEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadPurchases extends MarketplaceEvent {
  @override
  List<Object?> get props => [];
}

class SaveTransaction extends MarketplaceEvent {
  final Transaction transaction;

  SaveTransaction(this.transaction);

  @override
  List<Object?> get props => [transaction];
}

class RestoreTransaction extends MarketplaceEvent {
  final Transaction transaction;

  RestoreTransaction(this.transaction);

  @override
  List<Object?> get props => [transaction];
}

class StartTransaction extends MarketplaceEvent {
  final Transaction transaction;

  StartTransaction(this.transaction);

  @override
  List<Object?> get props => [transaction];
}
