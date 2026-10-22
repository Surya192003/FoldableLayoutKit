import SwiftUI

/// Compositional primitive: two panes that morph between stacked and
/// side-by-side as the fold state changes.
///
/// Uses `AnyLayout` so that the two child views keep their identity across
/// fold events. This is the M2 continuity guarantee: no view is rebuilt,
/// only its arrangement changes.
@available(macOS 10.15, *)
public struct FoldableSplitView<Leading: View, Trailing: View>: View {

    @Environment(\.foldableDisplayPayload) private var payload

    private let leading: () -> Leading
    private let trailing: () -> Trailing

    public init(
        @ViewBuilder leading: @escaping () -> Leading,
        @ViewBuilder trailing: @escaping () -> Trailing
    ) {
        self.leading = leading
        self.trailing = trailing
    }

    public var body: some View {
        let isExpanded = payload.pose.isExpanded
        let spacing = isExpanded ? payload.spineBufferWidth * 2 : 0

        Group {
            if #available(macOS 13.0, *) {
                let layout: AnyLayout = isExpanded
                    ? AnyLayout(HStackLayout(spacing: spacing))
                    : AnyLayout(VStackLayout(spacing: 0))

                layout {
                    leading()
                    trailing()
                }
            } else if isExpanded {
                HStack(spacing: spacing) {
                    leading()
                    trailing()
                }
            } else {
                VStack(spacing: 0) {
                    leading()
                    trailing()
                }
            }
        }
        .animation(
            .foldable(isExpanded ? .expand : .compress),
            value: payload.pose
        )
    }
}