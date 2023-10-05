import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:book/data/models/transaction.dart';
import 'package:book/data/services/transactions_service.dart';
import 'package:equatable/equatable.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

part 'purchases_event.dart';
part 'purchases_state.dart';

class PurchaseBloc extends Bloc<PurchaseEvent, PurchaseState> {
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  late StreamSubscription _purchaseSubscription;

  PurchaseBloc() : super(PurchaseInitial()) {
    _purchaseSubscription =
        _inAppPurchase.purchaseStream.listen(_onPurchaseUpdated);

    on<StartPurchase>(_onStartPurchase);
    on<CompletePurchase>(_onCompletePurchase);
    on<ErrorPurchase>(_onErrorPurchase);
    on<PurchaseValid>(_onPurchaseValid);
    on<Initialized>(_onInitialized);
    on<RestorePurchase>(_onRestorePurchase);
  }
  void _onRestorePurchase(RestorePurchase event, Emitter<PurchaseState> emit) {
    emit(RestoringPurchase(event.purchaseDetails));
  }

  void _onInitialized(Initialized event, Emitter<PurchaseState> emit) {
    emit(PurchaseInitial());
  }

  void _onPurchaseValid(PurchaseValid event, Emitter<PurchaseState> emit) {}
  void _onPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
      print('📺📺📺📺 status: ${purchaseDetails.status}');
      if (purchaseDetails.status == PurchaseStatus.pending) {
        print('📟 starting ...');
        add(StartPurchase(purchaseDetails));
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          print('❌ error purchasing ...');
          add(ErrorPurchase(purchaseDetails.error!.message!));
        } else if (purchaseDetails.status == PurchaseStatus.purchased ||
            purchaseDetails.status == PurchaseStatus.restored) {
          if (purchaseDetails.status == PurchaseStatus.restored) {
            print('💀💀💀 restoring purchase of ${purchaseDetails.productID}');

            add(RestorePurchase(purchaseDetails));
          } else {
            await InAppPurchase.instance.completePurchase(purchaseDetails);

            print('❎ pago completado ...');

            bool valid = true;
            if (valid) {
              add(CompletePurchase(purchaseDetails));
            } else {
              add(PurchaseInvalid(
                  purchaseDetails)); // Y un evento PurchaseInvalid
            }
          }
        }
        if (purchaseDetails.pendingCompletePurchase) {
          await InAppPurchase.instance.completePurchase(purchaseDetails);
        }
      }
    });
  }

  Future<void> _onStartPurchase(
      StartPurchase event, Emitter<PurchaseState> emit) async {
    emit(PurchaseInProgress());
    // Aquí, puedes iniciar el proceso de compra
  }

  Future<void> _onCompletePurchase(
      CompletePurchase event, Emitter<PurchaseState> emit) async {
    emit(PurchaseSuccess(event.purchaseDetails));
  }

  Future<void> _onErrorPurchase(
      ErrorPurchase event, Emitter<PurchaseState> emit) async {
    emit(PurchaseFailure(event.error));
  }

  @override
  Future<void> close() {
    _purchaseSubscription.cancel();
    return super.close();
  }
}
