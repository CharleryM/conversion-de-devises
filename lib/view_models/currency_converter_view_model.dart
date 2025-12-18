import 'package:flutter/foundation.dart';
import 'package:currency_converter/models/currency.dart';
import 'package:currency_converter/repositories/exchange_rate_repository.dart';
import 'package:currency_converter/repositories/currency_repository.dart';

class CurrencyConverterViewModel extends ChangeNotifier {
  final ExchangeRateRepository _exchangeRateRepository = ExchangeRateRepository();
  final CurrencyRepository _currencyRepository = CurrencyRepository();

  double _inputValue = 1.0;
  Currency? _fromCurrency;
  Currency? _toCurrency;
  Map<String, double> _rates = {};
  DateTime? _lastUpdate;
  bool _isLoading = false;
  String? _error;

  double get inputValue => _inputValue;
  Currency? get fromCurrency => _fromCurrency;
  Currency? get toCurrency => _toCurrency;
  DateTime? get lastUpdate => _lastUpdate;
  bool get isLoading => _isLoading;
  String? get error => _error;

  List<Currency> get availableCurrencies =>
      _currencyRepository.getAllCurrencies();

  double? get exchangeRate {
    if (_fromCurrency == null || _toCurrency == null) return null;
    final fromCode = _fromCurrency!.code;
    final toCode = _toCurrency!.code;
    if (_rates.containsKey(fromCode) && _rates.containsKey(toCode)) {
      return _rates[toCode]! / _rates[fromCode]!;
    }
    return null;
  }

  double? get convertedAmount {
    if (exchangeRate == null) return null;
    return _inputValue * exchangeRate!;
  }

  void setInputValue(double value) {
    _inputValue = value;
    notifyListeners();
  }

  Future<void> loadSavedCurrencies() async {
    _fromCurrency = await _currencyRepository.getSavedFromCurrency();
    _fromCurrency ??= availableCurrencies.isNotEmpty ? availableCurrencies.first : null;

    _toCurrency = await _currencyRepository.getSavedToCurrency();
    if (_toCurrency == null && availableCurrencies.length > 1) {
      _toCurrency = availableCurrencies[1];
    }

    notifyListeners();
  }

  void setFromCurrency(Currency currency) {
    _fromCurrency = currency;
    _currencyRepository.saveFromCurrency(currency.code);
    notifyListeners();
  }

  void setToCurrency(Currency currency) {
    _toCurrency = currency;
    _currencyRepository.saveToCurrency(currency.code);
    notifyListeners();
  }

  void swapCurrencies() {
    final temp = _fromCurrency;
    _fromCurrency = _toCurrency;
    _toCurrency = temp;

    if (_fromCurrency != null) {
      _currencyRepository.saveFromCurrency(_fromCurrency!.code);
    }
    if (_toCurrency != null) {
      _currencyRepository.saveToCurrency(_toCurrency!.code);
    }
    notifyListeners();
  }

  Future<void> fetchExchangeRates() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _rates = await _exchangeRateRepository.getExchangeRates();
      _lastUpdate = await _exchangeRateRepository.getLastUpdateTime();
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners(); 
  }

  Future<void> refreshRates() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _rates = await _exchangeRateRepository.refreshExchangeRates();
      _lastUpdate = DateTime.now();
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners(); 
  }
}
