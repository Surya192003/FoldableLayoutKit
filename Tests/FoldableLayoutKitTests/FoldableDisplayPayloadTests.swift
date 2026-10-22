import XCTest
@testable import FoldableLayoutKit

final class FoldableDisplayPayloadTests: XCTestCase {

    func testFoldedDefaults() {
        let p = FoldableDisplayPayload(pose: .folded)
        XCTAssertEqual(p.sideMargins, 16)
        XCTAssertEqual(p.spineBufferWidth, 0)
        XCTAssertNil(p.hingeRect)
        XCTAssertFalse(p.spineIsActive)
    }

    func testUnfoldedDefaults() {
        let hinge = CGRect(x: 100, y: 0, width: 16, height: 1000)
        let p = FoldableDisplayPayload(pose: .unfolded, hingeRect: hinge)
        XCTAssertEqual(p.sideMargins, 24)
        XCTAssertEqual(p.spineBufferWidth, 16)
        XCTAssertTrue(p.spineIsActive)
    }

    func testUnfoldedWithoutHingeIsNotActive() {
        let p = FoldableDisplayPayload(pose: .unfolded, hingeRect: nil)
        XCTAssertFalse(p.spineIsActive, "No hinge rect means no active spine.")
    }

    func testPartialAndTentAreExpanded() {
        XCTAssertTrue(FoldablePose.partiallyFolded.isExpanded)
        XCTAssertTrue(FoldablePose.tent.isExpanded)
    }

    func testOverridesWin() {
        let p = FoldableDisplayPayload(
            pose: .unfolded,
            hingeRect: CGRect(x: 0, y: 0, width: 16, height: 100),
            sideMargins: 32,
            spineBufferWidth: 24
        )
        XCTAssertEqual(p.sideMargins, 32)
        XCTAssertEqual(p.spineBufferWidth, 24)
    }

    func testZero() {
        XCTAssertEqual(FoldableDisplayPayload.zero.pose, .folded)
        XCTAssertNil(FoldableDisplayPayload.zero.hingeRect)
        XCTAssertFalse(FoldableDisplayPayload.zero.spineIsActive)
    }

    func testPoseExpansion() {
        XCTAssertFalse(FoldablePose.folded.isExpanded)
        XCTAssertTrue(FoldablePose.unfolded.isExpanded)
    }
}