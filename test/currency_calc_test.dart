import 'package:dio/dio.dart';
import 'package:expensetrackerlite/features/expense/data/datasources/expense_remote_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';



class MockDio extends Mock implements Dio {}

void main() {
  late MockDio mockDio;
  late ExpenseRemoteDataSource dataSource;

  setUp(() {
    mockDio = MockDio();
    dataSource = ExpenseRemoteDataSource(mockDio);
  });


  test('convertToUSD returns 4.9 when 250 EGP and rate is 51.02', () async {
    // Arrange
    const amount = 250.0;
    const fromCurrency = 'EGP';
    const expected = 4.9;
    const rate = 51.02; // 250 / 51.02 = 4.9

    final fakeResponse = Response(
      requestOptions: RequestOptions(path: ''),
      statusCode: 200,
      data: {
        'rates': {
          fromCurrency: rate,
        },
      },
    );

    when(() => mockDio.get(any())).thenAnswer((_) async => fakeResponse);

    // Act
    final result = await dataSource.convertToUSD(amount, fromCurrency);

    // Assert
    expect(result, expected);
  });

}