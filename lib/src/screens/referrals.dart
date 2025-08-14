import 'package:flutter/material.dart';
import '../services/referrals.dart';

class ReferralsScreen extends StatefulWidget {
  final String myCode;
  const ReferralsScreen({super.key, required this.myCode});
  @override
  State<ReferralsScreen> createState() => _ReferralsScreenState();
}

class _ReferralsScreenState extends State<ReferralsScreen> {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Referrals')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Your code: ${widget.myCode}', style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (_, i){
                  final n = i+1;
                  final p = ReferralEngine.rewardPercentFor(n);
                  return ListTile(
                    title: Text('Referral #$n'),
                    subtitle: Text('Reward: ${p.toStringAsFixed(0)}% of their deposit'),
                    trailing: IconButton(icon: const Icon(Icons.add), onPressed: (){ setState(()=> count++); }),
                  );
                },
              ),
            ),
            FilledButton(onPressed: ()=> Navigator.pop(context, count), child: Text('Close (added $count new)'))
          ],
        ),
      ),
    );
  }
}
