import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flag/flag.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:currency_converter/view_models/currency_converter_view_model.dart';
import 'package:currency_converter/config/app_theme.dart';
import 'package:go_router/go_router.dart';
import 'package:currency_converter/models/currency.dart';

class CurrencySelector extends StatelessWidget {
  const CurrencySelector({super.key});

  @override
  Widget build(BuildContext context) {
    final viewmodel = context.watch<CurrencyConverterViewModel>();

    // 🔹 Afficher un loader si les monnaies ne sont pas encore chargées
    if (viewmodel.fromCurrency == null || viewmodel.toCurrency == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Row(
      children: [
        Expanded(
          child: _buildCurrencyItem(context, viewmodel.fromCurrency!, 'from'),
        ),
        IconButton(
          onPressed: () {
            viewmodel.swapCurrencies();
          },
          icon: const Icon(
            LucideIcons.arrowLeftRight,
            size: 24,
            color: AppColors.primary,
          ),
        ),
        Expanded(
          child: _buildCurrencyItem(context, viewmodel.toCurrency!, 'to'),
        ),
      ],
    );
  }

  Widget _buildCurrencyItem(BuildContext context, Currency currency, String type) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Material(
          color: AppColors.blue4,
          shape: const CircleBorder(),
          child: InkWell(
            onTap: () {
              context.push('/currency-selector?type=$type');
            },
            customBorder: const CircleBorder(),
            child: SizedBox(
              width: 80,
              height: 80,
              child: Center(
                child: Flag.fromString(
                  currency.countryCode,
                  width: 48,
                  height: 36,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          currency.name,
          style: textTheme.bodyLarge?.copyWith(color: AppColors.primary),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
