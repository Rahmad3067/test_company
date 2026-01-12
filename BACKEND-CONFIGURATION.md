# Backend Configuration Guide for GitHub Pages Widget

## 🔴 Issues Found

Based on the console errors from your GitHub Pages site, you need to configure two things in your main backend app:

1. **CORS Configuration** - Allow requests from GitHub Pages domain
2. **Widget Config Endpoint** - Create `/api/widget/config` endpoint

## ✅ Solution 1: Configure CORS

Your backend needs to allow requests from `https://rahmad3067.github.io`.

### If using FastAPI (Python):

**File: `backend/main.py` or `backend/app.py`**

```python
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI()

# CORS Configuration
app.add_middleware(
    CORSMiddleware,
    allow_origins=[
        "http://localhost:5173",  # Local frontend
        "http://localhost:8080",   # Local test server
        "https://remoagentai.netlify.app",  # Your production frontend
        "https://rahmad3067.github.io",     # GitHub Pages domain ⬅️ ADD THIS
        # Add more domains as needed
    ],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)
```

**Or for development (allow all origins):**

```python
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Allow all origins (for development)
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)
```

### If using Express.js (Node.js):

**File: `backend/server.js` or `backend/index.js`**

```javascript
const express = require('express');
const cors = require('cors');
const app = express();

// CORS Configuration
app.use(cors({
    origin: [
        'http://localhost:5173',
        'http://localhost:8080',
        'https://remoagentai.netlify.app',
        'https://rahmad3067.github.io',  // ⬅️ ADD THIS
    ],
    credentials: true,
}));

// Or for development (allow all origins):
// app.use(cors({ origin: '*' }));
```

### If using Flask (Python):

**File: `backend/app.py`**

```python
from flask import Flask
from flask_cors import CORS

app = Flask(__name__)

# CORS Configuration
CORS(app, origins=[
    "http://localhost:5173",
    "http://localhost:8080",
    "https://remoagentai.netlify.app",
    "https://rahmad3067.github.io",  # ⬅️ ADD THIS
])

# Or for development (allow all origins):
# CORS(app, origins="*")
```

## ✅ Solution 2: Create Widget Config Endpoint

The widget needs an endpoint at `/api/widget/config` that returns widget configuration.

### FastAPI Example:

**File: `backend/main.py` or `backend/routes/widget.py`**

```python
from fastapi import FastAPI, Header, HTTPException
from pydantic import BaseModel
from typing import Optional

app = FastAPI()

class WidgetConfig(BaseModel):
    widget_version: str = "1.0.0"
    theme: Optional[dict] = None
    features: Optional[dict] = None

@app.get("/api/widget/config")
async def get_widget_config(x_api_key: Optional[str] = Header(None)):
    """
    Get widget configuration based on API key
    """
    if not x_api_key:
        raise HTTPException(status_code=401, detail="API key required")
    
    # Validate API key (implement your validation logic)
    # For example, check if API key exists in database
    # api_key = await validate_api_key(x_api_key)
    # if not api_key:
    #     raise HTTPException(status_code=401, detail="Invalid API key")
    
    # Get company/room configuration based on API key
    # company = await get_company_by_api_key(x_api_key)
    
    # Return widget configuration
    config = WidgetConfig(
        widget_version="1.0.0",
        theme={
            "primaryColor": "#667eea",
            "secondaryColor": "#764ba2"
        },
        features={
            "buttonText": "Start Demo"
        }
    )
    
    return config
```

### Express.js Example:

**File: `backend/routes/widget.js`**

```javascript
const express = require('express');
const router = express.Router();

router.get('/api/widget/config', async (req, res) => {
    const apiKey = req.headers['x-api-key'];
    
    if (!apiKey) {
        return res.status(401).json({ detail: 'API key required' });
    }
    
    // Validate API key (implement your validation logic)
    // const company = await validateApiKey(apiKey);
    // if (!company) {
    //     return res.status(401).json({ detail: 'Invalid API key' });
    // }
    
    // Return widget configuration
    const config = {
        widget_version: '1.0.0',
        theme: {
            primaryColor: '#667eea',
            secondaryColor: '#764ba2'
        },
        features: {
            buttonText: 'Start Demo'
        }
    };
    
    res.json(config);
});

module.exports = router;
```

