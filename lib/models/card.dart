/// Flutter widgetlari orasida Card widgeti borligi uchun, klassni Card emas Karta deb nomlandi
class Karta {
  final String id;
  num balance;
  String bankName;
  String cardName;
  num cardNumber;
  String customerId;
  String expiryDate;
  String type;

  Karta({
    required this.id,
    required this.balance,
    required this.bankName,
    required this.cardName,
    required this.cardNumber,
    required this.customerId,
    required this.expiryDate,
    required this.type,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'balance': balance,
      'bankName': bankName,
      'cardName': cardName,
      'cardNumber': cardNumber,
      'customerId': customerId,
      'expiryDate': expiryDate,
      'type': type,
    };
  }

  factory Karta.fromJson(Map<String, dynamic> json) {
    return Karta(
      id: json['id'] as String,
      balance: json['balance'] as double,
      bankName: json['bankName'] as String,
      cardName: json['cardName'] as String,
      cardNumber: json['cardNumber'] as int,
      customerId: json['customerId'] as String,
      expiryDate: json['expiryDate'] as String,
      type: json['type'] as String,
    );
  }

  @override
  String toString() {
    return 'Karta{id: $id, balance: $balance, bankName: $bankName, cardName: $cardName, cardNumber: $cardNumber, customerId: $customerId, expiryDate: $expiryDate, type: $type}';
  }
}
