import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../controllers/default_values.dart';
import '../../../models/payments_save_model.dart';
import 'widgets/all_services.dart';
import 'widgets/search_payment.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Payments'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "To'lov",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Franklin'),
                  ),
                  IconButton(
                    onPressed: () {
                      List<PaymentsSaveModel> sims = [
                        PaymentsSaveModel(
                            name: 'Uyali aloqa',
                            sims: phonePayments,
                            icon: const Icon(Icons.phone_android_sharp)),
                        PaymentsSaveModel(
                            name: 'Internet',
                            sims: wifi,
                            icon: const Icon(Icons.wifi)),
                        PaymentsSaveModel(
                            name: 'Uy telefoni',
                            sims: homePhones,
                            icon: const Icon(Icons.phone)),
                        PaymentsSaveModel(
                            name: 'Onlayn platformalar',
                            sims: platformItems,
                            icon: const Icon(Icons.web_stories)),
                        PaymentsSaveModel(
                            name: 'Raqamli TV',
                            sims: tvItems,
                            icon: const Icon(Icons.live_tv)),
                        PaymentsSaveModel(
                            name: 'Xizmatlar',
                            sims: works,
                            icon: const Icon(Icons.work)),
                        PaymentsSaveModel(
                            name: 'Davlat xizmatlari',
                            sims: countryWorks,
                            icon: const Icon(Icons.home_work_outlined)),
                        PaymentsSaveModel(
                            name: "Ta'lim",
                            sims: teachCenter,
                            icon: const Icon(CupertinoIcons.book)),
                        PaymentsSaveModel(
                            name: 'Taxi',
                            sims: taxis,
                            icon: const Icon(Icons.local_taxi)),
                      ];
                      showSearch(
                          context: context, delegate: SearchViewDelegate(sims));
                    },
                    icon: const Icon(
                      Icons.search,
                      size: 27,
                    ),
                  ),
                ],
              ),
              const Divider(),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Barcha xizmatlar",
                style: TextStyle(
                    fontFamily: 'Franklin',
                    fontWeight: FontWeight.w900,
                    fontSize: 16),
              ),
              const SizedBox(
                height: 20,
              ),
              const AllServices(),
            ],
          ),
        ),
      ),
    );
  }
}
