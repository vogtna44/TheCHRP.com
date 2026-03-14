// Vercel serverless function — GET /api/sounds
// Returns the CHRP sound catalog as a JSON array.
// Deploy this repo to Vercel and the iOS app will fetch from
// https://thechrp.com/api/sounds automatically.

const sounds = [
  {
    id: "no_shot_01",
    title: "No shot!",
    transcript: "No shot.",
    category: "Trending",
    tags: ["reaction", "hype"],
    synonyms: ["no way"],
    duration: 2.0,
    filename: "no_shot_01.m4a"
  }
];

export default function handler(req, res) {
  res.setHeader("Content-Type", "application/json");
  // Allow any origin: this is a public, read-only JSON endpoint consumed by a
  // native iOS app. Credentials and custom request headers are never used.
  res.setHeader("Access-Control-Allow-Origin", "*");
  res.status(200).json(sounds);
}
