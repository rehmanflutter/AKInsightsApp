# 🚀 Instagram App - LIVE MODE Setup Guide

## What is Live Mode?

**Development Mode (Current):**
- ❌ Only TESTERS can login
- ❌ Maximum 5-25 test users
- ❌ Not public

**Live Mode (After Setup):**
- ✅ **ANY Instagram user** can login
- ✅ Unlimited users
- ✅ Public app
- ✅ Real Instagram data

**But Remember:**
- OAuth still required (new tab opens)
- User logs in on Instagram.com
- Password never comes to your app
- This is Instagram's security rule

---

## 📋 Requirements Before Going LIVE

### 1. Privacy Policy Page

Create a webpage with your app's privacy policy.

**What to include:**
- What data you collect (username, profile info, media)
- How you use it (display to user only)
- How you store it (secure storage)
- How users can delete data
- Contact information

**Example URL:**
```
https://yourdomain.com/privacy-policy
```

**Quick Setup:**
- Use GitHub Pages (free)
- Or create simple HTML page
- Host on Netlify/Vercel (free)

**Template:** I'll create one for you below.

---

### 2. Terms of Service Page

Similar to privacy policy.

**What to include:**
- App usage rules
- User responsibilities
- Limitations
- Instagram's terms reference

**Example URL:**
```
https://yourdomain.com/terms-of-service
```

---

### 3. App Description

Clear explanation of what your app does:

**Example:**
```
AK Insights is an Instagram analytics tool that allows users
to view their Instagram profile data, posts count, and media
in a beautiful dashboard. Users login with Instagram OAuth
to securely access their data.
```

---

### 4. Demo Video (Optional but Recommended)

Short video showing:
- How user logs in (OAuth flow)
- What data is shown
- Key features
- How to logout

**Tools:**
- Screen recording (Mac: Cmd+Shift+5)
- Upload to YouTube (unlisted)
- Provide link in review

---

### 5. Use Case Explanation

Why you need Instagram data:

**Example:**
```
Our app allows Instagram users to view their profile analytics
including posts count, username, and media in an organized
dashboard. We use Instagram Basic Display API to fetch user's
public profile information with their consent via OAuth.

Data Usage:
- User profile info (username, account type)
- Media count
- User's posts/photos

We do NOT:
- Store passwords
- Access private messages
- Post on user's behalf
- Share data with third parties
```

---

## 🛠️ Step-by-Step Live Mode Setup

### **STEP 1: Create Privacy Policy & Terms**

I'll provide templates below. You can:

**Option A: GitHub Pages (Free)**
```bash
# Create a new GitHub repo: yourusername.github.io
# Add privacy.html and terms.html
# Access at: https://yourusername.github.io/privacy.html
```

**Option B: Netlify (Free)**
```bash
# Create folder with privacy.html and terms.html
# Drag to netlify.com
# Get URL like: https://your-app.netlify.app/privacy.html
```

**Option C: Simple Text File**
```
# For testing, Facebook accepts Google Docs links too
# Create doc → Share → "Anyone with link can view"
```

---

### **STEP 2: Prepare App for Review**

1. **Go to Facebook Developer Console:**
   ```
   https://developers.facebook.com/apps/1165210255788505/
   ```

2. **Complete App Details** (Settings → Basic):
   - App Name: "AK Insights" (or your name)
   - App Domain: Your website (optional)
   - Privacy Policy URL: `https://yourdomain.com/privacy`
   - Terms of Service URL: `https://yourdomain.com/terms`
   - Category: Business (or Social)
   - Click "Save Changes"

3. **Add App Icon**:
   - Upload 1024x1024 icon
   - Represents your app
   - Use Canva/Figma to create

---

### **STEP 3: Request Permissions**

1. **Go to:** App Review → Permissions and Features

2. **Find these permissions:**
   - `instagram_graph_user_profile`
   - `instagram_graph_user_media`

3. **Click "Request"** for each

4. **Fill out form:**
   - **Use case:** "Display user's Instagram profile and media in dashboard"
   - **Why needed:** "To show user their profile info and posts"
   - **Screenshots:** Upload screenshots showing your app
   - **Video:** Optional demo video

5. **Submit**

---

### **STEP 4: Complete App Verification**

