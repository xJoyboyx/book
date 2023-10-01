import 'dart:convert';

import 'package:book/data/datasources/endpoints.dart';
import 'package:book/data/models/http_client.dart';
import 'package:book/data/models/transaction.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/Result.dart';

class TransactionsService {
  final HttpClient httpClient;
  final SharedPreferences sharedPreferences;

  TransactionsService(
      {required this.httpClient, required this.sharedPreferences});

  Future<Result<List<Transaction>>> getTransactionsByUserId(
      String userId) async {
    try {
      final response = await httpClient.get('${URL}/transactions/user/$userId');
      final body =
          jsonDecode(response.body); // Decodifica el String JSON en una List
      final List<Transaction> transactions = (body as List)
          .map((json) =>
              Transaction.fromJson(json)) // Mapea cada elemento de la lista
          .toList();
      return Result.success(transactions);
    } catch (e) {
      print('❌ FAILURE_TRANSACTIONS_MAP: ${e}');
      return Result.failure(e);
    }
  }

  Future<Result<Transaction>> postTransaction(Transaction transaction) async {
    print('transaction body: ${transaction.toRawJson()}');
    try {
      final response =
          await httpClient.post('${URL}/transactions', transaction.toJson());
      final Transaction transactionResponse =
          Transaction.fromRawJson(response.body);
      print(response.body);
      print(response.statusCode);

      return Result.success(transactionResponse);
    } catch (e) {
      print('error on transaction post ${e}');
      return Result.failure(e);
    }
  }
}
