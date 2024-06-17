import '../models/transaction.dart';
import '../services/transactions_http_service.dart';

class TransactionsController {
  final _transactionsHttpService = TransactionsHttpService();

  Future<void> sendMoney(
      int fromCardNumber, int toCardNumber, double amount) async {
    _transactionsHttpService.sendMoney(fromCardNumber, toCardNumber, amount);
  }

  Future<List<Transaction>> getTushumlar() async {
    return await _transactionsHttpService.getReceives();
  }

  Future<List<Transaction>> getJonatmalar() async {
    return await _transactionsHttpService.getSends();
  }
}
