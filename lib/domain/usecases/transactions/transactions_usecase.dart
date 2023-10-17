import 'package:book/data/models/Result.dart';
import 'package:book/data/models/transaction.dart';
import 'package:book/domain/repositories/transaction_repository.dart';

class TransactionsUseCase {
  final TransactionRepository transactionRepository;

  TransactionsUseCase({required this.transactionRepository});
  Future<bool> postTransaction(Transaction transaction) async {
    Result result = await transactionRepository.postTransaction(transaction);
    return result.isSuccess;
  }

  Future<bool> restoreTransaction(Transaction transaction) async {
    Result result = await transactionRepository.restoreTransaction(transaction);
    return result.isSuccess;
  }

  Future<List<Transaction>> getTransactions(String userId) async {
    Result<List<Transaction>> result =
        await transactionRepository.getTransactionsByUserId(userId);
    if (result.isSuccess) {
      return result.value!;
    } else {
      return List<Transaction>.empty();
    }
  }
}
