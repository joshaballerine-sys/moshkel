class ReferralEngine {
  static double rewardPercentFor(int n) {
    if (n <= 0) return 0;
    final p = 20 + (n - 1) * 5;
    return p > 70 ? 70 : p.toDouble();
  }
}
