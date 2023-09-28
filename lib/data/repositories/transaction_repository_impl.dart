import 'package:book/data/models/Result.dart';
import 'package:book/data/models/transaction.dart';
import 'package:book/data/services/transactions_service.dart';
import 'package:book/domain/repositories/transaction_repository.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionsService transactionsService;
  TransactionRepositoryImpl({required this.transactionsService});

  @override
  Future<Result<List<Transaction>>> getTransactionsByUserId(
      String userId) async {
    return await transactionsService.getTransactionsByUserId(userId);
  }

  @override
  Future<Result<Transaction>> postTransaction(Transaction transaction) async {
    return await transactionsService.postTransaction(transaction);
  }
}
