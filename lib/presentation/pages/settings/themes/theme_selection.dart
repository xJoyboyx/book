import 'package:book/presentation/blocs/purchases_bloc/purchases_bloc.dart';
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
    final purchaseState = context.watch<PurchaseBloc>().state;

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
          print('purchaseState = ${purchaseState}');
          if (purchaseState is PurchasesLoaded) {
            for (var p in purchaseState.iapDetails) {
              if (p.id == themeId) {
                productDetails = p;
              }
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
                  context.read<ThemeBloc>().add(ThemeChanged(themeId: index));
                } else {
                  if (productDetails != null) {
                    print('buying...');
                    final PurchaseParam purchaseParam = PurchaseParam(
                      productDetails: productDetails!,
                      applicationUserName: null,
                    );
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
