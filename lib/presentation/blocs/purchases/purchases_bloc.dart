import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'purchases_event.dart';
part 'purchases_state.dart';

class PurchaseBloc extends Bloc<PurchaseEvent, PurchaseState> {
  PurchaseBloc() : super(PurchaseInitial()) {
    on<StartPurchase>(_onStartPurchase);
    on<CompletePurchase>(_onCompletePurchase);
    on<ErrorPurchase>(_onErrorPurchase);
  }

  Future<void> _onStartPurchase(
      StartPurchase event, Emitter<PurchaseState> emit) async {
    emit(PurchaseInProgress());
    // Aquí, puedes iniciar el proceso de compra
  }

  Future<void> _onCompletePurchase(
      CompletePurchase event, Emitter<PurchaseState> emit) async {
    emit(PurchaseSuccess(event.transactionId));
  }

  Future<void> _onErrorPurchase(
      ErrorPurchase event, Emitter<PurchaseState> emit) async {
    emit(PurchaseFailure(event.error));
  }
}
