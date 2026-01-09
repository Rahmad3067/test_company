# GitHub Pages Widget Troubleshooting Guide

## Common Issues and Solutions

### ❌ Issue 1: Widget Script Not Loading

**Symptoms:**
- Widget doesn't appear
- Console shows: `Failed to load resource` or `404 Not Found`
- Browser shows: "Widget Script Not Found" message

**Solutions:**

1. **Verify Widget File Exists**
   - Open the widget URL directly in browser: `https://rahmad3067.github.io/test_company/widget.js`
   - If you get 404, the file doesn't exist at that location
   - Make sure `widget.js` is deployed to that repository

2. **Check File Path**
   - GitHub Pages serves files from the repository root
   - If widget.js is in a subfolder, update the path: `https://rahmad3067.github.io/test_company/path/to/widget.js`

3. **Verify Repository Name**
   - GitHub Pages URL format: `https://USERNAME.github.io/REPO_NAME/`
   - Make sure the repository name matches: `test_company`
   - Check repository settings → Pages to confirm the URL

### ❌ Issue 2: CORS Errors

**Symptoms:**
- Console shows: `Access to fetch at '...' from origin '...' has been blocked by CORS policy`
- Widget script loads but widget doesn't initialize

**Solutions:**

1. **Widget Server Must Allow GitHub Pages Domain**
   - The server hosting `widget.js` must include GitHub Pages domain in CORS headers
   - Add to widget server CORS config:
     ```
     Access-Control-Allow-Origin: https://YOUR_USERNAME.github.io
     ```
   - Or allow all origins in development:
     ```
     Access-Control-Allow-Origin: *
     ```

2. **Backend API Must Allow GitHub Pages Domain**
   - Your backend API must allow requests from GitHub Pages
   - Update backend CORS configuration to include:
     ```
     https://YOUR_USERNAME.github.io
     ```

### ❌ Issue 3: Mixed Content (HTTP vs HTTPS)

**Symptoms:**
- Console shows: `Mixed Content: The page was loaded over HTTPS, but requested an insecure resource`
- Widget fails to load

**Solutions:**

1. **All URLs Must Use HTTPS**
   - GitHub Pages is served over HTTPS
   - All resources (widget.js, API calls) must use HTTPS
   - Change `http://` to `https://` in all URLs

2. **Check Widget Script URL**
   - Make sure widget URL starts with `https://`
   - Example: `https://rahmad3067.github.io/test_company/widget.js` ✅
   - Not: `http://rahmad3067.github.io/test_company/widget.js` ❌

### ❌ Issue 4: Widget Loads But Doesn't Initialize

**Symptoms:**
- Widget script loads successfully (no 404)
- But no button appears
- Console shows API errors

**Solutions:**

1. **Verify API Key**
   - Check that API key is correct: `remo_sCQTrFnHp83HaMN4fnHRqEIIilYtOXnO`
   - API key should start with `remo_`
   - Make sure there are no extra spaces or characters

2. **Check Backend API Accessibility**
   - Widget needs to call your backend API
   - Backend must be publicly accessible (not localhost)
   - Backend must have CORS configured for GitHub Pages domain
   - Test API endpoint directly: `https://your-backend.com/api/...`

3. **Check Browser Console**
   - Open browser DevTools (F12)
   - Go to Console tab
   - Look for specific error messages
   - Check Network tab for failed API requests

### ❌ Issue 5: Widget.js File Doesn't Exist

**If widget.js is not in the test_company repository:**

1. **Option A: Deploy Widget to Same Repository**
   - Add `widget.js` file to the repository
   - Commit and push
   - Widget will be available at: `https://rahmad3067.github.io/test_company/widget.js`

2. **Option B: Use Different Repository**
   - If widget.js is in a different repository
   - Update the URL in `index.html` to point to correct repository
   - Example: `https://USERNAME.github.io/OTHER_REPO/widget.js`

3. **Option C: Use Production Domain**
   - If you have a production domain for the widget
   - Update URL to: `https://your-production-domain.com/widget.js`

## Debugging Steps

### Step 1: Check Browser Console
1. Open your GitHub Pages site
2. Press F12 to open DevTools
3. Go to Console tab
4. Look for errors (red text)
5. Note any error messages

### Step 2: Check Network Tab
1. In DevTools, go to Network tab
2. Refresh the page
3. Look for `widget.js` request
4. Check if it returns 200 (success) or 404 (not found)
5. Check if CORS headers are present

### Step 3: Test Widget URL Directly
1. Open widget URL in new tab: `https://rahmad3067.github.io/test_company/widget.js`
2. If you see JavaScript code → file exists ✅
3. If you see 404 → file doesn't exist ❌

### Step 4: Verify API Key
1. Check that API key in `index.html` matches your dashboard
2. Make sure API key is valid and active
3. Test API key with a direct API call if possible

### Step 5: Check Backend CORS
1. Verify backend allows requests from GitHub Pages domain
2. Test API endpoint from browser console:
   ```javascript
   fetch('https://your-backend.com/api/test', {
     headers: { 'Authorization': 'Bearer YOUR_API_KEY' }
   })
   ```

## Quick Checklist

- [ ] Widget.js file exists at the specified URL
- [ ] Widget URL uses HTTPS (not HTTP)
- [ ] API key is correct and valid
- [ ] Backend API is publicly accessible
- [ ] Backend CORS allows GitHub Pages domain
- [ ] Widget server CORS allows GitHub Pages domain
- [ ] No console errors in browser DevTools
- [ ] Network tab shows widget.js loads successfully

## Still Not Working?

1. **Check GitHub Pages Deployment**
   - Go to repository → Actions tab
   - Verify deployment completed successfully
   - Check if there are any build errors

2. **Verify Repository Settings**
   - Settings → Pages
   - Source should be set correctly
   - Custom domain (if any) is configured

3. **Test Locally First**
   - Test widget locally before deploying
   - Use `company-website.html` for local testing
   - Once working locally, deploy to GitHub Pages

4. **Contact Support**
   - Share browser console errors
   - Share network tab screenshots
   - Share repository URL and widget URL
