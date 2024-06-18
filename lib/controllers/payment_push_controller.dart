
import '../models/payment_departments.dart';
import '../services/payment_http_services.dart';

class PaymentPushController{
  final services = PaymentHttpServices();

  Future<void> pushPayment(PaymentDepartments payment) async{
    await services.pushPayment(payment);
  }
}