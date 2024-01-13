import 'package:eploy/paypel.dart';
import 'package:flutter/material.dart';
import 'package:eploy/pay_card.dart';
import 'package:eploy/paypel.dart';
import 'package:flutter_paypal/flutter_paypal.dart';

class Payment extends StatefulWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  int selectedValue = 1;
  bool showEvaluateButton = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Background Image
            Image.network(
              'https://img.freepik.com/free-vector/abstract-blue-geometric-shapes-background_1035-17545.jpg?w=2000',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Select Payment Method',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  buildPaymentWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPaymentWidget() {
    return Column(
      children: [
        RadioListTile(
          title: Text('Direct'),
          value: 1,
          groupValue: selectedValue,
          onChanged: (value) {
            setState(() {
              selectedValue = value as int;
              showEvaluateButton = false;
            });
          },
        ),
        RadioListTile(
          title: Text('Card'),
          value: 2,
          groupValue: selectedValue,
          onChanged: (value) {
            setState(() {
              selectedValue = value as int;
              showEvaluateButton = true;
            });
          },
        ),

        if (showEvaluateButton)
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => pay_card()),
              );
            },
            child: Text('Card payment'),
          ),
        if (showEvaluateButton)
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UsePaypal(
                    sandboxMode: true,
                    clientId:
                    "AUopsWwRJ6oqa2481axhY9S_6iLYR6IWi7KUzd8KJOsi-bKai5SQvypcN1rv3o9x-TCtx6nRZjqnGucD",
                    secretKey:
                    "EDoeUiZ_P9WOSM3x_1o2Iy4qkEBvsNlx52W29J-5QjhrE8PW1AAQq_pTOXIwoJsnsGzNLtZb8fRvjddL",
                    returnURL: "https://samplesite.com/return",
                    cancelURL: "https://samplesite.com/cancel",
                    transactions: const [
                      {
                        "amount": {
                          "total": '10.12',
                          "currency": "USD",
                          "details": {
                            "subtotal": '10.12',
                            "shipping": '0',
                            "shipping_discount": 0
                          }
                        },
                        "description":
                        "The payment transaction description.",
                        // "payment_options": {
                        //   "allowed_payment_method":
                        //       "INSTANT_FUNDING_SOURCE"
                        // },
                        "item_list": {
                          "items": [
                            {
                              "name": "A demo product",
                              "quantity": 1,
                              "price": '10.12',
                              "currency": "USD"
                            }
                          ],

                          // shipping address is not required though
                          "shipping_address": {
                            "recipient_name": "Jane Foster",
                            "line1": "Travis County",
                            "line2": "",
                            "city": "Austin",
                            "country_code": "US",
                            "postal_code": "73301",
                            "phone": "+00000000",
                            "state": "Texas"
                          },
                        }
                      }
                    ],
                    note: "Contact us for any questions on your order.",
                    onSuccess: (Map params) async {
                      print("onSuccess: $params");
                    },
                    onError: (error) {
                      print("onError: $error");
                    },
                    onCancel: (params) {
                      print('cancelled: $params');
                    }),),
              );
            },
            child: Text('PayPal payment'),
          ),
      ],
    );
  }
}
