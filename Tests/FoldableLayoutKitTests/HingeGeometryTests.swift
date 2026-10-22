import XCTest
@testable import FoldableLayoutKit

final class HingeGeometryTests: XCTestCase {

    func testCenteredSpine() {
        let size = CGSize(width: 744, height: 1008)
        let rect = HingeGeometry.standardSpine(in: size)
        XCTAssertNotNil(rect)
        XCTAssertEqual(rect!.midX, 372, accuracy: 0.001)
        XCTAssertEqual(rect!.width, 16)
        XCTAssertEqual(rect!.height, 1008)
    }

    func testCustomWidth() {
        let size = CGSize(width: 744, height: 1008)
        let rect = HingeGeometry.standardSpine(in: size, width: 24)
        XCTAssertEqual(rect!.width, 24)
        XCTAssertEqual(rect!.midX, 372, accuracy: 0.001)
    }

    func testTooNarrowReturnsNil() {
        let size = CGSize(width: 10, height: 100)
        XCTAssertNil(HingeGeometry.standardSpine(in: size))
    }
}