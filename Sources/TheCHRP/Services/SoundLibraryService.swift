import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

// MARK: - API Configuration

/// Central location for the CHRP sound API base URL.
/// Update `baseURLString` once the website is live at its final address.
public enum CHRPSoundAPI {
    public static let baseURLString = "https://thechrp.com/api"

    /// The endpoint that returns the full sound catalog as a JSON array.
    public static var soundsURL: URL {
        // Force-unwrap is intentional: a malformed constant is a programmer error.
        URL(string: "\(baseURLString)/sounds")!
    }
}

// MARK: - Protocol

/// A type that can supply the catalog of available sounds.
public protocol SoundLibraryService {
    /// Fetches and returns the list of available sounds.
    /// - Throws: Any networking or decoding error encountered during the fetch.
    func fetchSounds() async throws -> [Sound]
}

// MARK: - Remote implementation

/// Fetches the sound catalog from the CHRP website API.
///
/// ### Expected JSON shape
///
/// Each element in the returned array must include the required Stage 1 fields.
/// The optional Stage 2 Chirp Card fields (`cardTitle`, `creatorTag`, `packName`)
/// may be omitted or `null`; the `Sound` model defaults them to `nil`.
/// See `PRODUCT.md` and `COPILOT_BRIEF_LANDING.md` for the full API contract.
///
/// ```json
/// {
///   "id":         "no_shot_01",
///   "title":      "No shot!",
///   "transcript": "No shot.",
///   "category":   "Trending",
///   "tags":       ["reaction", "disbelief"],
///   "synonyms":   ["no way", "impossible"],
///   "duration":   2.0,
///   "filename":   "no_shot_01.m4a",
///   "cardTitle":  "No shot 🙅",
///   "creatorTag": "@chrp",
///   "packName":   "Reaction Pack"
/// }
/// ```
public final class RemoteSoundLibraryService: SoundLibraryService {
    private let url: URL
    private let session: URLSession

    /// - Parameters:
    ///   - url: The endpoint to request. Defaults to `CHRPSoundAPI.soundsURL`.
    ///   - session: The URL session to use. Defaults to `URLSession.shared`.
    public init(url: URL = CHRPSoundAPI.soundsURL, session: URLSession = .shared) {
        self.url = url
        self.session = session
    }

    public func fetchSounds() async throws -> [Sound] {
        let (data, _) = try await session.data(from: url)
        return try JSONDecoder().decode([Sound].self, from: data)
    }
}
