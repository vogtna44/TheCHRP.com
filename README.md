# TheCHRP.com

CHRP — a sound board for every reaction, coming soon to iPhone.

## Repository layout

```
TheCHRP.com/
├── api/
│   └── sounds.js        # Vercel serverless function → GET /api/sounds
├── public/
│   └── index.html       # Landing page served at thechrp.com
├── vercel.json          # Vercel routing (API + static assets)
├── Package.swift        # Swift Package (TheCHRP library used by the iOS app)
├── Sources/TheCHRP/     # Swift source files
└── Tests/TheCHRPTests/  # Swift unit tests
```

## API

`GET https://thechrp.com/api/sounds` returns the sound catalog as a JSON array:

```json
[
  {
    "id": "no_shot_01",
    "title": "No shot!",
    "transcript": "No shot.",
    "category": "Trending",
    "tags": ["reaction", "hype"],
    "synonyms": ["no way"],
    "duration": 2.0,
    "filename": "no_shot_01.m4a"
  }
]
```

Add new sounds by appending objects to the `sounds` array in `api/sounds.js`.

## Deploying to Vercel

1. Push this repo to GitHub (already done).
2. Go to [vercel.com](https://vercel.com) → **Add New → Project** → import this repo.
3. Leave the build settings at their defaults (no framework detected) and click **Deploy**.
4. In **Project Settings → Domains**, add `thechrp.com`.  
   Vercel will display the DNS records to add in GoDaddy (typically an `A` record and/or `CNAME`).

### GoDaddy DNS (one-time)

| Type  | Name | Value                      |
|-------|------|----------------------------|
| A     | @    | 76.76.21.21                |
| CNAME | www  | cname.vercel-dns.com       |

*(Vercel shows the exact values in Project Settings → Domains once you add the domain.)*

### Step 5 — Wait for DNS propagation, then verify

After you save the DNS records in GoDaddy, you're done on your end.
**DNS propagation** is the automatic process by which name servers worldwide
flush their old cache and start directing `thechrp.com` to Vercel's servers.
You don't need to do anything — it happens on its own.

| Time after saving DNS | Typical status |
|---|---|
| 0 – 15 min | Your own device may still reach the old host |
| 15 min – 2 hrs | Most visitors worldwide see the new site |
| 2 – 48 hrs | All remaining ISPs/CDN nodes catch up |

**Check progress:** go to [dnschecker.org](https://dnschecker.org), type `thechrp.com`, and watch the checkmarks turn green globally.

**Confirm it's fully live** (use a private/incognito window to bypass your local DNS cache):

- `https://thechrp.com` → should show the landing page ✅
- `https://thechrp.com/api/sounds` → should return the JSON array ✅  
  Once this URL returns JSON, the iOS app automatically loads the sound catalog from the live server — no app update required.

## Swift Package

The `TheCHRP` library is a Swift Package that the iOS CHRP app adds as a dependency.  
It provides `Sound`, `SoundLibraryService`, `RemoteSoundLibraryService`,  
`FallbackSoundLibraryService`, `SoundListViewModel`, and `AudioPreviewService`.

To run the Swift tests locally:

```sh
swift test
```
