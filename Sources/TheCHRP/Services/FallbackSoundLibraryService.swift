import Foundation

/// A `SoundLibraryService` that wraps a remote service and degrades gracefully.
///
/// On success, it returns whatever the remote service provides.
/// If the remote request fails for any reason (network unavailable, server error,
/// decoding error, etc.), it returns an empty array so the app remains usable
/// while the website is not yet live.
public final class FallbackSoundLibraryService: SoundLibraryService {
    private let remote: SoundLibraryService

    /// - Parameter remote: The underlying service to attempt first.
    ///   Defaults to `RemoteSoundLibraryService()`.
    public init(remote: SoundLibraryService = RemoteSoundLibraryService()) {
        self.remote = remote
    }

    public func fetchSounds() async throws -> [Sound] {
        do {
            return try await remote.fetchSounds()
        } catch {
            return []
        }
    }
}
