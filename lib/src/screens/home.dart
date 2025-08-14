import 'dart:math';
import 'package:flutter/material.dart';
import '../utils/guard.dart';
import 'deposit.dart';
import 'referrals.dart';
import 'about.dart';
import 'terms.dart';
import 'signin.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? email;
  double balance = 0.0;
  DateTime? depositAt;
  String myRefCode = '';
  int referralCount = 0;

  @override
  void initState() {
    super.initState();
    myRefCode = _generateRef();
  }

  String _generateRef() {
    final rnd = Random().nextInt(999999);
    return "INV${rnd.toString().padLeft(6, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    final isIran = AccessGuard.isLikelyIran();
    final isWhitelisted = (email ?? '').toLowerCase() == 'nimafarzadi21@gmail.com';
    final lockedUntil = depositAt != null ? depositAt!.add(const Duration(days: 30)) : null;

    return Scaffold(
      appBar: AppBar(
        title: const Text('InvestAi'),
        actions: [
          IconButton(
            onPressed: () async {
              final newEmail = await Navigator.push(context, MaterialPageRoute(builder: (_)=> const SignInScreen()));
              if (newEmail is String) setState(()=> email = newEmail);
            },
            icon: const Icon(Icons.person),
            tooltip: 'Sign in',
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: isIran && !isWhitelisted
          ? const Center(child: Text("This app isn't available in your region."))
          : ListView(
              children: [
                Text('Welcome, ${email ?? "Guest"}', style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 12),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Portfolio Value', style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Text("\$${balance.toStringAsFixed(2)}", style: const TextStyle(fontSize: 28)),
                        if (lockedUntil != null) ...[
                          const SizedBox(height: 8),
                          Text('Locked until: ${lockedUntil.toIso8601String().split('T').first}'),
                          const SizedBox(height: 8),
                          const Text('Funds are locked for 30 days. Early withdrawal = principal only, no yield.'),
                          const SizedBox(height: 8),
                          const Text('All rewards/yields are displayed only; not withdrawable.'),
                        ]
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(child: FilledButton(onPressed: () async {
                      final res = await Navigator.push(context, MaterialPageRoute(builder: (_)=> const DepositScreen()));
                      if (res is Map) {
                        final amount = (res['amount'] as num).toDouble();
                        setState((){
                          balance += amount;
                          depositAt = DateTime.now();
                        });
                      }
                    }, child: const Text('Deposit'))),
                    const SizedBox(width: 8),
                    Expanded(child: OutlinedButton(onPressed: (){}, child: const Text('Withdraw'))),
                  ],
                ),
                const SizedBox(height: 12),
                ListTile(
                  tileColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                  title: const Text('Referrals'),
                  subtitle: Text("1st: 20%, then +5% each to 70% — count: $referralCount — code: $myRefCode"),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () async {
                    final res = await Navigator.push(context, MaterialPageRoute(builder: (_)=> ReferralsScreen(myCode: myRefCode)));
                    if (res is int) setState(()=> referralCount += res);
                  },
                ),
                const SizedBox(height: 12),
                ListTile(title: const Text('About'), onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_)=> const AboutScreen()))),
                ListTile(title: const Text('Terms'), onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_)=> const TermsScreen()))),
              ],
            ),
      ),
      floatingActionButton: (depositAt!=null) ? FloatingActionButton.extended(
        onPressed: () { setState(()=> balance *= 1.03); },
        label: const Text('Daily Yield (display-only)'),
        icon: const Icon(Icons.trending_up),
      ) : null,
    );
  }
}
