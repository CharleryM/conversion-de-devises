import 'package:currency_converter/config/app_router.dart';
import 'package:currency_converter/config/app_theme.dart';
import 'package:currency_converter/view_models/currency_converter_view_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Remplace l'écran noir par un widget lisible en cas d'exception non gérée
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Material(
      child: Scaffold(
        appBar: AppBar(title: const Text('Erreur application')),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Erreur: ${details.exceptionAsString()}',
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ),
      ),
    );
  };

  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
  };
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Load environment variables
  await dotenv.load(fileName: '.env');

  GoRouter.optionURLReflectsImperativeAPIs = true;

  runApp(const CurrencyConverter());
}

class CurrencyConverter extends StatelessWidget {
  const CurrencyConverter({super.key});

  @override
  Widget build(BuildContext context) {
  return ChangeNotifierProvider(
      create: (_) => CurrencyConverterViewModel()
        ..loadSavedCurrencies()
        ..fetchExchangeRates(),
      child: MaterialApp.router(
        title: 'Currency Converter',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theme,
        routerConfig: appRouter,
      ),
    );
  }
}
