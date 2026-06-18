# ⚡ QUICK FIX - Backend Server Start Karo!

## ❌ Aapka Error:
```
Failed to get access token. Please check your Instagram app configuration.
```

## ✅ Solution (2 Minutes):

Backend server **NAHI CHAL RAHA** - that's the problem!

---

## 🚀 Step-by-Step Fix:

### Step 1: NPM Fix (One Time - Password Puchega)
```bash
sudo chown -R $(whoami) "/Users/rehman/.npm"
```
Password puche ga - apna Mac password dalo.

### Step 2: Install Backend
```bash
cd /Users/rehman/Downloads/ak_insights_app/backend
npm install
```

Wait karo - packages install honge (30 seconds).

### Step 3: Start Backend Server
```bash
npm start
```

**Dikhe ga:**
```
🚀 Instagram API Proxy Server running on port 3000
📍 Health check: http://localhost:3000/health
📍 Token endpoint: http://localhost:3000/api/instagram/token
```

### Step 4: Test Backend
New browser tab kholo:
```
http://localhost:3000/health
```

**Dikhe ga:**
```json
{
  "status": "OK",
  "message": "Instagram API Proxy is running"
}
```

✅ **Backend ready!**

---

## 🎨 Ab Flutter App Chalao

**New Terminal** kholo (backend wala running rehne do):

```bash
cd /Users/rehman/Downloads/ak_insights_app
flutter run -d chrome --web-port=8080
```

---

## 🧪 Ab Login Test Karo

1. Browser mein Flutter app khulega: `http://localhost:8080`
2. Click "Login with Instagram"
3. Dialog mein "Open Instagram Login" click karo
4. Instagram login karo
5. Allow karo
6. Code copy karo
7. Paste karo
8. **Ab kaam karega!** ✅

---

## 📝 Important:

**2 Terminals Zaroor Chalne Chahiye:**

**Terminal 1 (Backend):**
```
cd backend
npm start
(Running... don't close!)
```

**Terminal 2 (Flutter):**
```
flutter run -d chrome
(Running... don't close!)
```

---

## ❓ Agar Phir Bhi Error?

### Error 1: "Failed to fetch"
→ Backend nahi chal raha, Step 3 dobara karo

### Error 2: "Invalid redirect_uri"
→ Facebook console mein jao: https://developers.facebook.com/apps/1165210255788505/instagram-basic-display/basic-display/

Valid OAuth Redirect URIs mein add karo:
```
https://localhost/callback
```
(exactly yeh - http nahi, https!)

### Error 3: "User not authorized"
→ Instagram account ko tester banana padega:
1. Facebook console → Instagram Basic Display → User Token Generator
2. "Add or Remove Instagram Testers"
3. Apna username add karo
4. Instagram app/website pe jao → Settings → Apps → Accept invite

---

## ✅ Working Setup:

```
Terminal 1:              Terminal 2:
┌────────────────┐      ┌────────────────┐
│ cd backend     │      │ flutter run    │
│ npm start      │      │ -d chrome      │
│                │      │                │
│ ✅ Running...  │      │ ✅ Running...  │
└────────────────┘      └────────────────┘
        ↓                      ↓
    Port 3000             Port 8080
   (Backend API)        (Flutter App)
```

Browser:
- Backend: http://localhost:3000/health ✅
- App: http://localhost:8080 ✅
- Login works! ✅

---

## 🎯 Commands Summary:

```bash
# Terminal 1 (Backend)
sudo chown -R $(whoami) "/Users/rehman/.npm"  # One time
cd backend
npm install                                    # One time
npm start                                      # Every time

# Terminal 2 (Flutter) - new terminal
flutter run -d chrome --web-port=8080
```

---

**Detailed guide:** `DEBUG_INSTAGRAM_SETUP.md`

**Problem solved!** Backend server start karo, sab kaam karega! 🚀
