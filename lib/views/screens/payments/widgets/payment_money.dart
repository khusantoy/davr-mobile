import 'package:flutter/material.dart';

import '../../../../controllers/cards_controller.dart';
import '../../../../controllers/payment_push_controller.dart';
import '../../../../models/payment_departments.dart';


class PaymentMoney extends StatelessWidget {
 final PaymentDepartments paymentDepartments;
  PaymentMoney({super.key,required this.paymentDepartments});

  final controller = CardsController();
  bool isLoading = false;
  PaymentPushController push = PaymentPushController();

  void getPush(PaymentDepartments payment) async{
    await push.pushPayment(paymentDepartments);
  }

  @override
  Widget build(BuildContext context) {
    getPush(paymentDepartments);

    return AlertDialog(
      content: isLoading ? const CircularProgressIndicator() : const Icon(Icons.check_circle_outline,color: Colors.green,size: 100,),
      alignment: Alignment.center,
      title: isLoading ? const Text('Pul otkazilmoqda') : const Text("Pul o'tkazildi"),
      actions: [
        isLoading ? const SizedBox() : TextButton(onPressed: (){
          Navigator.pop(context);
        }, child: const Text("OK",style: TextStyle(fontFamily: "Franklin",fontWeight: FontWeight.bold,fontSize: 20),))
      ],
    );
  }
}
