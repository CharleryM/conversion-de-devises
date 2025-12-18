import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flag/flag.dart';
import 'package:go_router/go_router.dart';
import 'package:currency_converter/view_models/currency_converter_view_model.dart';

class CurrencyPickerPage extends StatelessWidget {
  final String type;
  const CurrencyPickerPage({required this.type, super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<CurrencyConverterViewModel>();

    // 🔹 Loader si pas encore chargé
    if (vm.availableCurrencies.isEmpty) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Choose currency")),
      body: ListView.builder(
        itemCount: vm.availableCurrencies.length,
        itemBuilder: (context, index) {
          final currency = vm.availableCurrencies[index];
          return ListTile(
            title: Text(currency.name),
            subtitle: Text(currency.code),
            leading: SizedBox(
              width: 48,
              height: 36,
              child: Flag.fromString(
                currency.countryCode,
                fit: BoxFit.cover,
              ),
            ),
            onTap: () {
              if (type == 'from') {
                vm.setFromCurrency(currency);
              } else {
                vm.setToCurrency(currency);
              }
              context.pop();
            },
          );
        },
      ),
    );
  }
}
