# Backend Setup Guide - CORS Fix

## ❌ Problem You're Seeing:

```
Exception getting access token: ClientException: Failed to fetch
```

Yeh **CORS error** hai. Instagram API browser se direct calls allow nahi karta.

## ✅ Solution: Backend Proxy Server

Aapko ek simple Node.js server run karna hoga jo Instagram API ke beech mein kaam karega:

```
Flutter App (Web) → Backend Server → Instagram API
                  ←                ←
```

---

## 🚀 Setup Steps (Bahut Easy!)

### Step 1: Fix NPM Permissions (One Time)
Terminal mein yeh command chalao:

```bash
sudo chown -R $(whoami) "/Users/rehman/.npm"
```

Password puche ga - apna Mac password dalo.

### Step 2: Install Backend Dependencies
```bash
cd /Users/rehman/Downloads/ak_insights_app/backend
npm install
```

Yeh 3 packages install karega:
- express (web server)
- cors (CORS handling)
- axios (HTTP requests)

### Step 3: Start Backend Server
```bash
npm start
```

Aapko dikhe ga:
```
🚀 Instagram API Proxy Server running on port 3000
📍 Health check: http://localhost:3000/health
```

### Step 4: Keep Server Running
Backend server ko **running rakhna hai** jab bhi Flutter app use karo!

**2 Terminals Use Karo:**

**Terminal 1 (Backend):**
```bash
cd backend
npm start
```

**Terminal 2 (Flutter App):**
```bash
flutter run -d chrome --web-port=8080
```

---

## 🧪 Test Karo

### Test 1: Check Backend is Running
Browser mein kholo: `http://localhost:3000/health`

Dikhe ga:
```json
{
  "status": "OK",
  "message": "Instagram API Proxy is running"
}
```

### Test 2: Login with Instagram
1. Flutter app kholo: `http://localhost:8080`
2. "Login with Instagram" click karo
3. OAuth flow follow karo
4. Ab **CORS error nahi aaye ga!** ✅

---

## 📱 Alternative: Mobile App (No Backend Needed!)

Agar backend nahi setup karna, toh **mobile app** use karo:

```bash
# Android
flutter run -d android

# iOS
flutter run -d ios
```

Mobile apps mein CORS issue nahi hota - direct Instagram API calls kaam karti hain!

---

## 🌐 Deploy Backend (Production Ke Liye)

### Option 1: Render.com (Free & Easy)
1. Jao: https://render.com
2. Sign up (GitHub se)
3. New → Web Service
4. Connect repo
5. Build command: `cd backend && npm install`
6. Start command: `cd backend && npm start`
7. Deploy!

Aapko URL milega jaise: `https://your-app.onrender.com`

Phir Flutter code mein update karo:
```dart
// lib/services/instagram_service.dart
static const String proxyUrl = 'https://your-app.onrender.com';
```

### Option 2: Railway.app (Free)
1. Jao: https://railway.app
2. New Project → Deploy from GitHub
3. Select backend folder
4. Done!

### Option 3: Vercel (Free)
```bash
cd backend
npm i -g vercel
vercel
```

---

## ❓ FAQs

**Q: Har baar backend server start karna padega?**
A: Haan, jab bhi Flutter web app use karo. Ya deploy kar do online.

**Q: Mobile app mein backend chahiye?**
A: NAHI! Mobile mein direct Instagram API kaam karta hai.

**Q: Backend mein kya ho raha hai?**
A: Simple! Aapki requests Instagram ko forward kar raha hai aur response wapas bhej raha hai. CORS issue bypass ho jata hai.

**Q: Secure hai?**
A: Haan! OAuth tokens secure hain, passwords store nahi hote.

---

## 🎯 Quick Commands

```bash
# NPM fix (one time)
sudo chown -R $(whoami) "/Users/rehman/.npm"

# Install
cd backend
npm install

# Run backend
npm start

# (New terminal) Run Flutter
cd ..
flutter run -d chrome

# Check backend health
curl http://localhost:3000/health
```

---

## ✅ Summary

1. **Local Development:** Backend server run karo + Flutter app
2. **Production:** Backend deploy karo (Render/Railway/Vercel)
3. **Mobile:** No backend needed!

Backend setup simple hai - bas ek baar setup karo, phir sab kaam karega! 🚀
