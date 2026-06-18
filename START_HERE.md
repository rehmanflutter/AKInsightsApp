# 🚀 START HERE - Complete Setup

## ⚡ Problem: Backend Server Nahi Chal Raha

**Current Error:**
```
Failed to get access token. Please check your Instagram app configuration.
```

**Real Issue:** Backend proxy server start nahi hua hai!

---

## 📋 **STEP-BY-STEP (Copy/Paste Commands)**

### **STEP 1: Open Terminal**

Mac mein:
1. Press `Cmd + Space`
2. Type "Terminal"
3. Press Enter

---

### **STEP 2: Fix NPM Permissions** (One Time Only)

**Copy yeh command and paste in terminal:**

```bash
sudo chown -R $(whoami) "/Users/rehman/.npm"
```

Press Enter → **Password puchega** → Type your Mac password (invisible rehti hai, normal hai) → Press Enter

**Kuch dikhe ga:**
```
Password: [typing... invisible]
[Command runs silently]
```

✅ **Done! NPM fixed.**

---

### **STEP 3: Install Backend Dependencies**

**Copy/paste yeh commands:**

```bash
cd /Users/rehman/Downloads/ak_insights_app/backend
npm install
```

**Dikhe ga:**
```
added 57 packages in 10s
```

Wait karo - 30-60 seconds lagenge.

✅ **Dependencies installed!**

---

### **STEP 4: Start Backend Server**

**Still in same terminal, run:**

```bash
npm start
```

**Dikhe ga:**
```
> instagram-api-proxy@1.0.0 start
> node server.js

🚀 Instagram API Proxy Server running on port 3000
📍 Health check: http://localhost:3000/health
📍 Token endpoint: http://localhost:3000/api/instagram/token
```

✅ **Backend is running!**

**⚠️ IMPORTANT:** Is terminal ko **OPEN REHNE DO** - close mat karo!

---

### **STEP 5: Test Backend** (New Browser Tab)

Chrome/Safari kholo aur jao:
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

✅ **Backend working perfectly!**

---

### **STEP 6: Flutter App Already Running!**

Aapka Flutter app pehle se chal raha hai:
```
http://localhost:8080
```

Ab refresh karo aur **login try karo!**

---

## 🧪 **LOGIN TEST**

1. Go to: `http://localhost:8080`
2. Click **"Login with Instagram"**
3. Dialog opens → Click **"Open Instagram Login"**
4. New tab → Instagram login karo
5. **Authorize** karo (Allow button)
6. Redirect hoga: `https://localhost/callback?code=XXXXX`
7. **CODE COPY KARO** (part after `code=`)
8. Dialog mein **PASTE KARO**
9. Click **"Submit"**

**✅ Success! Aapka Instagram data show hoga!**

---

## 📊 **Final Setup (2 Terminals)**

### **Terminal 1 (Backend) - Already Running ✅**
```bash
cd /Users/rehman/Downloads/ak_insights_app/backend
npm start

# Output:
🚀 Instagram API Proxy Server running on port 3000
```
**Keep this terminal open!**

### **Terminal 2 (Flutter) - Already Running ✅**
```bash
flutter run -d chrome --web-port=8080

# App at:
http://localhost:8080
```
**Keep this terminal open too!**

---

## ✅ **Checklist**

- [ ] Terminal opened
- [ ] NPM permissions fixed (`sudo chown...`)
- [ ] Dependencies installed (`npm install`)
- [ ] Backend started (`npm start`)
- [ ] Backend health check passed (`http://localhost:3000/health`)
- [ ] Flutter app is at `http://localhost:8080`
- [ ] Instagram login tested
- [ ] Data showing!

---

## 🎯 **Quick Commands Summary**

```bash
# Run these in Terminal (one by one):

# 1. Fix NPM (password puchega)
sudo chown -R $(whoami) "/Users/rehman/.npm"

# 2. Go to backend folder
cd /Users/rehman/Downloads/ak_insights_app/backend

# 3. Install
npm install

# 4. Start (keep running!)
npm start
```

---

## ❓ **Agar Error Aaye?**

### Error 1: "sudo: command not found"
→ Tumhe Terminal use karna hai, not some other app

### Error 2: "npm: command not found"
→ Node.js install nahi hai
→ Download: https://nodejs.org/
→ Install karo, phir try karo

### Error 3: "EACCES permission denied"
→ Step 2 (sudo command) run karo pehle

### Error 4: Backend runs but login fails
→ Check Instagram app settings:
   - Valid OAuth Redirect URIs: `https://localhost/callback`
   - Your Instagram account is added as tester
   - Tester invite accepted

---

## 🎉 **Success Looks Like:**

**Terminal 1 (Backend):**
```
🚀 Instagram API Proxy Server running on port 3000
```

**Browser Tab 1:**
```
http://localhost:3000/health
→ {"status":"OK","message":"Instagram API Proxy is running"}
```

**Browser Tab 2:**
```
http://localhost:8080
→ AK Insights app with Login button
```

**After Login:**
```
Dashboard showing YOUR Instagram data:
- Your username
- Your posts count
- "Real Data" green badge
```

---

## 🚀 **Next Time (After Restart):**

Terminal 1:
```bash
cd /Users/rehman/Downloads/ak_insights_app/backend
npm start
```

Terminal 2:
```bash
cd /Users/rehman/Downloads/ak_insights_app
flutter run -d chrome
```

**That's it!**

---

## 📞 **Need Help?**

Files to read:
- `QUICK_FIX.md` - Super quick guide
- `DEBUG_INSTAGRAM_SETUP.md` - Detailed troubleshooting
- `CORS_ISSUE_EXPLAINED.md` - Why backend is needed
- `SETUP_BACKEND.md` - Complete backend guide

**Common Issue:** 99% time, backend server nahi chal raha hota. Start karo, sab theek ho jayega!

---

**GO! Terminal kholo aur Step 2 se shuru karo!** 🎯
