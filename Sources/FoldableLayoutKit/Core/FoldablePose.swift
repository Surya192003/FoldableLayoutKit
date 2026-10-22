import Foundation

/// The physical posture of a folding or dual-screen device.
///
/// `.partiallyFolded` and `.tent` are reserved for future native APIs and
/// v1.1 spine-snap tuning, but are shipped now so that consumers and tests
/// never have to migrate on a breaking change.
public enum FoldablePose: String, Sendable, Equatable, CaseIterable {

    /// Closed clamshell — typically the outer display.
    case folded

    /// Fully open, flat canvas — typically the inner display.
    case unfolded

    /// Hinge partially engaged; canvas is one surface but not flat.
    case partiallyFolded

    /// Both halves angled toward the user, like a tent.
    case tent

    /// `true` whenever the canvas is larger than the folded silhouette.
    /// Use this to gate spine-aware layouts rather than comparing against `.unfolded`.
    public var isExpanded: Bool {
        switch self {
        case .folded: return false
        case .unfolded, .partiallyFolded, .tent: return true
        }
    }
}