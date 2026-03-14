# Copilot Brief — thechrp.com Landing Page

## Product context

**CHRP** is a sound-first reaction app for iPhone. Users tap a tile to play a short
audio clip, then share it instantly. See `PRODUCT.md` for the full thesis.

The atomic sharing unit is the **Chirp Card** (also called Sound Card): a branded
tile showing a short phrase, optional creator/pack attribution, and (Stage 2) a
subtle waveform. Tap to play; share as audio or card.

### Stages at a glance

| Stage | What ships              | Visual card? |
|-------|-------------------------|--------------|
| 1     | Sound-only, tap to play | No (tile shell only) |
| 2     | Chirp Card with optional phrase + branding | Yes |
| 3     | A/B test audio-only vs audio+card | TBD |

---

## Landing page (public/index.html)

### Structure

1. **Nav** — logo `CHRP`, CTA "Get the app" (App Store link).
2. **Hero** — bold headline about instant reaction sounds; sub-copy; CTA button.
3. **Chirp Cards grid** — dark section labelled **"Chirp Cards"**; a preview grid of
   sound tiles, each showing an icon, a short phrase (`displayTitle`), and a
   category badge. This is the Stage 1 Chirp Card shell.
4. **Footer** — brand name, links (Contact, Privacy, Terms), copyright.

### Naming

- Call the grid section **"Chirp Cards"** (not "Browse sounds").
- Sub-copy: e.g. _"A taste of what's in the catalog."_

---

## `/api/sounds` contract

**Endpoint:** `GET https://thechrp.com/api/sounds`  
**Response:** JSON array of Sound objects.

### Required fields (Stage 1 — always present)

```json
{
  "id":         "no_shot_01",
  "title":      "No shot!",
  "transcript": "No shot.",
  "category":   "Trending",
  "tags":       ["reaction", "disbelief"],
  "synonyms":   ["no way", "impossible"],
  "duration":   2.0,
  "filename":   "no_shot_01.m4a"
}
```

### Optional fields (Stage 2 — may be `null` or omitted)

| Key          | Type   | Purpose                                      |
|--------------|--------|----------------------------------------------|
| `cardTitle`  | string | Short phrase shown on the Chirp Card tile. Displayed via `displayTitle` (`cardTitle ?? title`). |
| `creatorTag` | string | Creator attribution, e.g. `"@username"`.     |
| `packName`   | string | Pack or collection name, e.g. `"Hype Pack"`. |

**Example Stage 2 sound object:**

```json
{
  "id":         "no_shot_01",
  "title":      "No shot!",
  "cardTitle":  "No shot 🙅",
  "creatorTag": "@chrp",
  "packName":   "Reaction Pack",
  "transcript": "No shot.",
  "category":   "Trending",
  "tags":       ["reaction", "disbelief"],
  "synonyms":   ["no way", "impossible"],
  "duration":   2.0,
  "filename":   "no_shot_01.m4a"
}
```

Stage 1 clients ignore unknown keys; Stage 2 clients use `cardTitle` when present.

---

## Implementation notes

- The Swift `Sound` model decodes `cardTitle`, `creatorTag`, and `packName` as
  `String?` (nil by default). No changes needed to existing JSON or call sites.
- SwiftUI tiles use `sound.displayTitle` (= `cardTitle ?? title`).
- The tile component is the Chirp Card shell; Stage 2 can layer in waveform
  animation and creator tag display without restructuring the grid.
- See `PRODUCT.md` for the full thesis and stage definitions.
