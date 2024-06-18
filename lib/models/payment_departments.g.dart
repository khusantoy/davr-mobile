// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_departments.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentDepartments _$PaymentDepartmentsFromJson(Map<String, dynamic> json) =>
    PaymentDepartments(
      amount: (json['amount'] as num).toDouble(),
      date: DateTime.parse(json['date'] as String),
      servicesName: json['servicesName'] as String,
      servicesAccount: json['servicesAccount'] as String,
      userId: json['userId'] as String,
      fromCard: json['fromCard'] as String,
    );

Map<String, dynamic> _$PaymentDepartmentsToJson(PaymentDepartments instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'date': instance.date.toIso8601String(),
      'servicesName': instance.servicesName,
      'servicesAccount': instance.servicesAccount,
      'userId': instance.userId,
      'fromCard': instance.fromCard,
    };
