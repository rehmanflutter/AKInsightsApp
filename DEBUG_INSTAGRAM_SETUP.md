# Instagram Setup Debugging Guide

## ❌ Error: "Failed to get access token"

Yeh error 3 reasons se aa sakta hai:

---

## Reason 1: Backend Server Nahi Chal Raha (Most Common)

### Check Karo:
```bash
curl http://localhost:3000/health
```

**Agar error aaye:**
```
curl: (7) Failed to connect to localhost port 3000
```

**Matlab:** Backend server nahi chal raha!

### Fix:
```bash
# New terminal kholo
cd /Users/rehman/Downloads/ak_insights_app/backend

# Pehle install karo (if not done)
npm install

# Start karo
npm start
```

**Dikhe ga:**
```
🚀 Instagram API Proxy Server running on port 3000
📍 Health check: http://localhost:3000/health
```

---

## Reason 2: Instagram App Configuration Galat Hai

### Step-by-Step Check Karo:

#### 1. Facebook Developer Console Check
Go to: https://developers.facebook.com/apps/

**Your App ID:** `1165210255788505`

1. Click on your app
2. Left sidebar → "Instagram Basic Display"
3. Scroll down to "User Token Generator"

#### 2. Valid OAuth Redirect URIs Check
**IMPORTANT:** Yeh EXACT hona chahiye:

```
https://localhost/callback
```

**Common Mistakes:**
- ❌ `http://localhost/callback` (http - wrong!)
- ❌ `https://localhost:8080/callback` (port - wrong!)
- ❌ `https://localhost/callback/` (trailing slash - wrong!)
- ✅ `https://localhost/callback` (CORRECT!)

#### 3. Instagram Tester Account Check

1. Scroll to "User Token Generator"
2. Click "Add or Remove Instagram Testers"
3. Enter YOUR Instagram username
4. Save

Then on Instagram:
1. Open Instagram app/website
2. Settings → Apps and Websites
3. Tester Invites
4. Accept invite for your app

#### 4. App Mode Check

Your app should be in **"Development Mode"**, not "Live Mode"

---

## Reason 3: Code Galat Hai Ya Expire Ho Gaya

Authorization code sirf **60 seconds** ke liye valid hota hai!

### Fix:
1. Close Instagram dialog
2. Click "Login with Instagram" again
3. Fresh flow start karo
4. Code jaldi paste karo (within 60 seconds)

---

## 🔍 Detailed Debugging

### Test 1: Backend Server
```bash
# Terminal 1
cd backend
npm start

# Should see:
🚀 Instagram API Proxy Server running on port 3000
```

### Test 2: Health Check
```bash
curl http://localhost:3000/health

# Should return:
{"status":"OK","message":"Instagram API Proxy is running"}
```

### Test 3: Instagram App Settings

Go to: https://developers.facebook.com/apps/1165210255788505/instagram-basic-display/basic-display/

**Check these settings:**

1. **Client OAuth Settings:**
   - Valid OAuth Redirect URIs: `https://localhost/callback`
   - Deauthorize Callback URL: `https://localhost/deauth`
   - Data Deletion Request URL: `https://localhost/delete`

2. **Permissions:**
   - `user_profile`
   - `user_media`

3. **App Mode:**
   - Development (not Live)

---

## 🛠️ Common Fixes

### Fix 1: Redirect URI Mismatch

**In Facebook Developer Console:**
1. Instagram Basic Display → Basic Display
2. Valid OAuth Redirect URIs:
   ```
   https://localhost/callback
   ```
3. Save Changes

**In Your Code:**
`lib/services/instagram_config.dart` should have:
```dart
static const String redirectUri = 'https://localhost/callback';
```

Both should EXACTLY match!

### Fix 2: App Not in Development Mode

1. App Dashboard → Settings → Basic
2. App Mode: Switch to "Development"
3. Save

### Fix 3: Instagram Account Not a Tester

1. Instagram Basic Display → User Token Generator
2. Add Instagram Testers
3. Enter your Instagram username
4. Save
5. Go to Instagram → Accept invite

### Fix 4: Backend Not Running

```bash
# Kill any old processes
lsof -ti:3000 | xargs kill -9

# Start fresh
cd backend
npm start
```

---

## 🧪 Test OAuth Flow Manually

### Step 1: Get Authorization URL
Copy this URL (replace with your App ID):
```
https://api.instagram.com/oauth/authorize?client_id=1165210255788505&redirect_uri=https://localhost/callback&scope=user_profile,user_media&response_type=code
```

### Step 2: Open in Browser
Paste in browser, login with Instagram

### Step 3: Check Redirect
After authorization, you'll be redirected to:
```
https://localhost/callback?code=XXXXXXXXXX
```

**If you see error instead:**
- Check redirect URI in Facebook console
- Check Instagram tester status
- Check app is in Development mode

### Step 4: Test Backend with Code
```bash
curl -X POST http://localhost:3000/api/instagram/token \
  -H "Content-Type: application/json" \
  -d '{"code":"YOUR_CODE_HERE"}'
```

**Success Response:**
```json
{
  "access_token": "IGQ...",
  "user_id": "12345..."
}
```

**Error Response:**
```json
{
  "error": "...",
  "details": "..."
}
```

---

## 📋 Complete Checklist

Before trying to login:

- [ ] Backend server running (`npm start` in backend folder)
- [ ] Health check passes (`curl http://localhost:3000/health`)
- [ ] Redirect URI is EXACTLY: `https://localhost/callback`
- [ ] Your Instagram account is added as tester
- [ ] Tester invite accepted on Instagram
- [ ] App is in Development mode
- [ ] App ID and Secret are correct in code

---

## 🚨 Still Not Working?

### Get Detailed Error:

1. Open browser DevTools (F12)
2. Go to Console tab
3. Try login again
4. Look for errors in console

**Common errors:**

1. **"Failed to fetch"** → Backend not running
2. **"Invalid redirect_uri"** → URI mismatch
3. **"User not authorized"** → Not a tester
4. **"Code has expired"** → Too slow, try again

### Backend Logs:

Backend terminal mein detailed errors dikhengi:
```
Error getting access token: {
  "error_type": "...",
  "code": 400,
  "error_message": "..."
}
```

---

## 💡 Pro Tips

1. **Code expires fast** - Paste quickly!
2. **One code, one use** - Can't reuse same code
3. **Clear browser cache** if weird issues
4. **Use incognito mode** to test fresh
5. **Check backend logs** for exact error

---

## 🎯 Most Common Issue: Backend Not Running

**90% of time, yeh issue hai:**

```bash
# Solution:
cd backend
npm install  # If first time
npm start    # Start server

# Keep this terminal running!
```

Then in another terminal:
```bash
flutter run -d chrome
```

---

## ✅ Success Looks Like:

**Backend Terminal:**
```
🚀 Instagram API Proxy Server running on port 3000
POST /api/instagram/token 200 - 1234ms
```

**Flutter App:**
```
Token received successfully
Fetching user profile...
Username: your_instagram_username
```

**Browser:**
```
Dashboard shows your real Instagram data!
```

---

## 📞 Need More Help?

Check these files:
- `CORS_ISSUE_EXPLAINED.md` - Why backend is needed
- `SETUP_BACKEND.md` - How to setup backend
- `backend/README.md` - Backend documentation

**Common Commands:**
```bash
# Check backend
curl http://localhost:3000/health

# Restart backend
cd backend && npm start

# Check ports in use
lsof -i :3000
lsof -i :8080

# Kill processes
lsof -ti:3000 | xargs kill -9
```
