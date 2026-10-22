import SwiftUI

/// How the modifier should treat the spine.
public enum SpinePolicy: Sendable {

    /// Add `spineBufferWidth` to both horizontal paddings.
    /// Use this for content that spans across the spine as a single surface.
    case conservative

    /// Do not add spine padding — the developer is handling it.
    /// Use this when wrapping content in `FoldableSplitView`, which
    /// spaces its columns by `spineBufferWidth * 2`.
    case passthrough
}

/// What part of the view tree this safe area applies to.
public enum FoldableSafeAreaRole: Sendable {

    /// Content is inset by side margins (and spine buffer, per policy).
    case content

    /// Background artwork — bleeds through, no insets.
    case background
}

@available(macOS 10.15, *)
private struct FoldableSafeAreaModifier: ViewModifier {
    let role: FoldableSafeAreaRole
    let policy: SpinePolicy

    @Environment(\.foldableDisplayPayload) private var payload

    func body(content: Content) -> some View {
        switch role {
        case .background:
            content

        case .content:
            let spine = (policy == .conservative && payload.spineIsActive)
                ? payload.spineBufferWidth
                : 0

            content
                .padding(.leading,  payload.sideMargins + spine)
                .padding(.trailing, payload.sideMargins + spine)
        }
    }
}

@available(macOS 10.15, *)
public extension View {

    /// Applies fold-aware side margins (24pt inner / 16pt outer) and,
    /// optionally, the spine dead-zone buffer.
    ///
    /// ```swift
    /// MyScreen()
    ///     .foldableSafeArea()                              // content, conservative
    ///     .background(Color.black.ignoresSafeArea())       // background bleeds
    /// ```
    func foldableSafeArea(
        role: FoldableSafeAreaRole = .content,
        policy: SpinePolicy = .conservative
    ) -> some View {
        modifier(FoldableSafeAreaModifier(role: role, policy: policy))
    }
}