1. **Business Verification** (if required):
   - Some apps need business verification
   - Follow instructions if prompted

2. **Data Use Checkup:**
   - Review how you use data
   - Confirm you follow policies

---

### **STEP 5: Wait for Approval**

**Timeline:**
- Review takes 1-2 weeks typically
- Sometimes faster (3-5 days)
- Sometimes longer (up to 4 weeks)

**Status:**
- Check at: App Review → Requests
- Email notification when approved/rejected

**If Rejected:**
- Read feedback carefully
- Fix issues
- Resubmit

---

### **STEP 6: Switch to Live Mode** (After Approval)

1. **App Dashboard** → Top-right corner

2. **Click "Development"** badge

3. **Select "Switch to Live Mode"**

4. **Confirm**

**Now:**
- ✅ ANY Instagram user can login
- ✅ No tester requirement
- ✅ Unlimited users
- ✅ Public app!

---

## 📄 Privacy Policy Template

**Save as `privacy.html`:**

```html
<!DOCTYPE html>
<html>
<head>
    <title>AK Insights - Privacy Policy</title>
    <style>
        body { font-family: Arial, sans-serif; max-width: 800px; margin: 50px auto; padding: 20px; }
        h1 { color: #333; }
        h2 { color: #666; margin-top: 30px; }
        p { line-height: 1.6; color: #444; }
    </style>
</head>
<body>
    <h1>Privacy Policy</h1>
    <p><strong>Effective Date:</strong> June 17, 2026</p>

    <h2>1. Information We Collect</h2>
    <p>When you use AK Insights and connect your Instagram account, we collect:</p>
    <ul>
        <li>Your Instagram username</li>
        <li>Your public profile information</li>
        <li>Your posts count</li>
        <li>Your public media (photos/videos)</li>
    </ul>

    <h2>2. How We Use Your Information</h2>
    <p>We use your information solely to:</p>
    <ul>
        <li>Display your Instagram data in our dashboard</li>
        <li>Provide analytics and insights about your account</li>
        <li>Improve our service</li>
    </ul>

    <h2>3. Data Storage</h2>
    <p>We securely store your access token using encrypted storage. We do NOT store your Instagram password. Your data is stored only on your device.</p>

    <h2>4. Data Sharing</h2>
    <p>We do NOT share, sell, or distribute your data to third parties. Your Instagram data is private and visible only to you.</p>

    <h2>5. Data Deletion</h2>
    <p>You can delete your data at any time by:</p>
    <ul>
        <li>Logging out of the app</li>
        <li>Revoking access at Instagram → Settings → Apps</li>
        <li>Contacting us at: your-email@example.com</li>
    </ul>

    <h2>6. Security</h2>
    <p>We use Instagram's official OAuth for authentication. Your password is never transmitted to or stored by our app.</p>

    <h2>7. Instagram's Terms</h2>
    <p>By using this app, you also agree to Instagram's Terms of Service and Data Policy.</p>

    <h2>8. Contact Us</h2>
    <p>For questions about this Privacy Policy, contact us at:</p>
    <p>Email: your-email@example.com</p>

    <p><em>Last updated: June 17, 2026</em></p>
</body>
</html>
```

---

## 📄 Terms of Service Template

**Save as `terms.html`:**

```html
<!DOCTYPE html>
<html>
<head>
    <title>AK Insights - Terms of Service</title>
    <style>
        body { font-family: Arial, sans-serif; max-width: 800px; margin: 50px auto; padding: 20px; }
        h1 { color: #333; }
        h2 { color: #666; margin-top: 30px; }
        p { line-height: 1.6; color: #444; }
    </style>
</head>
<body>
    <h1>Terms of Service</h1>
    <p><strong>Effective Date:</strong> June 17, 2026</p>

    <h2>1. Acceptance of Terms</h2>
    <p>By using AK Insights, you agree to these Terms of Service and Instagram's Terms of Service.</p>

    <h2>2. Service Description</h2>
    <p>AK Insights is a tool that displays your Instagram profile data and media in a dashboard format.</p>

    <h2>3. User Requirements</h2>
    <p>You must:</p>
    <ul>
        <li>Have a valid Instagram account</li>
        <li>Be at least 13 years old</li>
        <li>Comply with Instagram's Terms of Service</li>
    </ul>

    <h2>4. Prohibited Uses</h2>
    <p>You may NOT:</p>
    <ul>
        <li>Use the app for illegal purposes</li>
        <li>Attempt to access other users' data</li>
        <li>Reverse engineer the app</li>
        <li>Violate Instagram's policies</li>
    </ul>

    <h2>5. Disclaimer</h2>
    <p>This app is provided "as is" without warranties. We are not responsible for any data loss or issues arising from Instagram API changes.</p>

    <h2>6. Limitation of Liability</h2>
    <p>We are not liable for any damages arising from your use of this app.</p>

    <h2>7. Changes to Terms</h2>
    <p>We may update these terms. Continued use constitutes acceptance of changes.</p>

    <h2>8. Contact</h2>
    <p>Questions? Contact us at: your-email@example.com</p>

    <p><em>Last updated: June 17, 2026</em></p>
</body>
</html>
```

