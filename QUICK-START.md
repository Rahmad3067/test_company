# Quick Start: Testing Widget Locally

## 🚀 Step-by-Step Instructions

### Step 1: Start Backend (Terminal 1)

```bash
cd backend
source .venv/bin/activate
uvicorn main:app --reload --host 0.0.0.0 --port 8000
```

**Wait for:** `Application startup complete` message

### Step 2: Start Frontend (Terminal 2)

```bash
cd frontend
npm run dev
```

**Wait for:** `Local: http://localhost:5173` message

### Step 3: Get Your API Key

1. Open browser: `http://localhost:5173`
2. Login to your dashboard
3. Click "Rooms" button in header
4. Look for the **"📦 Embed Widget on Your Website"** section at the top
5. Copy your **API key** from the embed code (looks like: `remo_abc123xyz...`)

### Step 4: Update Test File

1. Open `test-embed/company-website.html` in your editor
2. Find this line (around line 145):
   ```html
   <script src="http://localhost:5173/widget.js" data-api-key="YOUR_API_KEY" async></script>
   ```
3. Replace `YOUR_API_KEY` with your actual API key:
   ```html
   <script src="http://localhost:5173/widget.js" data-api-key="remo_YOUR_ACTUAL_KEY" async></script>
   ```
4. Save the file

### Step 5: Start Test Server (Terminal 3)

**Option A: Using the script (easiest)**
```bash
cd test-embed
./start-test-server.sh
```

**Option B: Using Python manually**
```bash
cd test-embed
python3 -m http.server 8080
```

**Option C: Using Node.js**
```bash
cd test-embed
npx http-server -p 8080
```

### Step 6: Test the Widget

1. Open browser: `http://localhost:8080/company-website.html`
2. You should see:
   - A simulated company website
   - A "Start Demo" button (from the widget)
3. Click "Start Demo"
4. Enter your email and name
5. Click "Launch Demo"
6. You should join a room!

## ✅ What You Should See

- **Company Website**: Purple gradient background with "Acme Corporation"
- **Widget Button**: "Start Demo" button appears in the widget container
- **Modal**: Clicking button opens a modal with the demo form
- **Room**: After submitting, you join a WebRTC room

## 🐛 Troubleshooting

### Widget Button Not Appearing

1. **Check Browser Console (F12)**
   - Look for errors
   - Common: "Invalid API key" or CORS errors

2. **Verify API Key**
   - Make sure it starts with `remo_`
   - Copy from dashboard exactly (no extra spaces)

3. **Check Services Running**
   - Backend: `http://localhost:8000/docs` should work
   - Frontend: `http://localhost:5173` should load
   - Test server: `http://localhost:8080` should serve files

### CORS Errors

- Backend CORS should allow all origins in dev (already configured)
- Check that backend is running on port 8000
- Check browser console for specific CORS error messages

### API Key Invalid

- Make sure you copied the full API key from dashboard
- API key should be in format: `remo_...` (long string)
- Try regenerating API key in dashboard if needed

### Widget.js Not Found

- Make sure frontend is running on port 5173
- Try opening `http://localhost:5173/widget.js` directly in browser
- Should see JavaScript code (not 404)

## 📝 Quick Checklist

- [ ] Backend running on port 8000
- [ ] Frontend running on port 5173  
- [ ] Got API key from dashboard
- [ ] Updated `company-website.html` with API key
- [ ] Test server running on port 8080
- [ ] Opened `http://localhost:8080/company-website.html`
- [ ] Widget button appears
- [ ] Can click and join room

## 🎯 Next Steps

Once it works locally:
1. Test with different API keys (different companies)
2. Customize widget theme in dashboard
3. Set allowed domains
4. Deploy to production
