
import 'package:json_annotation/json_annotation.dart';
part 'payment_departments.g.dart';
@JsonSerializable()
class PaymentDepartments{
  double amount;
  DateTime date;
  String servicesName;
  String servicesAccount;
  String userId ;
  String fromCard;

  PaymentDepartments({
    required this.amount,
    required this.date,
    required this.servicesName,
    required this.servicesAccount,
    required this.userId,
    required this.fromCard
});

  factory PaymentDepartments.fromJson(Map<String, dynamic> json) {
    return _$PaymentDepartmentsFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$PaymentDepartmentsToJson(this);
  }
}