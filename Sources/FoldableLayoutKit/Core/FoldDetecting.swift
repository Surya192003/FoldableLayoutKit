import SwiftUI

/// Blueprint for detecting physical folds without exposing hardware details.
///
/// Conforms to `DynamicProperty` so SwiftUI automatically invalidates any
/// view that reads `pose` when the environment changes. Geometry is
/// deliberately absent from this protocol — hinge rects live only in the
/// environment-injection modifier, where a `GeometryProxy` exists.
@available(macOS 10.15, *)
public protocol FoldDetecting: DynamicProperty {
    var pose: FoldablePose { get }
}