### Flask Example:

**File: `backend/routes/widget.py`**

```python
from flask import Blueprint, request, jsonify
from functools import wraps

widget_bp = Blueprint('widget', __name__)

@widget_bp.route('/api/widget/config', methods=['GET'])
def get_widget_config():
    api_key = request.headers.get('X-API-Key')
    
    if not api_key:
        return jsonify({'detail': 'API key required'}), 401
    
    # Validate API key (implement your validation logic)
    # company = validate_api_key(api_key)
    # if not company:
    #     return jsonify({'detail': 'Invalid API key'}), 401
    
    # Return widget configuration
    config = {
        'widget_version': '1.0.0',
        'theme': {
            'primaryColor': '#667eea',
            'secondaryColor': '#764ba2'
        },
        'features': {
            'buttonText': 'Start Demo'
        }
    }
    
    return jsonify(config)
```

## ✅ Solution 3: Create Embed Widget Route (Optional)

The widget opens in a new tab at `/embed/widget?api_key=...`. You may want to create this route too.

### FastAPI Example:

```python
from fastapi.responses import HTMLResponse

@app.get("/embed/widget")
async def embed_widget(api_key: str):
    """
    Embed widget page that opens in new tab
    """
    # Validate API key and get room/company info
    # Return HTML page with the widget interface
    
    html_content = """
    <!DOCTYPE html>
    <html>
    <head>
        <title>Remo AI Demo</title>
        <style>
            body { margin: 0; padding: 20px; font-family: sans-serif; }
        </style>
    </head>
    <body>
        <div id="remo-widget-container">
            <!-- Widget content will be rendered here -->
        </div>
        <script>
            // Widget initialization code
        </script>
    </body>
    </html>
    """
    
    return HTMLResponse(content=html_content)
```

## 📋 Quick Checklist

After making these changes:

- [ ] CORS allows `https://rahmad3067.github.io`
- [ ] Endpoint `/api/widget/config` exists and returns JSON
- [ ] Endpoint accepts `X-API-Key` header
- [ ] Endpoint validates API key
- [ ] Endpoint returns widget configuration
- [ ] Backend is deployed and accessible at `https://remoagentai.netlify.app`
- [ ] Test endpoint: `curl -H "X-API-Key: remo_sCQTrFnHp83HaMN4fnHRqEIIilYtOXnO" https://remoagentai.netlify.app/api/widget/config`

## 🧪 Testing

### Test CORS:

```bash
curl -H "Origin: https://rahmad3067.github.io" \
     -H "X-API-Key: remo_sCQTrFnHp83HaMN4fnHRqEIIilYtOXnO" \
     -v https://remoagentai.netlify.app/api/widget/config
```

Look for `Access-Control-Allow-Origin` header in response.

### Test Endpoint:

```bash
curl -H "X-API-Key: remo_sCQTrFnHp83HaMN4fnHRqEIIilYtOXnO" \
     https://remoagentai.netlify.app/api/widget/config
```

Should return JSON with widget configuration.

## 🚀 After Configuration

1. **Deploy backend changes** to `remoagentai.netlify.app`
2. **Test endpoint** using curl or browser
3. **Refresh GitHub Pages site** - widget should now work!

## 📝 Notes

- The widget automatically derives backend URL from script src
- Since widget.js is at `https://remoagentai.netlify.app/widget.js`, backend is expected at `https://remoagentai.netlify.app`
- Make sure your backend is deployed and accessible at that domain
- CORS must allow the exact GitHub Pages domain: `https://rahmad3067.github.io`
