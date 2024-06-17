class Transaction {
  final String id;
  final num amount;
  final String date;
  final num fromCard;
  final String fromId;
  final num toCard;

  final String toId;

  const Transaction({
    required this.id,
    required this.amount,
    required this.date,
    required this.fromCard,
    required this.fromId,
    required this.toCard,
    required this.toId,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount': amount,
      'date': date,
      'fromCard': fromCard,
      'fromId': fromId,
      'toCard': toCard,
      'toId': toId,
    };
  }

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'] as String,
      amount: json['amount'] as num,
      date: json['date'] as String,
      fromCard: json['fromCard'] as num,
      fromId: json['fromId'] as String,
      toCard: json['toCard'] as num,
      toId: json['toId'] as String,
    );
  }
}
