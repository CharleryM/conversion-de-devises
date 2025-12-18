import 'package:currency_converter/models/currency.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CurrencyRepository {
  static const String _fromCurrencyKey = 'from_currency';
  static const String _toCurrencyKey = 'to_currency';

  static const List<Currency> _currencies = [
    Currency(code: 'EUR', name: 'Euro', countryCode: 'eu'),
    Currency(code: 'USD', name: 'Dollar américain', countryCode: 'us'),
    Currency(code: 'GBP', name: 'Livre sterling', countryCode: 'gb'),
    Currency(code: 'JPY', name: 'Yen japonais', countryCode: 'jp'),
    Currency(code: 'CHF', name: 'Franc suisse', countryCode: 'ch'),
    Currency(code: 'CAD', name: 'Dollar canadien', countryCode: 'ca'),
    Currency(code: 'AUD', name: 'Dollar australien', countryCode: 'au'),
    Currency(code: 'CNY', name: 'Yuan chinois', countryCode: 'cn'),
    Currency(code: 'INR', name: 'Roupie indienne', countryCode: 'in'),
    Currency(code: 'BRL', name: 'Réal brésilien', countryCode: 'br'),
    Currency(code: 'MXN', name: 'Peso mexicain', countryCode: 'mx'),
    Currency(code: 'SEK', name: 'Couronne suédoise', countryCode: 'se'),
    Currency(code: 'NOK', name: 'Couronne norvégienne', countryCode: 'no'),
    Currency(code: 'DKK', name: 'Couronne danoise', countryCode: 'dk'),
    Currency(code: 'SGD', name: 'Dollar de Singapour', countryCode: 'sg'),
    Currency(code: 'NZD', name: 'Dollar néo-zélandais', countryCode: 'nz'),
    Currency(code: 'KRW', name: 'Won sud-coréen', countryCode: 'kr'),
    Currency(code: 'HKD', name: 'Dollar de Hong Kong', countryCode: 'hk'),
    Currency(code: 'RUB', name: 'Rouble russe', countryCode: 'ru'),
    Currency(code: 'TRY', name: 'Livre turque', countryCode: 'tr'),
    Currency(code: 'ZAR', name: 'Rand sud-africain', countryCode: 'za'),
    Currency(code: 'PLN', name: 'Zloty polonais', countryCode: 'pl'),
    Currency(code: 'THB', name: 'Baht thaïlandais', countryCode: 'th'),
    Currency(code: 'MYR', name: 'Ringgit malaisien', countryCode: 'my'),
    Currency(code: 'IDR', name: 'Roupie indonésienne', countryCode: 'id'),
    Currency(code: 'AED', name: 'Dirham des Émirats', countryCode: 'ae'),
    Currency(code: 'SAR', name: 'Riyal saoudien', countryCode: 'sa'),
    Currency(code: 'ILS', name: 'Shekel israélien', countryCode: 'il'),
    Currency(code: 'PHP', name: 'Peso philippin', countryCode: 'ph'),
    Currency(code: 'CZK', name: 'Couronne tchèque', countryCode: 'cz'),
    Currency(code: 'HUF', name: 'Forint hongrois', countryCode: 'hu'),
    Currency(code: 'CLP', name: 'Peso chilien', countryCode: 'cl'),
    Currency(code: 'ARS', name: 'Peso argentin', countryCode: 'ar'),
    Currency(code: 'COP', name: 'Peso colombien', countryCode: 'co'),
    Currency(code: 'EGP', name: 'Livre égyptienne', countryCode: 'eg'),
    Currency(code: 'VND', name: 'Dong vietnamien', countryCode: 'vn'),
  ];

  Future<SharedPreferences> get _preferences => SharedPreferences.getInstance();

  List<Currency> getAllCurrencies() {
    final sortedCurrencies = List<Currency>.from(_currencies);
    sortedCurrencies.sort((a, b) => a.name.compareTo(b.name));
    return sortedCurrencies;
  }

  Currency? getCurrencyByCode(String code) {
    try {
      return _currencies.firstWhere((currency) => currency.code == code);
    } catch (e) {
      return null;
    }
  }

  Future<void> saveFromCurrency(String code) async {
    final prefs = await _preferences;
    await prefs.setString(_fromCurrencyKey, code);
  }

  Future<void> saveToCurrency(String code) async {
    final prefs = await _preferences;
    await prefs.setString(_toCurrencyKey, code);
  }

  Future<Currency?> getSavedFromCurrency() async {
    final prefs = await _preferences;
    final code = prefs.getString(_fromCurrencyKey);
    if (code == null) return null;
    return getCurrencyByCode(code);
  }

  Future<Currency?> getSavedToCurrency() async {
    final prefs = await _preferences;
    final code = prefs.getString(_toCurrencyKey);
    if (code == null) return null;
    return getCurrencyByCode(code);
  }
}
