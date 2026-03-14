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

After DNS propagates, visit:
- `https://thechrp.com` — landing page
- `https://thechrp.com/api/sounds` — JSON array (used by the iOS app automatically)

## Swift Package

The `TheCHRP` library is a Swift Package that the iOS CHRP app adds as a dependency.  
It provides `Sound`, `SoundLibraryService`, `RemoteSoundLibraryService`,  
`FallbackSoundLibraryService`, `SoundListViewModel`, and `AudioPreviewService`.

To run the Swift tests locally:

```sh
swift test
```
