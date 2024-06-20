import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../controllers/default_values.dart';
import '../../../../models/payment.dart';
import '../show_sim_phone.dart';

class AllServices extends StatefulWidget {
  const AllServices({super.key});

  @override
  State<AllServices> createState() => _AllServicesState();
}

class _AllServicesState extends State<AllServices> {
  List<List<Payment>> payments = [
    [
      Payment(
          icon: const Icon(
            Icons.phone_android_sharp,
          ),
          name: "Uyali aloqa",
          payments: phonePayments),
      Payment(icon: const Icon(Icons.wifi), name: "Internet", payments: wifi),
      Payment(
          icon: const Icon(Icons.phone),
          name: "Uy telefoni",
          payments: homePhones),
    ],
    [
      Payment(
          icon: const Icon(Icons.web_stories),
          name: "Onlayn platformalar",
          payments: platformItems),
      Payment(
          icon: const Icon(Icons.live_tv_rounded),
          name: "Raqamli TV",
          payments: tvItems),
      Payment(icon: const Icon(Icons.work), name: "Xizmatlar", payments: works),
    ],
    [
      Payment(
          icon: const Icon(Icons.home_work_outlined),
          name: "Davlat xizmatlari",
          payments: countryWorks),
      Payment(
          icon: const Icon(CupertinoIcons.book),
          name: "Ta'lim",
          payments: teachCenter),
      Payment(icon: const Icon(Icons.local_taxi), name: "Taxi", payments: taxis)
    ],
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.shade700,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.grey.shade300, width: 2),
      ),
      child: Column(children: [
        Row(
          children: [
            for (int i = 0; i < 0 + 3; i++)
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.5),
                  child: InkWell(
                    onTap: () {
                      String paymentType = '';
                      if (payments[0][i].name == 'Uyali aloqa')
                        paymentType = 'phone';
                      else if (payments[0][i].name == 'Internet')
                        paymentType = 'wifi';
                      else if (payments[0][i].name == "Uy telefoni")
                        paymentType = 'home';

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ShowSimPhone(
                                    payment: payments[0][i],
                                    paymentType: paymentType,
                                  )));
                    },
                    child: Container(
                      height: 120,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: AdaptiveTheme.of(context).mode ==
                                  AdaptiveThemeMode.dark
                              ? Colors.black
                              : Colors.grey.shade300),
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          payments[0][i].icon,
                          const SizedBox(
                            height: 20,
                          ),
                          Text("${payments[0][i].name}")
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(
          height: 0.7,
        ),
        Row(
          children: [
            for (int i = 0; i < 0 + 3; i++)
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.5),
                  child: InkWell(
                    onTap: () {
                      String paymentType = '';
                      if (payments[1][i].name == 'Onlayn platformalar')
                        paymentType = 'platform';
                      else if (payments[1][i].name == 'Raqamli TV')
                        paymentType = 'tv';
                      else if (payments[1][i].name == 'Xizmatlar')
                        paymentType = 'work';

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ShowSimPhone(
                                  payment: payments[1][i],
                                  paymentType: paymentType)));
                    },
                    child: Container(
                      height: 120,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: AdaptiveTheme.of(context).mode ==
                                  AdaptiveThemeMode.dark
                              ? Colors.black
                              : Colors.grey.shade300),
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          payments[1][i].icon,
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            "${payments[1][i].name}",
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(
          height: 0.5,
        ),
        const SizedBox(
          height: 0.5,
        ),
        Row(
          children: [
            for (int i = 0; i < 3; i++)
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.5),
                  child: InkWell(
                    onTap: () {
                      String paymentType = '';

                      if (payments[2][i].name == 'Davlat xizmatlari')
                        paymentType = 'country';
                      else if (payments[2][i].name == "Ta'lim")
                        paymentType = 'teach';
                      else if (payments[2][i].name == 'Taxi')
                        paymentType = 'taxi';
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ShowSimPhone(
                                  payment: payments[2][i],
                                  paymentType: paymentType)));
                    },
                    child: Container(
                      height: 120,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: AdaptiveTheme.of(context).mode ==
                                  AdaptiveThemeMode.dark
                              ? Colors.black
                              : Colors.grey.shade300),
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          payments[2][i].icon,
                          const SizedBox(
                            height: 20,
                          ),
                          Center(child: Text("${payments[2][i].name}"))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ]),
      // child: Wrap(
      //   children: [
      //     Container()
      //   ],
      // ),
    );
  }
}
