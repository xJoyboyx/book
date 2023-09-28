import 'package:book/data/models/Result.dart';
import 'package:book/data/models/transaction.dart';

abstract class TransactionRepository {
  Future<Result<List<Transaction>>> getTransactionsByUserId(String userId);
  Future<Result<Transaction>> postTransaction(Transaction transaction);
}
