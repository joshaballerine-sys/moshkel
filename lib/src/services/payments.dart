import 'dart:convert';
import 'package:http/http.dart' as http;

class PaymentsService {
  final String apiKey;
  PaymentsService(this.apiKey);

  Future<String?> createInvoice({
    required double amountUsd,
    required String orderId,
    required String successUrl,
    required String cancelUrl,
  }) async {
    final url = Uri.parse('https://api.nowpayments.io/v1/invoice');
    final body = jsonEncode({
      "price_amount": amountUsd,
      "price_currency": "usd",
      "order_id": orderId,
      "order_description": "InvestAi deposit",
      "success_url": successUrl,
      "cancel_url": cancelUrl
    });
    final res = await http.post(url, headers: {
      "x-api-key": apiKey,
      "Content-Type": "application/json",
    }, body: body);
    if (res.statusCode == 200 || res.statusCode == 201) {
      final data = jsonDecode(res.body);
      return data["invoice_url"];
    }
    return null;
  }
}
