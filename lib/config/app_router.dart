import 'package:currency_converter/pages/currency_converter_page.dart';
import 'package:go_router/go_router.dart';
import 'package:currency_converter/pages/currency_picker_page.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const CurrencyConverterPage(),
    ),
    GoRoute(
      path: '/currency-selector',
      builder: (context, state) {
        final rawType = state.uri.queryParameters['type'];
        final type = (rawType == 'from' || rawType == 'to') ? rawType! : 'from';
        return CurrencyPickerPage(type: type);
      },
    ),
  ],
);
