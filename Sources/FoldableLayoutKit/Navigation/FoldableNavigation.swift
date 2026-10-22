import SwiftUI

/// Drop-in replacement for `NavigationSplitView` that adapts to fold state.
///
/// **Continuity guarantee:** the underlying `NavigationSplitView` instance
/// is never destroyed across a fold event — only `columnVisibility` morphs.
/// That preserves focus state, scroll offsets, and keyboard presence.
@available(macOS 10.15, *)
public struct FoldableNavigation<Sidebar: View, Content: View, Detail: View>: View {

    @Environment(\.foldableDisplayPayload) private var payload
    @State private var isExpanded = true
    @State private var lastPose: FoldablePose?

    private let sidebar: () -> Sidebar
    private let content: () -> Content
    private let detail: () -> Detail

    public init(
        @ViewBuilder sidebar: @escaping () -> Sidebar,
        @ViewBuilder content: @escaping () -> Content,
        @ViewBuilder detail: @escaping () -> Detail
    ) {
        self.sidebar = sidebar
        self.content = content
        self.detail = detail
    }

    public var body: some View {
        if #available(macOS 13.0, *) {
            NavigationSplitView(columnVisibility: Binding(
                get: { isExpanded ? .all : .detailOnly },
                set: { isExpanded = ($0 == .all) }
            )) {
                sidebar()
            } content: {
                content()
            } detail: {
                detail()
            }
            .onAppear {
                syncVisibility(to: payload.pose, animated: false)
            }
            .onChange(of: payload.pose) { new in
                syncVisibility(to: new, animated: true)
            }
        } else {
            NavigationView {
                sidebar()
                content()
                detail()
            }
        }
    }

    @available(macOS 13.0, *)
    private func syncVisibility(to pose: FoldablePose, animated: Bool) {
        guard lastPose != pose else { return }
        lastPose = pose

        if animated {
            withAnimation(.foldable(pose.isExpanded ? .expand : .compress)) {
                isExpanded = pose.isExpanded
            }
        } else {
            isExpanded = pose.isExpanded
        }
    }
}