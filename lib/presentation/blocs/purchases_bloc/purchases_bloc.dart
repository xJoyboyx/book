import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:book/data/models/transaction.dart';
import 'package:book/domain/usecases/transactions/transactions_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'purchases_event.dart';
part 'purchases_state.dart';

class PurchaseBloc extends Bloc<PurchaseEvent, PurchaseState> {
  final TransactionsUseCase transactionsUseCase;
  final List<ProductDetails> iapDetails;
  final SharedPreferences sharedPreferences;

  PurchaseBloc(
      {required this.iapDetails,
      required this.transactionsUseCase,
      required this.sharedPreferences})
      : super(PurchaseInitial()) {
    on<LoadPurchases>(_onLoadPurchases);
  }

  Future<void> _onLoadPurchases(
      LoadPurchases event, Emitter<PurchaseState> emit) async {
    String? user_id = await sharedPreferences.getString('userId');
    if (user_id != null) {
      final List<Transaction> transactions =
          await transactionsUseCase.getTransactions(user_id);
      print('🔥🔥🔥 transactions ${transactions.length}');
      emit(PurchasesLoaded(transactions: transactions));
    } else {
      emit(PurchasesLoaded(transactions: List<Transaction>.empty()));
    }
  }
}
