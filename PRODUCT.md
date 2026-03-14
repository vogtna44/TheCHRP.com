# CHRP Product Vision

## The Thesis

Sound first. Visual as packaging. Meme as optional.

CHRP is the fastest way to drop a perfect audio reaction. The core product is the
sound — short, punchy, and culturally resonant. Visuals exist to make sharing feel
premium, not to slow the send.

## The Chirp Card

The atomic unit of CHRP is the **Chirp Card** (also called a Sound Card): a branded
tile built around a single short phrase. It is tap-to-play and optionally shareable
as an image or link.

### Card anatomy (Stage 2 target)

| Element        | Required | Notes                                          |
|----------------|----------|------------------------------------------------|
| Short phrase   | Optional | `cardTitle` field; falls back to clip `title`  |
| Creator tag    | Optional | `creatorTag` field, e.g. `"@username"`         |
| Pack name      | Optional | `packName` field, e.g. `"Hype Pack"`           |
| Subtle waveform| Optional | Visual polish; added in Stage 2                |
| Play button    | Always   | The core interaction                           |

## Stages

### Stage 1 — Prove demand (current)

- Sound-only. Tap a tile → sound plays instantly.
- No manual visual editing in the send flow.
- No heavy video or GIF.
- Tiles are the **Chirp Card shell** — layout is ready for Stage 2 fields.
- `cardTitle`, `creatorTag`, and `packName` are `nil`; the tile shows `title`.

### Stage 2 — Optional visual card

- API delivers `cardTitle`, `creatorTag`, and/or `packName` alongside each sound.
- Tiles display `displayTitle` (= `cardTitle ?? title`), creator tag, and pack name.
- Subtle waveform animation added beneath the phrase.
- Card can be shared as a static image or link.

### Stage 3 — A/B test

- Audio-only send vs. audio + Chirp Card.
- Measure share rate, downstream clicks, and conversion to inform Stage 3 decisions.

## What to Avoid

- Heavy video / GIF generation in the send flow.
- Manual visual editing by the user before sending.
- Anything that slows the "tap → share" path.

## Data Model Notes

The `Sound` model (`Shared/Models/Sound.swift`) and `/api/sounds` endpoint already
support optional `cardTitle`, `creatorTag`, and `packName` fields (all `nil` by
default in Stage 1). Existing JSON and call sites continue to work unchanged.

Tiles use `sound.displayTitle` (= `cardTitle ?? title`) so the card automatically
shows a short phrase when the API provides one.

See also: `COPILOT_BRIEF_LANDING.md` for website / landing page context.
