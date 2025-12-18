class ExchangeRateResponse {
  final String result;
  final String baseCode;
  final Map<String, double> conversionRates;
  final DateTime lastUpdate;

  const ExchangeRateResponse({
    required this.result,
    required this.baseCode,
    required this.conversionRates,
    required this.lastUpdate,
  });

  factory ExchangeRateResponse.fromJson(Map<String, dynamic> json) {
    final ratesJson = json['conversion_rates'] as Map<String, dynamic>;
    final rates = <String, double>{};

    ratesJson.forEach((key, value) {
      rates[key] = (value as num).toDouble();
    });

    return ExchangeRateResponse(
      result: json['result'] as String,
      baseCode: json['base_code'] as String,
      conversionRates: rates,
      lastUpdate: DateTime.fromMillisecondsSinceEpoch(
        (json['time_last_update_unix'] as int) * 1000,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'result': result,
      'base_code': baseCode,
      'conversion_rates': conversionRates,
      'time_last_update_unix': lastUpdate.millisecondsSinceEpoch ~/ 1000,
    };
  }
}
