import XCTest
@testable import FoldableLayoutKit

final class HeuristicFoldResolverTests: XCTestCase {

    func testTestOverrideUnfolded() {
        let r = HeuristicFoldResolver(testingPose: .unfolded)
        XCTAssertEqual(r.pose, .unfolded)
    }

    func testTestOverrideFolded() {
        let r = HeuristicFoldResolver(testingPose: .folded)
        XCTAssertEqual(r.pose, .folded)
    }

    func testTestOverrideTent() {
        let r = HeuristicFoldResolver(testingPose: .tent)
        XCTAssertEqual(r.pose, .tent)
        XCTAssertTrue(r.pose.isExpanded)
    }

    /// Documents the environment footgun: a resolver constructed without an
    /// environment installed falls through to `.folded`. This is why tests
    /// should always use `init(testingPose:)`.
    func testNoEnvironmentFallsBackToFolded() {
        let r = HeuristicFoldResolver()
        XCTAssertEqual(r.pose, .folded)
    }
}