# Company Website - Widget Test

This repository contains a company website demo that embeds the Remo AI widget. It can be deployed to GitHub Pages for easy testing and demonstration.

## 🚀 Deploy to GitHub Pages

### Quick Deployment Steps

1. **Push to GitHub**
   ```bash
   git init
   git add .
   git commit -m "Initial commit"
   git branch -M main
   git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO_NAME.git
   git push -u origin main
   ```

2. **Enable GitHub Pages**
   - Go to your repository on GitHub
   - Click **Settings** → **Pages**
   - Under **Source**, select **GitHub Actions**
   - The site will be automatically deployed at: `https://YOUR_USERNAME.github.io/YOUR_REPO_NAME/`

3. **Configure Production URLs**
   - Open `index.html` in your editor
   - Update `YOUR_PRODUCTION_URL` with your production frontend URL
   - Update `YOUR_API_KEY` with your actual API key
   - Commit and push the changes

### Manual GitHub Pages Setup (Alternative)

If you prefer not to use GitHub Actions:

1. Go to repository **Settings** → **Pages**
2. Under **Source**, select **Deploy from a branch**
3. Select **main** branch and **/ (root)** folder
4. Click **Save**

Your site will be available at: `https://YOUR_USERNAME.github.io/YOUR_REPO_NAME/`

## 📝 Configuration

Before deploying, make sure to update the following in `index.html`:

1. **Widget URL** (line ~145): Replace `YOUR_PRODUCTION_URL` with your production frontend URL
2. **API Key** (line ~146): Replace `YOUR_API_KEY` with your actual Remo AI API key
3. **Embed URL** (line ~175): Update the embed URL in the `updateInviteToken` function

## 🧪 Local Testing

This directory also contains files to test the Remo AI widget/embed functionality locally.

## Quick Start

### Step 1: Start Your Services

**Terminal 1 - Backend:**
```bash
cd backend
source .venv/bin/activate
uvicorn main:app --reload --host 0.0.0.0 --port 8000
```

**Terminal 2 - Frontend:**
```bash
cd frontend
npm run dev
```

### Step 2: Create a Room and Get Invite Token

1. Open your Remo AI dashboard: `http://localhost:5173`
2. Log in as a company user
3. Create a new room
4. Copy the invite token from the room (it looks like: `abc123xyz...`)

### Step 3: Test the Widget

**Option A: Simple HTTP Server (Recommended)**

```bash
# From project root
cd test-embed
python3 -m http.server 8080
# Or if you have Python 2:
# python -m SimpleHTTPServer 8080
```

Then open: `http://localhost:8080/company-website.html`

**Option B: Using Node.js http-server**

```bash
# Install globally (one time)
npm install -g http-server

# Run from test-embed directory
cd test-embed
http-server -p 8080
```

Then open: `http://localhost:8080/company-website.html`

**Option C: Using PHP (if installed)**

```bash
cd test-embed
php -S localhost:8080
```

### Step 4: Update the Invite Token

1. Open `company-website.html` in your editor
2. Find the iframe tag (around line 85)
3. Replace `YOUR_INVITE_TOKEN` with your actual invite token:
   ```html
   <iframe 
       src="http://localhost:5173/invite/YOUR_ACTUAL_TOKEN_HERE"
       ...
   ></iframe>
   ```
4. Save the file and refresh the page in your browser

**Note:** The current setup uses the existing `/invite/:token` route. For production, you may want to create a dedicated `/embed/room/:token` route that's optimized for embedding (smaller header, no navigation, etc.)

## Testing Scenarios

### Scenario 1: Iframe Embed (Current)
- ✅ Tests cross-origin iframe embedding
- ✅ Simulates real company website
- ✅ Tests CORS and WebSocket connections

### Scenario 2: JavaScript Widget (Future)
- Uncomment the JavaScript widget section in `company-website.html`
- This will test the standalone widget approach

## What You're Testing

1. **Cross-Origin Communication**: Widget on `localhost:8080` → App on `localhost:5173` → API on `localhost:8000`
2. **WebRTC in Iframe**: Video/audio should work within the iframe
3. **Invite Token Flow**: Customer can join using invite token without external links
4. **User Experience**: One-click entry from company website

## Troubleshooting

### CORS Errors
- Make sure backend CORS allows `localhost:8080`
- Check browser console for specific errors

### WebSocket Connection Failed
- Ensure backend is running on port 8000
- Check that WebSocket proxy is configured in `vite.config.js`

### Iframe Not Loading
- Check browser console for errors
- Verify frontend is running on port 5173
- Make sure the `/invite/{token}` route exists (it should - it's already in your App.jsx)
- Try opening `http://localhost:5173/invite/YOUR_TOKEN` directly in a new tab to verify it works

### Widget Not Appearing
- Verify invite token is correct
- Check network tab for API calls
- Ensure room exists in database

## Next Steps

After testing locally, you can:

1. **Create the actual embed route** in your frontend (`/embed/room/:token`)
2. **Build a JavaScript widget** for easier integration
3. **Add customization options** (colors, size, etc.)
4. **Test on different ports** to simulate different domains
5. **Test on mobile devices** using your local IP address

## Production Considerations

- Use HTTPS/WSS (required for WebRTC)
- Configure CORS for production domains
- Add widget customization options
- Implement widget versioning
- Add analytics/tracking

