import '../models/card.dart';
import '../services/cards_http_service.dart';

class CardsController {
  final _cardsHttpService = CardsHttpService();

  Future<List<Karta>> getCards() async {
    return await _cardsHttpService.getCards();
  }
}