---

## 🚀 Quick Deploy Privacy/Terms Pages

### **Option 1: GitHub Pages (Recommended)**

```bash
# 1. Create repo on GitHub: yourusername.github.io
# 2. Clone it locally
git clone https://github.com/yourusername/yourusername.github.io

# 3. Create files
cd yourusername.github.io
# Copy privacy.html and terms.html (from templates above)

# 4. Push to GitHub
git add .
git commit -m "Add privacy and terms pages"
git push

# 5. Access at:
# https://yourusername.github.io/privacy.html
# https://yourusername.github.io/terms.html
```

---

### **Option 2: Netlify**

1. Create folder `policies`
2. Add `privacy.html` and `terms.html` (from templates)
3. Go to netlify.com
4. Drag folder to deploy
5. Get URLs like:
   - `https://your-app-name.netlify.app/privacy.html`
   - `https://your-app-name.netlify.app/terms.html`

---

## ✅ Checklist Before Submitting for Review

- [ ] Privacy Policy page created and live
- [ ] Terms of Service page created and live
- [ ] Both URLs added to App Settings
- [ ] App icon uploaded (1024x1024)
- [ ] App description written
- [ ] Use case clearly explained
- [ ] Screenshots prepared
- [ ] Demo video created (optional)
- [ ] All OAuth settings configured correctly
- [ ] App tested in Development mode
- [ ] Ready to submit for review!

---

## ⏱️ Timeline

**Week 1:**
- Day 1-2: Create Privacy/Terms pages
- Day 3: Upload to GitHub/Netlify
- Day 4: Complete app settings
- Day 5: Submit for review

**Week 2-3:**
- Wait for Instagram review
- Check status daily
- Respond if additional info requested

**Week 4:**
- Approval received!
- Switch to Live mode
- Test with real users
- Launch! 🎉

---

## 🎯 After Going LIVE

**What Changes:**
- ✅ Any Instagram user can login
- ✅ No tester limit
- ✅ Public app
- ✅ Real production use

**What Stays Same:**
- OAuth flow (new tab opens)
- Security (password not to your app)
- Data (same Instagram Basic Display API)
- Features (same functionality)

**Next Steps:**
1. Deploy your Flutter app (Netlify/Vercel/Firebase)
2. Update backend to production server
3. Share app link with users
4. Monitor usage

---

## 📞 Support

**If Rejected:**
- Read rejection reason carefully
- Common issues:
  - Missing privacy policy
  - Unclear use case
  - Insufficient screenshots
- Fix and resubmit

**Need Help:**
- Instagram Platform docs: https://developers.facebook.com/docs/instagram
- Support: https://developers.facebook.com/support/

---

## ✅ Summary

**Steps:**
1. Create Privacy Policy + Terms of Service
2. Upload to GitHub Pages / Netlify
3. Complete app settings with URLs
4. Submit for App Review
5. Wait 1-2 weeks
6. Switch to Live mode
7. Launch! 🚀

**Result:**
- Public Instagram app
- Any user can login
- Real Instagram data
- OAuth (secure)

**Remember:**
- Direct password = Still not possible
- OAuth = Instagram's requirement
- But ANY user can use your app in Live mode!

---

**Ready to start? Follow steps above, or let me know if you need help with any part!** 🎯
