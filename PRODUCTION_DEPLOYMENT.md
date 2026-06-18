# 🌐 Production Deployment Guide

## After Instagram App Goes LIVE

Once your app is approved for Live mode, you need to deploy it for public use.

---

## 📋 Deployment Checklist

### Part 1: Backend (Node.js Server)

Your backend MUST be deployed to a public server (not localhost).

### Part 2: Frontend (Flutter Web)

Your Flutter app needs to be deployed to a hosting service.

### Part 3: Update URLs

Update Instagram OAuth redirect URIs to production URLs.

---

## 🚀 Backend Deployment Options

### **Option 1: Render.com (Free, Recommended)**

**Pros:**
- ✅ Free tier
- ✅ Auto-deploy from GitHub
- ✅ Easy setup
- ✅ HTTPS included

**Steps:**

1. **Push backend to GitHub:**
   ```bash
   cd /Users/rehman/Downloads/ak_insights_app
   git init
   git add backend/
   git commit -m "Add backend"
   git remote add origin https://github.com/yourusername/ak-insights-backend
   git push -u origin main
   ```

2. **Create Render account:**
   - Go to: https://render.com
   - Sign up with GitHub

3. **New Web Service:**
   - Click "New" → "Web Service"
   - Connect GitHub repo
   - Root Directory: `backend`
   - Build Command: `npm install`
   - Start Command: `npm start`
   - Click "Create Web Service"

4. **Get URL:**
   - Render gives you: `https://your-app-name.onrender.com`
   - Test: `https://your-app-name.onrender.com/health`

5. **Update Flutter code:**
   ```dart
   // lib/services/instagram_service.dart
   static const String proxyUrl = 'https://your-app-name.onrender.com';
   ```

---

### **Option 2: Railway.app (Free)**

1. Go to: https://railway.app
2. Sign up with GitHub
3. "New Project" → "Deploy from GitHub"
4. Select backend folder
5. Deploy!
6. Get URL: `https://your-app.railway.app`

---

### **Option 3: Heroku**

```bash
# Install Heroku CLI
brew install heroku/brew/heroku

# Login
heroku login

# Create app
cd backend
heroku create your-app-name

# Deploy
git init
git add .
git commit -m "Initial commit"
heroku git:remote -a your-app-name
git push heroku main

# Get URL
heroku open
```

---

## 🎨 Frontend Deployment Options

### **Option 1: Netlify (Easiest)**

**Steps:**

1. **Build Flutter Web:**
   ```bash
   cd /Users/rehman/Downloads/ak_insights_app
   flutter build web
   ```

2. **Deploy to Netlify:**
   - Go to: https://netlify.com
   - Drag `build/web` folder to Netlify
   - Get URL: `https://your-app.netlify.app`

3. **Custom domain (optional):**
   - Domain Settings → Add custom domain
   - Example: `akinsights.com`

---

### **Option 2: Vercel**

```bash
# Install Vercel CLI
npm i -g vercel

# Build
flutter build web

# Deploy
cd build/web
vercel

# Follow prompts
```

---

### **Option 3: Firebase Hosting**

```bash
# Install Firebase CLI
npm install -g firebase-tools

# Login
firebase login

# Init
firebase init hosting

# Build
flutter build web

# Deploy
firebase deploy
```

---

### **Option 4: GitHub Pages**

```bash
# Build with base-href
flutter build web --base-href "/ak-insights/"

# Push to gh-pages branch
cd build/web
git init
git add .
git commit -m "Deploy"
git remote add origin https://github.com/yourusername/ak-insights
git push -f origin main:gh-pages

# Access at: https://yourusername.github.io/ak-insights/
```

---

## 🔧 Update Instagram App Settings for Production

### **Step 1: Update OAuth Redirect URIs**

Go to Facebook Developer Console:
```
https://developers.facebook.com/apps/1165210255788505/instagram-basic-display/basic-display/
```

**Valid OAuth Redirect URIs:**
```
https://your-app.netlify.app/callback
https://akinsights.com/callback (if custom domain)
```

**Rules:**
- Must be HTTPS (not HTTP)
- Must match exactly
- Add ALL production URLs

**Click "Save Changes"**

---

### **Step 2: Update Flutter Config**

**File: `lib/services/instagram_config.dart`**

