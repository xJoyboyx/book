import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

part 'purchases_event.dart';
part 'purchases_state.dart';

class PurchaseBloc extends Bloc<PurchaseEvent, PurchaseState> {
  final List<ProductDetails> iapDetails;

  PurchaseBloc({required this.iapDetails}) : super(PurchaseInitial()) {
    on<LoadPurchases>(_onLoadPurchases);
    add(LoadPurchases());
  }

  Future<void> _onLoadPurchases(
      LoadPurchases event, Emitter<PurchaseState> emit) async {
    emit(PurchasesLoaded(iapDetails: iapDetails));
  }
}
