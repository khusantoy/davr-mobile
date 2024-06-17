import '../models/card.dart';
import '../services/cards_http_service.dart';

class CardsController {
  final _cardsHttpService = CardsHttpService();

  Future<List<Karta>> getCards() async {
    return await _cardsHttpService.getCards();
  }

  Future<void> addCard({
    required double balance,
    required String bankName,
    required String cardName,
    required int cardNumber,
    required String expiryDate,
    required String type,
  }) async {
    _cardsHttpService.addCard(
      balance: balance,
      bankName: bankName,
      cardName: cardName,
      cardNumber: cardNumber,
      expiryDate: expiryDate,
      type: type,
    );
  }
}
