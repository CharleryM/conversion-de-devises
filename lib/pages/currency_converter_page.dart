import 'package:flutter/material.dart';
import 'package:currency_converter/widgets/currency_selector.dart';
import 'package:provider/provider.dart';
import 'package:currency_converter/view_models/currency_converter_view_model.dart';

class CurrencyConverterPage extends StatelessWidget {
  const CurrencyConverterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<CurrencyConverterViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Currency Converter"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: vm.refreshRates,
          ),
        ],
      ),
      body: vm.isLoading
    ? const Center(child: CircularProgressIndicator())
    : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            const SizedBox(height: 20),

            const CurrencySelector(),

            const SizedBox(height: 30),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                  )
                ],
              ),
              child: Row(
                children: [

                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "Montant",
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        final val = double.tryParse(value) ?? 0;
                        vm.setInputValue(val);
                      },
                    ),
                  ),

                  const SizedBox(width: 16),


                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 18,
                        horizontal: 12,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        vm.convertedAmount == null
                            ? '--'
                            : vm.convertedAmount!.toStringAsFixed(2),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            if (vm.exchangeRate != null)
              Text(
                "Taux : ${vm.exchangeRate!.toStringAsFixed(4)}",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),

            if (vm.error != null)
              Text(
                vm.error!,
                style: const TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}
