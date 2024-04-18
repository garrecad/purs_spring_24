import "package:flutter/material.dart";
import "package:pay/pay.dart";
import "package:purs_spring_24/src/test/payment_configurations.dart";
import "package:purs_spring_24/src/test/test_view.dart";

class DonateView extends StatefulWidget {
  const DonateView({super.key});
  static const routeName = '/home';

  @override
  State<DonateView> createState() => _DonateViewState();
}

class _DonateViewState extends State<DonateView> {
  @override
  Widget build(BuildContext context) {
    int selectedPayment = 0;
    String defaultGooglePayConfigString = defaultGooglePay;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Flexible(
              child: Image.asset(
                'assets/images/logo_icon.png',
                fit: BoxFit.scaleDown,
                height: AppBar().preferredSize.height,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Flexible(
              child: Image.asset(
                'assets/images/logo_horizontal.png',
                fit: BoxFit.scaleDown,
                height: AppBar().preferredSize.height,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () => {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(const SnackBar(content: Text("MOCKED")))
                  },
              icon: const Icon(Icons.map)),
          IconButton(
              onPressed: () => {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(const SnackBar(content: Text("MOCKED")))
                  },
              icon: const Icon(Icons.settings)),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Expanded(child: SizedBox()),
            Container(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.75),
              child: const Text(
                "Sponsoring an animal helps your favorite Heartland pet to get adopted.",
                overflow: TextOverflow.visible,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            FloatingActionButton.extended(
              onPressed: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PageViewExample()))
              },
              label: const Text("Sponsor an animal"),
              icon: const Icon(Icons.favorite_outline),
            ),
            const SizedBox(
              height: 50,
            ),
            
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.75,
              child: const TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Donation Amount"),
                  prefix: Text("\$"),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            const Expanded(child: SizedBox()),
            GooglePayButton(
              paymentConfiguration: PaymentConfiguration.fromJsonString(
                  defaultGooglePayConfigString),
              paymentItems: [
                PaymentItem(
                  label: 'Sponsor Total',
                  amount: switch (selectedPayment) {
                    0 => "35",
                    1 => "50",
                    2 => "150",
                    _ => "0",
                  },
                  status: PaymentItemStatus.final_price,
                )
              ],
              type: GooglePayButtonType.pay,
              margin: const EdgeInsets.only(top: 15.0),
              onPaymentResult: _onGooglePayResult,
              loadingIndicator: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  void _onGooglePayResult(paymentResult) {
    // Send the resulting Google Pay token to your server / PSP
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}
