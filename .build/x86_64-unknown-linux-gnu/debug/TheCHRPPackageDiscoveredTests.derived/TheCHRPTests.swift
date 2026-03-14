import XCTest
@testable import TheCHRPTests

fileprivate extension CHRPSoundAPITests {
    @available(*, deprecated, message: "Not actually deprecated. Marked as deprecated to allow inclusion of deprecated tests (which test deprecated functionality) without warnings")
    static nonisolated(unsafe) let __allTests__CHRPSoundAPITests = [
        ("testBaseURLString", testBaseURLString),
        ("testSoundsURL", testSoundsURL)
    ]
}

fileprivate extension FallbackSoundLibraryServiceTests {
    @available(*, deprecated, message: "Not actually deprecated. Marked as deprecated to allow inclusion of deprecated tests (which test deprecated functionality) without warnings")
    static nonisolated(unsafe) let __allTests__FallbackSoundLibraryServiceTests = [
        ("testReturnsEmptyListWhenRemoteFails", asyncTest(testReturnsEmptyListWhenRemoteFails)),
        ("testReturnsSoundsWhenRemoteSucceeds", asyncTest(testReturnsSoundsWhenRemoteSucceeds))
    ]
}

fileprivate extension SoundListViewModelTests {
    @available(*, deprecated, message: "Not actually deprecated. Marked as deprecated to allow inclusion of deprecated tests (which test deprecated functionality) without warnings")
    static nonisolated(unsafe) let __allTests__SoundListViewModelTests = [
        ("testIsLoadingIsTrueWhileFetching", asyncTest(testIsLoadingIsTrueWhileFetching)),
        ("testLoadSoundsPopulatesSounds", asyncTest(testLoadSoundsPopulatesSounds)),
        ("testLoadSoundsYieldsEmptyListWhenServiceFails", asyncTest(testLoadSoundsYieldsEmptyListWhenServiceFails))
    ]
}

fileprivate extension SoundModelTests {
    @available(*, deprecated, message: "Not actually deprecated. Marked as deprecated to allow inclusion of deprecated tests (which test deprecated functionality) without warnings")
    static nonisolated(unsafe) let __allTests__SoundModelTests = [
        ("testDecodingArrayFromJSON", testDecodingArrayFromJSON),
        ("testDecodingFromJSON", testDecodingFromJSON)
    ]
}
@available(*, deprecated, message: "Not actually deprecated. Marked as deprecated to allow inclusion of deprecated tests (which test deprecated functionality) without warnings")
func __TheCHRPTests__allTests() -> [XCTestCaseEntry] {
    return [
        testCase(CHRPSoundAPITests.__allTests__CHRPSoundAPITests),
        testCase(FallbackSoundLibraryServiceTests.__allTests__FallbackSoundLibraryServiceTests),
        testCase(SoundListViewModelTests.__allTests__SoundListViewModelTests),
        testCase(SoundModelTests.__allTests__SoundModelTests)
    ]
}