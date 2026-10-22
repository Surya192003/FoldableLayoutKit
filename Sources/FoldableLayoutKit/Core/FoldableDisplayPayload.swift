import CoreGraphics

/// The immutable geometric reality of a foldable screen context.
///
/// Carries pose, hinge geometry, and margins together so that every consumer
/// (`FoldableSafeArea`, `FoldableSplitView`, `FoldableNavigation`) reads from a
/// single source of truth. When Apple ships native reserved-region APIs, the
/// same payload shape is populated from those APIs — no public API change.
public struct FoldableDisplayPayload: Equatable, Sendable {

    /// The current posture of the device.
    public let pose: FoldablePose

    /// The window-space bounds of the hinge / spine.
    /// `nil` when there is no hinge (folded, or outer display).
    public let hingeRect: CGRect?

    /// Side margins to apply on both outer edges.
    /// 24pt on the inner display, 16pt on the outer display.
    public let sideMargins: CGFloat

    /// Additional dead-zone buffer centered on the spine.
    /// 16pt when expanded, 0pt when folded. Applied symmetrically around the hinge.
    public let spineBufferWidth: CGFloat

    /// `true` whenever structural spine-aware layouts should activate.
    /// Derived — never store it independently, or the two can drift.
    public var spineIsActive: Bool {
        pose.isExpanded && hingeRect != nil && spineBufferWidth > 0
    }

    public init(
        pose: FoldablePose,
        hingeRect: CGRect? = nil,
        sideMargins: CGFloat? = nil,
        spineBufferWidth: CGFloat? = nil
    ) {
        self.pose = pose
        self.hingeRect = hingeRect
        self.sideMargins = sideMargins ?? (pose.isExpanded ? 24 : 16)
        self.spineBufferWidth = spineBufferWidth ?? (pose.isExpanded ? 16 : 0)
    }

    /// Safe static fallback — a folded device with no hinge.
    public static let zero = FoldableDisplayPayload(pose: .folded, hingeRect: nil)
}