```dart
class InstagramConfig {
  static const String appId = '1165210255788505';
  static const String appSecret = 'f3b0c680d7af049b564e26dbf9c9447c';

  // Production redirect URI
  static const String redirectUri = 'https://your-app.netlify.app/callback';

  // Production backend proxy
  static const String proxyUrl = 'https://your-backend.onrender.com';

  // ... rest of code
}
```

**Rebuild and redeploy:**
```bash
flutter build web
# Upload to Netlify again
```

---

## ✅ Complete Production Setup Example

### **Scenario:**
- Backend on Render: `https://ak-insights-api.onrender.com`
- Frontend on Netlify: `https://ak-insights.netlify.app`

### **Configuration:**

**Instagram Developer Console:**
```
Valid OAuth Redirect URIs:
https://ak-insights.netlify.app/callback

Deauthorize Callback URL:
https://ak-insights.netlify.app/deauth

Data Deletion Request URL:
https://ak-insights.netlify.app/delete
```

**Flutter Config (`instagram_config.dart`):**
```dart
static const String redirectUri = 'https://ak-insights.netlify.app/callback';
```

**Flutter Service (`instagram_service.dart`):**
```dart
static const String proxyUrl = 'https://ak-insights-api.onrender.com';
```

---

## 🧪 Testing Production Setup

### **Test Backend:**
```
https://your-backend.onrender.com/health

Should return:
{"status":"OK","message":"Instagram API Proxy is running"}
```

### **Test Frontend:**
```
https://your-app.netlify.app

Should load app
```

### **Test Instagram Login:**
1. Open frontend URL
2. Click "Login with Instagram"
3. Should redirect to Instagram
4. Login
5. Should redirect back to your app (not localhost!)
6. Data should load

---

## 🎯 Post-Deployment Checklist

- [ ] Backend deployed to Render/Railway/Heroku
- [ ] Backend health check working
- [ ] Frontend built with `flutter build web`
- [ ] Frontend deployed to Netlify/Vercel/Firebase
- [ ] Instagram OAuth redirect URIs updated (production URLs)
- [ ] Flutter config updated (production backend URL)
- [ ] Flutter config updated (production redirect URI)
- [ ] Rebuilt and redeployed after config changes
- [ ] Tested backend health endpoint
- [ ] Tested frontend loads
- [ ] Tested Instagram login flow end-to-end
- [ ] App in LIVE mode (not Development)
- [ ] Shared link with users!

---

## 📊 Architecture Diagram

```
┌─────────────────────────┐
│ User's Browser          │
│ https://your-app.       │
│ netlify.app             │
└─────────────────────────┘
           ↓ ↑
     [OAuth Flow]
           ↓ ↑
┌─────────────────────────┐
│ Backend Server          │
│ https://your-api.       │
│ onrender.com            │
└─────────────────────────┘
           ↓ ↑
    [API Calls]
           ↓ ↑
┌─────────────────────────┐
│ Instagram API           │
│ api.instagram.com       │
└─────────────────────────┘
```

---

## 💡 Tips

### **Free Tiers:**
- Render: 750 hours/month free
- Netlify: Unlimited bandwidth (fair use)
- Railway: $5 free credit/month
- Vercel: Unlimited sites

### **Custom Domain:**
- Buy domain: Namecheap ($10/year)
- Point to Netlify/Vercel
- SSL auto-included
- Professional look!

### **Monitoring:**
- Backend logs: Check Render/Railway dashboard
- Frontend logs: Browser DevTools
- Instagram API errors: Backend logs

---

## 🚨 Common Issues

### **Issue: "Redirect URI mismatch" in production**
**Fix:** Make sure production URL in Instagram console EXACTLY matches your deployed URL (including https://)

### **Issue: Backend CORS error**
**Fix:** Backend `cors()` should allow your frontend domain:
```javascript
app.use(cors({
  origin: 'https://your-app.netlify.app',
  credentials: true
}));
```

### **Issue: "Failed to fetch" in production**
**Fix:** Update `proxyUrl` in Flutter code to production backend URL

---

## ✅ Success!

**Your app is now:**
- ✅ Live on internet
- ✅ Accessible to anyone
- ✅ Using real Instagram OAuth
- ✅ Fetching real data
- ✅ Production-ready!

**Share your app:**
```
Your app: https://your-app.netlify.app
Backend API: https://your-api.onrender.com
```

**Users can:**
- Visit your URL
- Login with their Instagram
- See their real data
- Use all features!

---

**Ready to deploy? Follow steps above or let me know if you need help!** 🚀
