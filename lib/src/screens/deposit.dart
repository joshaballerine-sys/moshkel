import 'package:flutter/material.dart';
import '../services/payments.dart';

class DepositScreen extends StatefulWidget {
  const DepositScreen({super.key});
  @override
  State<DepositScreen> createState() => _DepositScreenState();
}

class _DepositScreenState extends State<DepositScreen> {
  final amountCtrl = TextEditingController();
  final refCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Deposit')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: amountCtrl, decoration: const InputDecoration(labelText: 'Amount (USD)'), keyboardType: TextInputType.number),
            const SizedBox(height: 12),
            TextField(controller: refCtrl, decoration: const InputDecoration(labelText: 'Referral code (optional)')),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () async {
                final amount = double.tryParse(amountCtrl.text) ?? 0;
                if (amount <= 0) return;
                final service = PaymentsService(const String.fromEnvironment('NOWPAY_API_KEY', defaultValue: ''));
                final url = await service.createInvoice(
                  amountUsd: amount,
                  orderId: DateTime.now().millisecondsSinceEpoch.toString(),
                  successUrl: "https://example.com/success",
                  cancelUrl: "https://example.com/cancel",
                );
                if (!mounted) return;
                if (url != null) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Open payment URL:\n$url')));
                  Navigator.pop(context, {"amount": amount});
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Failed to create invoice')));
                }
              },
              child: const Text('Pay Now'),
            )
          ],
        ),
      ),
    );
  }
}
