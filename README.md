https://ak-insights-app.vercel.app/
<img width="1041" height="965" alt="Screenshot 2026-06-18 at 10 57 28 AM" src="https://github.com/user-attachments/assets/32d089a0-b006-437d-ba47-31bc1050ee50" />
<img width="1041" height="965" alt="Screenshot 2026-06-18 at 10 57 18 AM" src="https://github.com/user-attachments/assets/510560bc-04e7-4e9b-a8f7-359e67a9d5e5" />


# AK Insights — Flutter Web (Demo UI)

A 100% responsive, animated Flutter Web app with a pro gradient theme
(purple → magenta → orange), glassmorphism cards, hover effects, and
staggered list animations. Built for: Analyze score, Posts/Followers/
Following stats, Watch Secretly, Profile Visitors, Who Blocked Me,
Secret Stalkers, Followers Gained/Lost, Not Following Back, Not My
Followers.

## ⚠️ Important honesty note

Instagram's official API does **not** provide "who viewed my profile",
"secret stalkers", or "who blocked me" data — these don't exist as a
real feature for any third-party app. Apps that claim to offer this
either show fabricated numbers or ask for your real Instagram login to
scrape your account, which violates Instagram's Terms of Service and
risks your account/security (a classic phishing pattern).

This project is a **UI/UX design template** with realistic sample data
so it looks and feels complete. The login screen does **not** send
credentials anywhere — it's just a styled form that transitions into
the dashboard after a short simulated delay. If you want this to be a
real product, connect "Overview" stats to Instagram's official Graph
API (for accounts you own/manage) and be upfront with users about what
data is and isn't actually available.

## How to run

This was generated as Dart source files only (no platform folders),
since Flutter projects need to be scaffolded by the Flutter CLI itself.

```bash
# 1. Make sure Flutter is installed: https://docs.flutter.dev/get-started/install

# 2. Create a fresh project shell
flutter create ak_insights_app
cd ak_insights_app

# 3. Replace the generated lib/ folder and pubspec.yaml with the ones
#    from this delivery (overwrite them)

# 4. Get packages
flutter pub get

# 5. Run on web
flutter run -d chrome

# 6. Build for deployment
flutter build web
# output will be in build/web — host it anywhere (Firebase Hosting,
# Netlify, Vercel, GitHub Pages, etc.)
```

## Structure

```
lib/
  main.dart
  theme/app_theme.dart          # colors + gradients + ThemeData
  models/person.dart            # Person model
  data/sample_data.dart         # demo/sample lists (replace with real API later)
  widgets/                      # reusable: glass card, counters, gauge, list tiles
  screens/
    splash_screen.dart
    login_screen.dart           # UI only, no real auth
    dashboard_shell.dart        # responsive sidebar (desktop) / bottom nav (mobile)
    sections/
      overview_section.dart           # Analyze % + Posts/Followers/Following
      stalk_section.dart              # Watch Secretly / Visitors / Blocked / Stalkers
      followers_change_section.dart   # Gained / Lost
      not_following_section.dart      # Not Follow Back / Not My Followers
```

## Responsiveness

`dashboard_shell.dart` switches between a left sidebar (≥900px width)
and a bottom nav bar (<900px). Stat grids reflow from 3 → 2 → 1 columns
based on width. Everything scrolls cleanly on mobile, tablet, and
desktop browsers.
