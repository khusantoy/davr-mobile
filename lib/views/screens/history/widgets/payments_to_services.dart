import 'package:davr_mobile/controllers/payment_push_controller.dart';
import 'package:flutter/material.dart';

class PaymentToServices extends StatefulWidget {
  const PaymentToServices({super.key});

  @override
  State<PaymentToServices> createState() => _PaymentToServicesState();
}

class _PaymentToServicesState extends State<PaymentToServices> {
  final paymentsController = PaymentsController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Xizmatga to'lovlar"),
      ),
      body: FutureBuilder(
        future: paymentsController.getPayments(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Could not load Payments'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No payments found'));
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return Text('${snapshot.data![index].amount}');
            },
          );
        },
      ),
    );
  }
}
