import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:currency_converter/models/exchange_rate_response.dart';

class ExchangeRateRepository {
  static const String _ratesKey = 'exchange_rates';
  static const String _timestampKey = 'exchange_rates_timestamp';

  final Dio _dio = Dio();
  Future<SharedPreferences> get _preferences => SharedPreferences.getInstance();

  Future<Map<String, double>> getExchangeRates() async {
    final cached = await _loadFromCache();
    if (cached != null) {
      final (rates, _) = cached;
      return rates;
    }
    return await refreshExchangeRates();
  }

  Future<Map<String, double>> refreshExchangeRates() async {
    await Future.delayed(const Duration(milliseconds: 500));

    try {
      final apiKey = dotenv.env['EXCHANGE_RATE_API_KEY'];
      if (apiKey == null || apiKey.isEmpty) {
        throw Exception('EXCHANGE_RATE_API_KEY not found in .env');
      }

      final response = await _dio.get(
        'https://v6.exchangerate-api.com/v6/$apiKey/latest/USD',
      );


      if (response.statusCode != 200) {
        throw Exception(
          'Failed to fetch exchange rates: ${response.statusCode}',
        );
      }

      final exchangeRateResponse = ExchangeRateResponse.fromJson(response.data);

      if (exchangeRateResponse.result != 'success') {
        throw Exception('API returned error: ${exchangeRateResponse.result}');
      }

      await _saveToCache(
        exchangeRateResponse.conversionRates,
        DateTime.now(),
      );

      return exchangeRateResponse.conversionRates;
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Failed to fetch exchange rates: $e');
    }
  }

  Future<DateTime?> getLastUpdateTime() async {
    final prefs = await _preferences;
    final timestamp = prefs.getInt(_timestampKey);
    if (timestamp == null) return null;
    return DateTime.fromMillisecondsSinceEpoch(timestamp);
  }

  Future<void> _saveToCache(
    Map<String, double> rates,
    DateTime timestamp,
  ) async {
    final prefs = await _preferences;
    await prefs.setString(_ratesKey, jsonEncode(rates));
    await prefs.setInt(_timestampKey, timestamp.millisecondsSinceEpoch);
  }

  Future<(Map<String, double>, DateTime)?> _loadFromCache() async {
    final prefs = await _preferences;
    final ratesJson = prefs.getString(_ratesKey);
    final timestamp = prefs.getInt(_timestampKey);

    if (ratesJson == null || timestamp == null) return null;

    try {
      final Map<String, dynamic> decoded = jsonDecode(ratesJson);
      final rates = decoded.map(
        (key, value) => MapEntry(key, (value as num).toDouble()),
      );
      final dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);

      return (rates, dateTime);
    } catch (e) {
      // Cache corrupted, clear it
      await prefs.remove(_ratesKey);
      await prefs.remove(_timestampKey);
      return null;
    }
  }
}
