import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:book/data/models/transaction.dart';
import 'package:book/domain/usecases/transactions/transactions_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'marketplace_event.dart';
part 'marketplace_state.dart';

class MarketPlaceBloc extends Bloc<MarketplaceEvent, MarketPlaceState> {
  final TransactionsUseCase transactionsUseCase;
  final List<ProductDetails> iapDetails;
  final SharedPreferences sharedPreferences;

  MarketPlaceBloc(
      {required this.iapDetails,
      required this.transactionsUseCase,
      required this.sharedPreferences})
      : super(MarketPlaceInitial()) {
    on<LoadPurchases>(_onLoadPurchases);
    on<SaveTransaction>(_onSaveTransaction);
    on<StartTransaction>(_onStartTransaction);
  }

  Future<void> _onLoadPurchases(
      LoadPurchases event, Emitter<MarketPlaceState> emit) async {
    emit(LoadingTransactions());
    String? user_id = await sharedPreferences.getString('userId');

    if (user_id != null) {
      final List<Transaction> transactions =
          await transactionsUseCase.getTransactions(user_id);
      emit(TransactionsLoaded(
          transactions: transactions, productDetails: iapDetails));
    } else {
      emit(TransactionsLoaded(
          transactions: List<Transaction>.empty(), productDetails: iapDetails));
    }
  }

  Future<void> _onStartTransaction(
      StartTransaction event, Emitter<MarketPlaceState> emit) async {
    emit(OnTransaction(event.transaction));
  }

  Future<void> _onSaveTransaction(
      SaveTransaction event, Emitter<MarketPlaceState> emit) async {
    emit(LoadingTransactions());
    String? user_id = await sharedPreferences.getString('userId');
    Transaction transaction = event.transaction;
    if (user_id != null) {
      transaction.userId = user_id;
      await transactionsUseCase.postTransaction(transaction);

      add(LoadPurchases());
    }
  }
}
