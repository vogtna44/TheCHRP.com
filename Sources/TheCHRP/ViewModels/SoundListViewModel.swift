import Foundation
#if canImport(Combine)
import Combine

/// Observable view model that drives the sound list UI.
///
/// By default it uses `FallbackSoundLibraryService`, which tries the CHRP website
/// API first and returns an empty list when the site is not yet reachable.
@MainActor
public final class SoundListViewModel: ObservableObject {
    /// The sounds to display, populated after `loadSounds()` completes.
    @Published public var sounds: [Sound] = []
    /// `true` while a fetch is in progress.
    @Published public var isLoading: Bool = false

    private let soundLibrary: SoundLibraryService

    /// - Parameter soundLibrary: The service used to fetch sounds.
    ///   Defaults to `FallbackSoundLibraryService()`.
    public init(soundLibrary: SoundLibraryService = FallbackSoundLibraryService()) {
        self.soundLibrary = soundLibrary
    }

    /// Fetches the sound catalog and publishes the result on `sounds`.
    /// Safe to call from a SwiftUI `.task` modifier or any async context.
    public func loadSounds() async {
        isLoading = true
        defer { isLoading = false }
        sounds = (try? await soundLibrary.fetchSounds()) ?? []
    }
}
#else
/// Observable view model that drives the sound list UI.
///
/// By default it uses `FallbackSoundLibraryService`, which tries the CHRP website
/// API first and returns an empty list when the site is not yet reachable.
@MainActor
public final class SoundListViewModel {
    /// The sounds to display, populated after `loadSounds()` completes.
    public var sounds: [Sound] = []
    /// `true` while a fetch is in progress.
    public var isLoading: Bool = false

    private let soundLibrary: SoundLibraryService

    /// - Parameter soundLibrary: The service used to fetch sounds.
    ///   Defaults to `FallbackSoundLibraryService()`.
    public init(soundLibrary: SoundLibraryService = FallbackSoundLibraryService()) {
        self.soundLibrary = soundLibrary
    }

    /// Fetches the sound catalog and publishes the result on `sounds`.
    /// Safe to call from a SwiftUI `.task` modifier or any async context.
    public func loadSounds() async {
        isLoading = true
        defer { isLoading = false }
        sounds = (try? await soundLibrary.fetchSounds()) ?? []
    }
}
#endif
