# Changelog

All notable changes to this project will be documented in this file.
This project adheres to [Semantic Versioning](https://semver.org/).

## [1.0.0] — 2026-10-22

### Added
- `FoldablePose` with `.folded`, `.unfolded`, `.partiallyFolded`, `.tent`.
- `FoldableDisplayPayload` — pose, hinge rect, side margins, spine buffer,
  derived `spineIsActive`.
- `FoldDetecting` protocol (`DynamicProperty`, `pose` only).
- `HeuristicFoldResolver` (size-class based) with `init(testingPose:)`.
- `HingeGeometry.standardSpine(in:width:)`.
- `.foldableLayoutEnvironment()` — resolves geometry inside a
  `GeometryReader` so rects are in window coordinates.
- `.foldableSafeArea(role:policy:)` — role-aware safe area with spine
  policy.
- `FoldableNavigation` — drop-in `NavigationSplitView` with continuity-safe
  column visibility morph.
- `FoldableSplitView` — compositional `AnyLayout` morph.
- `Animation.foldable(_:)` with `.compress`, `.expand`, `.snap`.
- `FoldablePreview` — folded + unfolded side-by-side preview helper.
- Unit tests for payload defaults, pose expansion, hinge geometry, and
  resolver injection.

### Deferred
- Spine snap and haptic sync — v1.1.
- `thumbZone(.peripheral)` — v1.1.
- Pane-anchored modals — v2.