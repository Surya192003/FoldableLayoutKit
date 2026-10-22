import CoreGraphics

/// Geometry helpers for computing hinge rects from window size.
///
/// When native reserved-region APIs arrive, this enum is the only place that
/// changes. Consumers keep reading `FoldableDisplayPayload.hingeRect`.
public enum HingeGeometry {

    /// A centered vertical spine of the given width.
    /// Returns `nil` if the available width is smaller than the spine,
    /// which would produce a nonsense rect.
    public static func standardSpine(
        in size: CGSize,
        width: CGFloat = 16
    ) -> CGRect? {
        guard size.width > width else { return nil }
        return CGRect(
            x: (size.width - width) / 2,
            y: 0,
            width: width,
            height: size.height
        )
    }
}