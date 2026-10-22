import SwiftUI

/// Spring presets tuned for fold transitions.
///
/// `.compress` and `.expand` are used internally by the package but are also
/// public, so app code can stay consistent with system-level motion when it
/// runs its own animations alongside fold events.
public enum FoldableSpringPreset: Sendable {
    /// Used when the canvas shrinks — outer → inner collapse, or multitasking.
    case compress

    /// Used when the canvas grows — inner → outer unfold.
    case expand

    /// Reserved for v1.1 spine-snap. Never referenced by v1 code paths.
    case snap
}

@available(macOS 10.15, *)
public extension Animation {
    static func foldable(_ preset: FoldableSpringPreset) -> Animation {
        switch preset {
        case .compress: return .spring(response: 0.35, dampingFraction: 0.82)
        case .expand:   return .spring(response: 0.45, dampingFraction: 0.78)
        case .snap:     return .spring(response: 0.22, dampingFraction: 0.90)
        }
    }
}