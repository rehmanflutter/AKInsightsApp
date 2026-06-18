# ⚡ FIX: "Invalid platform app" Error

## ❌ Your Error:
```
Invalid Request: Request parameters are invalid: Invalid platform app
```

This means your **Facebook Developer Console settings are incorrect**.

---

## 🔧 COMPLETE FIX (Step-by-Step with Screenshots Guide)

### **STEP 1: Go to Facebook Developer Console**

Open browser and go to:
```
https://developers.facebook.com/apps/1165210255788505/
```

Login with your Facebook account.

---

### **STEP 2: Check App Mode**

1. Look at top-right corner
2. Should show: **"Development"** (green badge)
3. If it shows **"Live"** → Click it → Switch to **"Development"**

**Why?** Live mode has restrictions. Development mode allows testing.

---

### **STEP 3: Configure Instagram Basic Display**

#### 3A. Click "Instagram Basic Display" in left sidebar

If not visible:
1. Click "Add Product" button
2. Find "Instagram Basic Display"
3. Click "Set Up"

#### 3B. Go to "Basic Display" tab

Should show these sections:
- Client OAuth Settings
- User Token Generator
- Deauthorize
- Data Deletion Request

---

### **STEP 4: Fix Client OAuth Settings** ⚠️ MOST IMPORTANT!

Scroll to **"Valid OAuth Redirect URIs"** field.

**EXACT VALUE TO ENTER:**
```
https://localhost/callback
```

**IMPORTANT RULES:**
- ✅ Use `https://` (NOT `http://`)
- ✅ NO port number (NOT `:8080` or `:3000`)
- ✅ Exactly `/callback` (NOT `/auth` or anything else)
- ✅ NO trailing slash (NOT `/callback/`)

**Common Mistakes:**
- ❌ `http://localhost/callback` (http - WRONG!)
- ❌ `https://localhost:8080/callback` (port - WRONG!)
- ❌ `https://localhost/callback/` (trailing slash - WRONG!)
- ✅ `https://localhost/callback` (CORRECT!)

**After entering, click "Save Changes" button at bottom!**

---

### **STEP 5: Add Other Required URLs**

In same section:

**Deauthorize Callback URL:**
```
https://localhost/deauth
```

**Data Deletion Request URL:**
```
https://localhost/delete
```

Click **"Save Changes"** again!

---

### **STEP 6: Add Instagram Test Account** ⚠️ CRITICAL!

Scroll down to **"User Token Generator"** section.

#### 6A. Click "Add or Remove Instagram Testers"

Opens Instagram Accounts panel.

#### 6B. Enter YOUR Instagram Username

Example: If your Instagram is `@ak_rehman`, enter: `ak_rehman`

Click **"Submit"**

#### 6C. Accept Invite on Instagram

**On your phone or Instagram website:**

1. Open Instagram app or instagram.com
2. Go to: **Settings → Apps and Websites**
3. Look for **"Tester Invites"** section
4. You'll see your app: **"AK Insights"** (or your app name)
5. Click **"Accept"**

**CRITICAL:** If you don't accept the invite, you'll get "Invalid platform app" error!

---

### **STEP 7: Verify App ID and Secret**

Go to: **Settings → Basic** (in left sidebar)

You should see:
- **App ID:** `1165210255788505`
- **App Secret:** Click "Show" → Copy it

**Make sure these match in your code:**
`lib/services/instagram_config.dart`
```dart
static const String appId = '1165210255788505';
static const String appSecret = 'YOUR_SECRET_HERE';
```

---

### **STEP 8: Check Permissions**

Go to: **Instagram Basic Display → Permissions**

Make sure these are enabled:
- ✅ `instagram_graph_user_profile`
- ✅ `instagram_graph_user_media`

If not, enable them and save.

---

## 🧪 **Test After Configuration**

### Test 1: Generate Test Token

1. Go to **Instagram Basic Display → Basic Display**
2. Scroll to **"User Token Generator"**
3. Find your Instagram account
4. Click **"Generate Token"**

If it works → Configuration is correct!
If error → Check steps 4, 5, 6 again.

### Test 2: Try Login in App

1. Make sure backend is running:
   ```bash
   cd backend
   npm start
   ```

2. Open app: `http://localhost:8080`

3. Click "Login with Instagram"

4. Follow OAuth flow

**Should work now!** ✅

---

## 📋 **Complete Checklist**

Before trying login again:

- [ ] App mode is "Development" (not "Live")
- [ ] Instagram Basic Display product is added
- [ ] Valid OAuth Redirect URIs: `https://localhost/callback` (EXACT!)
- [ ] Deauthorize URL: `https://localhost/deauth`
- [ ] Data Deletion URL: `https://localhost/delete`
- [ ] All URLs saved (clicked "Save Changes")
- [ ] Your Instagram account added as tester
- [ ] Tester invite accepted on Instagram app/website
- [ ] App ID matches in code: `1165210255788505`
- [ ] App Secret matches in code
- [ ] Backend server is running (`npm start`)

---

## ❓ **Still Getting Error?**

### Error: "Invalid platform app"
**Cause:** Instagram account not added as tester, or invite not accepted
**Fix:** Step 6 - Add tester and accept invite

### Error: "Redirect URI mismatch"
**Cause:** URI in Facebook console doesn't match code
**Fix:** Step 4 - Use EXACT URI: `https://localhost/callback`

### Error: "App not setup properly"
**Cause:** Missing product or settings
**Fix:** Steps 3-5 - Configure all OAuth settings

### Error: "User not authorized"
**Cause:** Tester invite not accepted
**Fix:** Instagram → Settings → Apps → Accept invite

---

## 🎯 **Visual Guide**

### What Each URL Means:

**Valid OAuth Redirect URIs:**
```
https://localhost/callback
```
→ Where Instagram redirects after login
→ MUST match exactly in code

**Deauthorize Callback URL:**
```
https://localhost/deauth
```
→ Called when user revokes access
→ Can be any URL (not used in basic flow)

**Data Deletion Request URL:**
```
https://localhost/delete
```
→ GDPR requirement (delete user data request)
→ Can be any URL (not used in basic flow)

---

## 🔄 **After Fixing Settings**

1. Wait 1-2 minutes for changes to propagate
2. Clear browser cache (Cmd+Shift+Delete on Mac)
3. Try login flow again
4. Should work!

---

## 📞 **Quick Reference**

**Facebook Developer Console:**
```
https://developers.facebook.com/apps/1165210255788505/
```

**Instagram Basic Display Settings:**
```
https://developers.facebook.com/apps/1165210255788505/instagram-basic-display/basic-display/
```

**Critical Settings:**
- Valid OAuth Redirect URIs: `https://localhost/callback`
- App Mode: Development
- Instagram Tester: YOUR username
- Invite Status: Accepted ✅

---

## ✅ **Success Looks Like:**

**After proper configuration:**

1. Click "Login with Instagram" in app
2. Redirects to Instagram
3. Shows: "AK Insights wants to access your profile"
4. Click "Allow"
5. Redirects to: `https://localhost/callback?code=XXXXX`
6. Copy code, paste in app
7. **Your Instagram data loads!** 🎉

**No more "Invalid platform app" error!**

---

## 💡 **Pro Tip:**

If you're still having issues, try the **"Generate Token"** feature first:

1. Facebook Console → Instagram Basic Display → Basic Display
2. User Token Generator → Find your account
3. Click "Generate Token"

If this fails → Settings are wrong (fix them)
If this works → Settings are correct (try app login again)

---

**Next:** Fix all settings as listed above, then test login again!
