// Vercel serverless function — GET /api/sounds
// Returns the CHRP sound catalog as a JSON array.
// Deploy this repo to Vercel and the iOS app will fetch from
// https://thechrp.com/api/sounds automatically.

const sounds = [
  {
    "id": "no_shot_01",
    "title": "No shot!",
    "transcript": "No shot.",
    "category": "Trending",
    "tags": ["reaction", "disbelief"],
    "synonyms": ["no way", "impossible"],
    "duration": 2.0,
    "filename": "no_shot_01.m4a"
  },
  {
    "id": "thats_wild_01",
    "title": "That's wild",
    "transcript": "That's wild.",
    "category": "Reaction",
    "tags": ["reaction", "surprise"],
    "synonyms": ["crazy", "insane", "unbelievable"],
    "duration": 1.8,
    "filename": "thats_wild_01.m4a"
  },
  {
    "id": "lets_go_01",
    "title": "Let's go!",
    "transcript": "Let's go!",
    "category": "Hype",
    "tags": ["hype", "energy"],
    "synonyms": ["let's get it", "game on"],
    "duration": 1.5,
    "filename": "lets_go_01.m4a"
  },
  {
    "id": "say_less_01",
    "title": "Say less",
    "transcript": "Say less.",
    "category": "Vibes",
    "tags": ["agreement", "chill"],
    "synonyms": ["understood", "got it", "i hear you"],
    "duration": 1.3,
    "filename": "say_less_01.m4a"
  },
  {
    "id": "sheesh_01",
    "title": "Sheesh",
    "transcript": "Sheesh.",
    "category": "Trending",
    "tags": ["reaction", "impressed"],
    "synonyms": ["wow", "damn", "oh my"],
    "duration": 1.6,
    "filename": "sheesh_01.m4a"
  },
  {
    "id": "no_cap_01",
    "title": "No cap",
    "transcript": "No cap.",
    "category": "Hype",
    "tags": ["truth", "hype"],
    "synonyms": ["for real", "not lying", "facts"],
    "duration": 1.4,
    "filename": "no_cap_01.m4a"
  }
];

export default function handler(req, res) {
  res.setHeader("Content-Type", "application/json");
  // Allow any origin: this is a public, read-only JSON endpoint consumed by a
  // native iOS app. Credentials and custom request headers are never used.
  res.setHeader("Access-Control-Allow-Origin", "*");
  res.status(200).json(sounds);
}
