import 'package:dio/dio.dart';

class ExpenseRemoteDataSource {
  final Dio dio;

  ExpenseRemoteDataSource(this.dio);

  Future<double> convertToUSD(double amount, String fromCurrency) async {
    try {
      final res = await dio.get('https://open.er-api.com/v6/latest/USD');
      final rate = res.data['rates'][fromCurrency];

      if (rate != null && rate > 0) {
        final usd = amount / rate;
        return double.parse(usd.toStringAsFixed(2));
      } else {
        throw Exception('Invalid or unavailable exchange rate for $fromCurrency');
      }
    } catch (e) {
      // Handle network or data errors gracefully
      print('Currency conversion failed: $e');
      return 0.0; // fallback or default behavior
    }
  }
}

