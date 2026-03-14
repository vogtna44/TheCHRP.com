import XCTest
@testable import TheCHRP

// MARK: - Helpers

/// A `SoundLibraryService` that immediately returns a preset list.
private final class StubSoundLibraryService: SoundLibraryService {
    let stubbedSounds: [Sound]

    init(sounds: [Sound] = []) {
        self.stubbedSounds = sounds
    }

    func fetchSounds() async throws -> [Sound] {
        stubbedSounds
    }
}

/// A `SoundLibraryService` that always throws the given error.
private final class FailingSoundLibraryService: SoundLibraryService {
    let error: Error

    init(error: Error = URLError(.notConnectedToInternet)) {
        self.error = error
    }

    func fetchSounds() async throws -> [Sound] {
        throw error
    }
}

private let sampleSound = Sound(
    id: "no_shot_01",
    title: "No shot!",
    transcript: "No shot.",
    category: "Trending",
    tags: ["reaction", "hype"],
    synonyms: ["no way"],
    duration: 2.0,
    filename: "no_shot_01.m4a"
)

// MARK: - Sound model tests

final class SoundModelTests: XCTestCase {
    func testDecodingFromJSON() throws {
        let json = """
        {
            "id": "no_shot_01",
            "title": "No shot!",
            "transcript": "No shot.",
            "category": "Trending",
            "tags": ["reaction", "hype"],
            "synonyms": ["no way"],
            "duration": 2.0,
            "filename": "no_shot_01.m4a"
        }
        """.data(using: .utf8)!

        let sound = try JSONDecoder().decode(Sound.self, from: json)

        XCTAssertEqual(sound.id, "no_shot_01")
        XCTAssertEqual(sound.title, "No shot!")
        XCTAssertEqual(sound.transcript, "No shot.")
        XCTAssertEqual(sound.category, "Trending")
        XCTAssertEqual(sound.tags, ["reaction", "hype"])
        XCTAssertEqual(sound.synonyms, ["no way"])
        XCTAssertEqual(sound.duration, 2.0, accuracy: 0.001)
        XCTAssertEqual(sound.filename, "no_shot_01.m4a")
    }

    func testDecodingArrayFromJSON() throws {
        let json = """
        [
            {
                "id": "no_shot_01",
                "title": "No shot!",
                "transcript": "No shot.",
                "category": "Trending",
                "tags": ["reaction", "hype"],
                "synonyms": ["no way"],
                "duration": 2.0,
                "filename": "https://thechrp.com/audio/no_shot_01.m4a"
            }
        ]
        """.data(using: .utf8)!

        let sounds = try JSONDecoder().decode([Sound].self, from: json)

        XCTAssertEqual(sounds.count, 1)
        XCTAssertEqual(sounds[0].filename, "https://thechrp.com/audio/no_shot_01.m4a")
    }
}

// MARK: - CHRPSoundAPI tests

final class CHRPSoundAPITests: XCTestCase {
    func testBaseURLString() {
        XCTAssertEqual(CHRPSoundAPI.baseURLString, "https://thechrp.com/api")
    }

    func testSoundsURL() {
        XCTAssertEqual(CHRPSoundAPI.soundsURL.absoluteString, "https://thechrp.com/api/sounds")
    }
}

// MARK: - FallbackSoundLibraryService tests

final class FallbackSoundLibraryServiceTests: XCTestCase {
    func testReturnsSoundsWhenRemoteSucceeds() async throws {
        let stub = StubSoundLibraryService(sounds: [sampleSound])
        let service = FallbackSoundLibraryService(remote: stub)

        let sounds = try await service.fetchSounds()

        XCTAssertEqual(sounds, [sampleSound])
    }

    func testReturnsEmptyListWhenRemoteFails() async throws {
        let failing = FailingSoundLibraryService()
        let service = FallbackSoundLibraryService(remote: failing)

        let sounds = try await service.fetchSounds()

        XCTAssertEqual(sounds, [])
    }
}

// MARK: - SoundListViewModel tests

@MainActor
final class SoundListViewModelTests: XCTestCase {
    func testLoadSoundsPopulatesSounds() async {
        let stub = StubSoundLibraryService(sounds: [sampleSound])
        let viewModel = SoundListViewModel(soundLibrary: stub)

        await viewModel.loadSounds()

        XCTAssertEqual(viewModel.sounds, [sampleSound])
        XCTAssertFalse(viewModel.isLoading)
    }

    func testLoadSoundsYieldsEmptyListWhenServiceFails() async {
        let failing = FailingSoundLibraryService()
        let viewModel = SoundListViewModel(soundLibrary: failing)

        await viewModel.loadSounds()

        XCTAssertEqual(viewModel.sounds, [])
        XCTAssertFalse(viewModel.isLoading)
    }

    func testIsLoadingIsTrueWhileFetching() async {
        let stub = StubSoundLibraryService(sounds: [sampleSound])
        let viewModel = SoundListViewModel(soundLibrary: stub)

        XCTAssertFalse(viewModel.isLoading)
        await viewModel.loadSounds()
        XCTAssertFalse(viewModel.isLoading)
    }
}
