import 'package:flutter/material.dart';
import 'package:mercado_pago_integration/core/failures.dart';
import 'package:mercado_pago_integration/mercado_pago_integration.dart';
import 'package:mercado_pago_integration/models/payment.dart';

var precoString = "150,90";
var korije = precoString.replaceAll(",", ".");

double preco = double.parse(korije);

final Map<String, Object> preference = {
  'items': [
    {
      'title': 'Test Product',
      'description': 'Description',
      'quantity': 1,
      'currency_id': 'ARS',
      'unit_price': preco,
    }
  ],
  'payer': {'name': 'Buyer G.', 'email': 'test@gmail.com'},
};

class MercadoPago extends StatefulWidget {
  @override
  _MercadoPagoState createState() => _MercadoPagoState();
}

class _MercadoPagoState extends State<MercadoPago> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Mercado Pago Integration Example'),
        ),
        body: Center(
          child: RaisedButton(
            onPressed: () async {
              (await MercadoPagoIntegration.startCheckout(
                publicKey: "TEST-2f57d6d4-3bef-4777-ba0b-ea8545cc08d9",
                preference: preference,
                accessToken: "TEST-7674115201783731-051815-5c01ed10ad7e0363e1ea896dd74d1d60-164103234",
              ))
                  .fold((Failure failure) {
                debugPrint('Failure => ${failure.message}');
              }, (Payment payment) {
                debugPrint('Payment => ${payment.paymentId}');
              });
            },
            child: Text('Test Integration'),
          ),
        ),
      ),
    );
  }
}