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
}
