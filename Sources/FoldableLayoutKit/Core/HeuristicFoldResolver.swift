import SwiftUI

/// Heuristic resolver that infers pose from the horizontal size class.
///
/// This is the v1 fallback. When Apple exposes native reserved-region APIs,
/// swap `FoldDetecting` conformers without touching the rest of the package.
/// See `NativeHardwareFoldResolver` in the roadmap.
///
/// **Test tip:** Use `init(testingPose:)` in unit tests. Reading `pose` from
/// a resolver that has no environment installed will fall through to `.folded`,
/// which is a silent footgun in headless runners.
@available(macOS 10.15, *)
public struct HeuristicFoldResolver: FoldDetecting {

    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    private let testOverridePose: FoldablePose?

    /// Standard production initialization — reads the environment on each body pass.
    public init() {
        self.testOverridePose = nil
    }

    /// Deterministic test / preview initialization.
    /// Bypasses the environment so that headless runners and snapshot tests
    /// cannot be silently poisoned by a missing or unexpected size class.
    public init(testingPose: FoldablePose) {
        self.testOverridePose = testingPose
    }

    public var pose: FoldablePose {
        if let override = testOverridePose { return override }
        return horizontalSizeClass == .regular ? .unfolded : .folded
    }
}

// MARK: - Future native bridge
//
// internal struct NativeHardwareFoldResolver: FoldDetecting {
//     @Environment(\.displayFoldRegions) private var regions
//
//     var pose: FoldablePose {
//         regions.isEmpty ? .folded : .unfolded
//     }
// }