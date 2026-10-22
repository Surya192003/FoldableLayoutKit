import SwiftUI

// MARK: - Environment key

private struct FoldableDisplayPayloadKey: EnvironmentKey {
    static let defaultValue: FoldableDisplayPayload = .zero
}

@available(macOS 10.15, *)
public extension EnvironmentValues {
    /// The current fold context. Read this from any view inside a
    /// `.foldableLayoutEnvironment()` scope.
    var foldableDisplayPayload: FoldableDisplayPayload {
        get { self[FoldableDisplayPayloadKey.self] }
        set { self[FoldableDisplayPayloadKey.self] = newValue }
    }
}

// MARK: - Injector

@available(macOS 10.15, *)
private struct FoldableEnvironmentModifier<Detector: FoldDetecting>: ViewModifier {
    var detector: Detector

    func body(content: Content) -> some View {
        GeometryReader { proxy in
            let pose = detector.pose
            let hinge = pose.isExpanded
                ? HingeGeometry.standardSpine(in: proxy.size)
                : nil

            let payload = FoldableDisplayPayload(pose: pose, hingeRect: hinge)

            content
                .environment(\.foldableDisplayPayload, payload)
                .animation(
                    .foldable(pose.isExpanded ? .expand : .compress),
                    value: pose
                )
        }
    }
}

// MARK: - Public entry point

@available(macOS 10.15, *)
public extension View {

    /// Injects fold-aware environment values, resolved by the given detector.
    ///
    /// Apply this **near the root** of your view hierarchy — it wraps content
    /// in a `GeometryReader`, which means the content will fill its parent.
    /// Applying it inside a small subview will make that subview greedy.
    ///
    /// Defaults to `HeuristicFoldResolver` (size-class based).
    /// Inject a custom `FoldDetecting` conformer when native APIs ship.
    func foldableLayoutEnvironment<D: FoldDetecting>(
        detector: D = HeuristicFoldResolver()
    ) -> some View {
        modifier(FoldableEnvironmentModifier(detector: detector))
    }
}