# FoldableLayoutKit

Layout primitives for SwiftUI apps that run on **foldable phones**, **dual-screen devices**, and **iPad multitasking contexts** (Split View, Slide Over, Stage Manager).

If your app needs to look correct when the available window gets wider or narrower — without rebuilding views, losing keyboard focus, or snapping the layout — this package handles that in one modifier.

SwiftUI-first layout primitives for foldable iPhones and dual-screen canvases.

`FoldableLayoutKit` gives your app a single source of truth for fold state,
hinge geometry, and safe-area margins — so your UI can stretch, reflow, and
preserve state across fold events without a `if sizeClass == .regular`
branch in every view.

- **Continuity-first.** No view identity is destroyed across a fold.
  Focus state, scroll offsets, and keyboards survive.
- **Geometry in the right coordinate space.** Hinge rects are resolved
  inside a `GeometryReader`, so they are correct in full-screen, split view,
  Slide Over, and Stage Manager.
- **Testable.** Every hardware-dependent type has an explicit test-injection
  entry point. No silent environment fallbacks in headless runners.
- **Future-proof.** The fold detector is a swappable `DynamicProperty` behind
  a two-property protocol. When Apple ships native reserved-region APIs,
  swap the conformer — no consumer changes, no protocol changes.

## Requirements

- iOS 17+
- Swift 5.9+
- SwiftUI only (UIKit is out of scope for v1)

## Installation

Add the package from Xcode: **File → Add Package Dependencies…** and enter
your repository URL, or add it to `Package.swift`:

```swift
.package(url: "https://github.com/your-org/FoldableLayoutKit.git", from: "1.0.0")

## The problem

Without this package, every fold-aware screen turns into this:

```swift
// This is what everyone writes. It's wrong.
if horizontalSizeClass == .regular {
    NavigationSplitView { /* ... */ }
} else {
    NavigationStack { /* ... */ }
}