# ✅ DO THIS NOW - Fix Instagram Settings

## 🎯 Follow These Exact Steps (Copy karo browser mein)

---

## **STEP 1: Open Facebook Developer Console**

**Copy this link and paste in browser:**
```
https://developers.facebook.com/apps/1165210255788505/instagram-basic-display/basic-display/
```

Login if needed.

---

## **STEP 2: Fix OAuth Redirect URI** ⚡ MOST IMPORTANT

You'll see a page with forms.

**Find field labeled:** "Valid OAuth Redirect URIs"

**Current value might be:**
- `http://localhost/callback` ❌
- `https://localhost:8080/callback` ❌
- Something else ❌

**DELETE everything and type EXACTLY:**
```
https://localhost/callback
```

**Copy above line → Paste in field**

**Rules:**
- Start with `https://` (NOT `http://`)
- NO `:8080` or `:3000`
- End with `/callback` (NO slash after)

**Click "Save Changes" button at bottom of page!**

---

## **STEP 3: Add Other URLs**

Same page, find these fields:

**"Deauthorize Callback URL"** field:
```
https://localhost/deauth
```

**"Data Deletion Request URL"** field:
```
https://localhost/delete
```

**Click "Save Changes" again!**

---

## **STEP 4: Add Instagram Tester** ⚡ CRITICAL

**Scroll down** on same page.

**Find section:** "User Token Generator"

**Click button:** "Add or Remove Instagram Testers"

**New window opens.**

**Enter YOUR Instagram username** (without @):
```
Example: ak_rehman
```

**Click "Submit"**

---

## **STEP 5: Accept Invite on Instagram**

**On your phone or computer:**

### Option A: Instagram App (Phone)
1. Open Instagram app
2. Tap profile icon (bottom right)
3. Tap ☰ menu (top right)
4. Tap "Settings"
5. Tap "Security"
6. Scroll to "Apps and Websites"
7. Look for "Tester Invites"
8. You'll see your app name
9. Tap "Accept"

### Option B: Instagram Website (Computer)
1. Go to: instagram.com
2. Login
3. Click profile icon
4. Click ⚙️ Settings
5. Click "Apps and Websites"
6. Look for "Tester Invites"
7. Click "Accept"

**MUST do this! Otherwise "Invalid platform app" error!**

---

## **STEP 6: Verify App Mode**

**Go back to Facebook Developer Console**

**Look at top-right corner**

Should show: **"Development"** (green badge)

**If it shows "Live":**
1. Click on it
2. Select "Switch Mode"
3. Choose "Development"
4. Confirm

---

## **STEP 7: Test Settings**

**Still in Facebook Developer Console**

1. Go to: Instagram Basic Display → Basic Display
2. Scroll to "User Token Generator"
3. Find your Instagram account in list
4. Click "Generate Token" button

**If popup appears and works** → Settings are correct! ✅

**If error** → Go back to steps 2-5 and check again

---

## **STEP 8: Start Backend Server**

**Open Terminal** (Cmd+Space → "Terminal" → Enter)

**Copy/paste these commands ONE BY ONE:**

### Command 1: (Password puchega)
```bash
sudo chown -R $(whoami) "/Users/rehman/.npm"
```
Press Enter → Type password → Press Enter

### Command 2:
```bash
cd /Users/rehman/Downloads/ak_insights_app/backend
```
Press Enter

### Command 3:
```bash
npm install
```
Press Enter → Wait 30-60 seconds

### Command 4:
```bash
npm start
```
Press Enter

**You'll see:**
```
🚀 Instagram API Proxy Server running on port 3000
📍 Health check: http://localhost:3000/health
```

**✅ Backend running! Keep this terminal open!**

---

## **STEP 9: Test Backend**

**Open new browser tab:**
```
http://localhost:3000/health
```

**Should show:**
```json
{"status":"OK","message":"Instagram API Proxy is running"}
```

**✅ Backend working!**

---

## **STEP 10: Try Instagram Login**

**Open app:**
```
http://localhost:8080
```

**Click:** "Login with Instagram"

**Click:** "Open Instagram Login"

**New tab opens** → Instagram login page

**Enter YOUR Instagram credentials**

**Click "Allow"**

**Redirects to:** `https://localhost/callback?code=XXXXXXXXX`

**Copy the code** (the part after `code=`)
Example: If URL is `https://localhost/callback?code=ABC123XYZ`
Copy: `ABC123XYZ`

**Paste in dialog**

**Click "Submit"**

**✅ YOUR INSTAGRAM DATA LOADS!** 🎉

---

## ✅ **Quick Summary:**

**Did you do ALL of these?**

- [ ] Step 2: OAuth URI = `https://localhost/callback` ✓ Saved
- [ ] Step 3: Other URLs added ✓ Saved
- [ ] Step 4: Instagram username added as tester
- [ ] Step 5: Invite accepted on Instagram app
- [ ] Step 6: App mode = Development
- [ ] Step 7: "Generate Token" test passed
- [ ] Step 8: Backend server running
- [ ] Step 9: Health check shows OK
- [ ] Step 10: Login tested

**All done?** → App will work 100%! 🚀

---

## ❓ **Still Error?**

### "Invalid platform app"
→ Step 5 not done → Accept invite on Instagram!

### "Redirect URI mismatch"
→ Step 2 wrong → Use EXACT: `https://localhost/callback`

### "Failed to get access token"
→ Step 8 not done → Start backend server!

### "User not authorized"
→ Step 5 not done → Accept tester invite!

---

## 🎯 **Next:**

1. Print this page or keep it open
2. Follow steps 1-10 in order
3. Don't skip any step
4. Test after each step if possible

**Done? Instagram login will work!** ✅
