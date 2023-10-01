import 'dart:io';

import 'package:book/data/models/transaction.dart';
import 'package:book/presentation/blocs/marketplace/marketplace_bloc.dart';
import 'package:book/presentation/blocs/purchases/purchases_bloc.dart';
import 'package:book/presentation/blocs/theme/theme_bloc.dart';
import 'package:book/presentation/pages/settings/themes/themes_bottom_sheet.dart';
import 'package:book/presentation/widgets/media-widgets/image_builder.dart';
import 'package:book/themes/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class ThemeSelection extends StatelessWidget {
  const ThemeSelection({
    super.key,
    required this.widget,
  });

  final ThemesBottomSheet widget;

  @override
  Widget build(BuildContext context) {
    final marketPlaceStates = context.watch<MarketPlaceBloc>().state;
    final purchasesStates = context.watch<PurchaseBloc>().state;
    if (purchasesStates is PurchasePending ||
        marketPlaceStates is LoadingTransactions ||
        purchasesStates is PurchaseInProgress) {
      return Container(
          height: .4.sh, child: Center(child: CircularProgressIndicator()));
    } else if (purchasesStates is PurchaseSuccess) {
      print('Purchase success state active');

      if (marketPlaceStates is OnTransaction) {
        Transaction t = marketPlaceStates.transaction;

        int timestamp = int.parse(purchasesStates.purchase.transactionDate!);
        print('💼💼💼 timestamp date: ${timestamp}');

        DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp);

        print('🐶🐶 transaction date: ${date}');
        t.date = date;
        t.description = purchasesStates.purchase.purchaseID;
        context.read<PurchaseBloc>().add(Initialized());

        context.read<MarketPlaceBloc>().add(SaveTransaction(t));
      }
      return CircularProgressIndicator();
    } else {
      return Container(
        height: 1.sh,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: AppThemes.themeIds.length,
          itemBuilder: (context, index) {
            final themeId = AppThemes.themeIds[index];
            final themeData = AppThemes.getThemeById(index);
            final isCurrentTheme = widget.themeState.themeData == themeData;
            ProductDetails? productDetails;
            bool isPurchased = false;

            if (marketPlaceStates is TransactionsLoaded) {
              for (Transaction t in marketPlaceStates.transactions) {
                if (t.productId == themeId) {
                  isPurchased = true;
                }
              }
              try {
                productDetails = marketPlaceStates.productDetails
                    .firstWhere((product) => product.id == themeId);
              } catch (e) {
                print('Error al buscar ProductDetails: $e');
              }
            }

            if (index == 0) {
              isPurchased = true;
            }
            return Padding(
              padding: EdgeInsets.only(top: .02.sh),
              child: GestureDetector(
                onTap: () {
                  if (isPurchased) {
                    print('Changing to purchased theme: ${themeId}');
                    context.read<ThemeBloc>().add(ThemeChanged(themeId: index));
                  } else {
                    //TODO Implement restore purchases
                    if (productDetails != null) {
                      final PurchaseParam purchaseParam = PurchaseParam(
                        productDetails: productDetails!,
                        applicationUserName: null,
                      );
                      final transaction = Transaction(
                        amount: productDetails.rawPrice,
                        currency: productDetails.currencyCode,
                        type: 'purchase',
                        productId: productDetails.id,
                        platform: Platform.isAndroid ? 'android' : 'ios',
                      );
                      context
                          .read<MarketPlaceBloc>()
                          .add(StartTransaction(transaction));
                      InAppPurchase.instance
                          .buyNonConsumable(purchaseParam: purchaseParam);
                    }
                  }
                },
                child: Column(
                  children: [
                    ImageBuilder(
                      imageName: 'theme',
                      themeId: (index + 1).toString(),
                      width: 1.sw,
                    ),
                    SizedBox(height: .01.sh),
                    Text(
                      widget.translations!
                          .getCopy('configuration', 'theme${index + 1}')
                          .toUpperCase(),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    if (!isPurchased)
                      Icon(Icons.shopping_cart,
                          color: Theme.of(context).colorScheme.onPrimary)
                  ],
                ),
              ),
            );
          },
        ),
      );
    }
  }
}
