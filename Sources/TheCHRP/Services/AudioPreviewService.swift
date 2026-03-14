import Foundation
#if canImport(AVFoundation)
import AVFoundation
#endif

/// Plays sound clips from the app bundle or a remote URL.
///
/// **Current capability:** bundle playback only.
/// When `sound.filename` is a bare filename (e.g. `"no_shot_01.m4a"`), the file
/// is looked up inside the app bundle. When it is a full URL the call is a no-op
/// until remote streaming support is added.
public final class AudioPreviewService {
#if canImport(AVFoundation)
    private var player: AVAudioPlayer?
#endif

    public init() {}

    /// Attempts to play the given sound.
    /// - Parameter sound: The sound clip to play.
    public func play(sound: Sound) {
#if canImport(AVFoundation)
        // Determine whether filename is a full URL (http/https) or a bundle resource name.
        if let parsedURL = URL(string: sound.filename),
           parsedURL.scheme == "http" || parsedURL.scheme == "https" {
            // Remote URL – streaming not yet implemented; skip silently.
            return
        }

        guard let bundleURL = Bundle.main.url(forResource: sound.filename, withExtension: nil) else {
            return
        }

        do {
            player = try AVAudioPlayer(contentsOf: bundleURL)
            player?.play()
        } catch {
            // Failed to initialise player – nothing the caller can do; fail silently.
        }
#endif
    }

    /// Stops any currently playing sound.
    public func stop() {
#if canImport(AVFoundation)
        player?.stop()
        player = nil
#endif
    }
}
