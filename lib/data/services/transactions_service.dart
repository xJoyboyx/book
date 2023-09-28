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
      final List<Transaction> transactions = (response as List)
          .map((json) => Transaction.fromJson(json as Map<String, dynamic>))
          .toList();
      return Result.success(transactions);
    } catch (e) {
      return Result.failure(e);
    }
  }

  Future<Result<Transaction>> postTransaction(Transaction transaction) async {
    try {
      final response =
          await httpClient.post('${URL}/transactions', transaction.toJson());
      final Transaction transactionResponse =
          Transaction.fromRawJson(response.body);
      return Result.success(transactionResponse);
    } catch (e) {
      return Result.failure(e);
    }
  }
}
