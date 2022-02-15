// ignore_for_file: unnecessary_this, duplicate_ignore

import 'dart:convert';

import 'package:client/Qr-Code/Qr-Code.dart';
import 'package:client/helpers/TextHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutterwave/flutterwave.dart';

class Billing extends StatefulWidget {
  const Billing({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _BillingState createState() => _BillingState();
}

class _BillingState extends State<Billing> {
  final formKey = GlobalKey<FormState>();
  final amountController = TextEditingController();
  final currencyController = TextEditingController();
  final narrationController = TextEditingController();
  final publicKeyController = TextEditingController();
  final encryptionKeyController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();

  String selectedCurrency = "";

  bool isDebug = true;

  @override
  Widget build(BuildContext context) {
    currencyController.text = selectedCurrency;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        width: double.infinity,
        margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Form(
          key: formKey,
          child: ListView(
            children: <Widget>[
              // ignore: avoid_unnecessary_containers
              Container(
                decoration: const BoxDecoration(),
                child: SizedBox(
                  width: 200,
                  height: 200,
                  child: Image.asset("images/sm.png"),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: TextFormField(
                  controller: amountController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Colors.black),
                  decoration: const InputDecoration(hintText: "Amount"),
                  validator: (value) =>
                      value!.isNotEmpty ? null : "Amount is required",
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: TextFormField(
                  controller: emailController,
                  textInputAction: TextInputAction.next,
                  style: const TextStyle(color: Colors.black),
                  keyboardType: TextInputType.emailAddress,
                  // readOnly: true,
                  // onTap: _openBottomSheet,
                  decoration: const InputDecoration(
                    hintText: "Email",
                  ),
                  validator: (value) =>
                      value!.isNotEmpty ? null : "email is required",
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: TextFormField(
                  controller: currencyController,
                  textInputAction: TextInputAction.next,
                  style: const TextStyle(color: Colors.black),
                  readOnly: true,
                  onTap: _openBottomSheet,
                  decoration: const InputDecoration(
                    hintText: "Currency",
                  ),
                  validator: (value) =>
                      value!.isNotEmpty ? null : "Currency is required",
                ),
              ),

              Container(
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: TextFormField(
                  controller: phoneNumberController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.phone,
                  style: const TextStyle(color: Colors.black),
                  decoration: const InputDecoration(
                    hintText: "Phone Number",
                  ),
                  validator: (value) =>
                      value!.isNotEmpty ? null : "Phone Number is required",
                ),
              ),

              Container(
                width: double.infinity,
                height: 50,
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: ElevatedButton(
                  onPressed: _onPressed,
                  child: const Text(
                    "Make Payment",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  _onPressed() {
    if (formKey.currentState!.validate()) {
      this._handlePaymentInitialization();
    }
  }

  _handlePaymentInitialization() async {
    final flutterwave = Flutterwave.forUIPayment(
      amount: amountController.text.toString().trim(),
      currency: currencyController.text,
      context: context,
      publicKey: "FLWPUBK_TEST-288892a27911ae679fd74903d19c6e41-X".trim(),
      encryptionKey: "FLWSECK_TESTcc6563bff662".trim(),
      email: emailController.text.trim(),
      fullName: "Test User",
      txRef: DateTime.now().toIso8601String(),
      narration: "Supermarket",
      isDebugMode: true,
      phoneNumber: phoneNumberController.text.trim(),
      acceptAccountPayment: true,
      acceptCardPayment: true,
      acceptUSSDPayment: true,
      acceptUgandaPayment: true,
      acceptRwandaMoneyPayment: true,
    );
    final response = await flutterwave.initializeForUiPayments();
    // ignore: unnecessary_null_comparison
    if (response != null) {
      // ignore: unused_local_variable
      String user = jsonEncode(store);
      String details = json.encode(response.data);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => QrCodeGene(
            userDetails: user,
            paymentDetails: details,
          ),
          fullscreenDialog: true,
        ),
      );
    } else {
      showLoading("No Response!");
    }
  }

  void _openBottomSheet() {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return _getCurrency();
        });
  }

  Widget _getCurrency() {
    final currencies = [
      FlutterwaveCurrency.UGX,
      FlutterwaveCurrency.GHS,
      FlutterwaveCurrency.NGN,
      FlutterwaveCurrency.RWF,
      FlutterwaveCurrency.KES,
      FlutterwaveCurrency.XAF,
      FlutterwaveCurrency.XOF,
      FlutterwaveCurrency.ZMW
    ];
    return Container(
      height: 250,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: ListView(
        children: currencies
            .map((currency) => ListTile(
                  onTap: () => {this._handleCurrencyTap(currency)},
                  title: Column(
                    children: [
                      Text(
                        currency,
                        textAlign: TextAlign.start,
                        style: const TextStyle(color: Colors.black),
                      ),
                      const SizedBox(height: 4),
                      const Divider(height: 1)
                    ],
                  ),
                ))
            .toList(),
      ),
    );
  }

  _handleCurrencyTap(String currency) {
    this.setState(() {
      this.selectedCurrency = currency;
      this.currencyController.text = currency;
    });
    Navigator.pop(this.context);
  }

  Future<void> showLoading(String? message) {
    return showDialog(
      context: this.context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            margin: const EdgeInsets.fromLTRB(30, 20, 30, 20),
            width: double.infinity,
            height: 50,
            child: Text(message!),
          ),
        );
      },
    );
  }
}
