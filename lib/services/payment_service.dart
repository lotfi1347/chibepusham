import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_stripe/flutter_stripe.dart';

class PaymentService {
  final String backendUrl = "https://YOUR-RAILWAY-URL";

  Future<void> payForItem({
    required String itemId,
    required int price,
  }) async {
    // 1. درخواست ساخت payment intent از سرور
    final response = await http.post(
      Uri.parse("$backendUrl/create-payment-intent"),
      body: jsonEncode({
        "itemId": itemId,
        "amount": price,
      }),
      headers: {
        "Content-Type": "application/json",
      },
    );

    final data = jsonDecode(response.body);

    final clientSecret = data["clientSecret"];

    // 2. Stripe payment sheet
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: clientSecret,
        merchantDisplayName: "AR Fashion App",
      ),
    );

    await Stripe.instance.presentPaymentSheet();
  }
}