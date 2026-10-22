import SwiftUI

/// Renders a view side-by-side in folded and unfolded configurations.
///
/// ```swift
/// #Preview {
///     FoldablePreview {
///         FoldableNavigation {
///             Text("Sidebar")
///         } content: {
///             Text("Content")
///         } detail: {
///             Text("Detail")
///         }
///         .foldableSafeArea()
///     }
/// }
/// ```
@available(macOS 10.15, *)
@available(macOS 14.00, *)
public struct FoldablePreview<Content: View>: View {

    public static var outerSize: CGSize { .init(width: 393, height: 852) }
    public static var innerSize: CGSize { .init(width: 744, height: 1008) }

    private let content: () -> Content

    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    public var body: some View {
        HStack(alignment: .top, spacing: 24) {
            panel(title: "Folded 5.4\"",   size: Self.outerSize, pose: .folded)
            panel(title: "Unfolded 7.6\"", size: Self.innerSize, pose: .unfolded)
        }
        .padding()
    }

    private func panel(
        title: String,
        size: CGSize,
        pose: FoldablePose
    ) -> some View {
        let hinge = pose.isExpanded
            ? HingeGeometry.standardSpine(in: size)
            : nil
        let payload = FoldableDisplayPayload(pose: pose, hingeRect: hinge)

        return VStack(spacing: 8) {
            if #available(macOS 14.0, *) {
                Text(title)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            } else {
                // Fallback on earlier versions
            }

            content()
                .frame(width: size.width, height: size.height)
                .environment(\.foldableDisplayPayload, payload)
                .clipShape(RoundedRectangle(cornerRadius: 32))
                .overlay(
                    RoundedRectangle(cornerRadius: 32)
                        .strokeBorder(.separator, lineWidth: 1)
                )
        }
    }
}