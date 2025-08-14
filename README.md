# InvestAi (Flutter) — GitHub Actions APK

This repo builds an Android APK automatically on GitHub Actions.

## Steps
1. Create a new GitHub repository and upload this project (branch `main`).
2. In repo settings → Secrets and variables → Actions → **New repository secret**:
   - Name: `NOWPAY_API_KEY`
   - Value: your NOWPayments API key
3. Go to **Actions** → run **Build InvestAi APK**.
4. Download the artifact `investai-apk` (contains `app-release.apk`).

Notes:
- Region guard blocks likely Iran locales except whitelisted email `nimafarzadi21@gmail.com`.
- Yields (3% daily button) and referral rewards are **display-only**.
- Invoice creation shows snackbar with the URL; replace with WebView/browser open for real flow.
