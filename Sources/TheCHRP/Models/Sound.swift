import Foundation

/// A single sound clip served by the CHRP catalog API.
public struct Sound: Codable, Identifiable, Equatable {
    /// Unique identifier, e.g. `"no_shot_01"`.
    public let id: String
    /// Display name shown in the UI, e.g. `"No shot!"`.
    public let title: String
    /// Full spoken text of the clip, e.g. `"No shot."`.
    public let transcript: String
    /// Category used to group sounds, e.g. `"Trending"`.
    public let category: String
    /// Tags that describe the sound, e.g. `["reaction", "hype"]`.
    public let tags: [String]
    /// Alternative search terms, e.g. `["no way"]`.
    /// Decoded from either the `"synonyms"` or `"synopsis"` JSON key.
    public let synonyms: [String]
    /// Clip length in seconds, e.g. `2.0`.
    public let duration: Double
    /// Either a bare filename bundled in the app (e.g. `"no_shot_01.m4a"`)
    /// or a full URL to a hosted audio file.
    public let filename: String

    public init(
        id: String,
        title: String,
        transcript: String,
        category: String,
        tags: [String],
        synonyms: [String],
        duration: Double,
        filename: String
    ) {
        self.id = id
        self.title = title
        self.transcript = transcript
        self.category = category
        self.tags = tags
        self.synonyms = synonyms
        self.duration = duration
        self.filename = filename
    }

    // MARK: - Codable

    private enum CodingKeys: String, CodingKey {
        case id, title, transcript, category, tags
        case synonyms
        case synopsis
        case duration, filename
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        transcript = try container.decode(String.self, forKey: .transcript)
        category = try container.decode(String.self, forKey: .category)
        tags = try container.decode([String].self, forKey: .tags)
        // Accept either "synonyms" (preferred) or "synopsis" (legacy/alternate API key).
        if let s = try? container.decode([String].self, forKey: .synonyms) {
            synonyms = s
        } else {
            synonyms = try container.decode([String].self, forKey: .synopsis)
        }
        duration = try container.decode(Double.self, forKey: .duration)
        filename = try container.decode(String.self, forKey: .filename)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(transcript, forKey: .transcript)
        try container.encode(category, forKey: .category)
        try container.encode(tags, forKey: .tags)
        try container.encode(synonyms, forKey: .synonyms)
        try container.encode(duration, forKey: .duration)
        try container.encode(filename, forKey: .filename)
    }
}
