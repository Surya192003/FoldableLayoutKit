# FoldableLayoutKit

**A friendly, drop-in SwiftUI package that makes your app feel native on foldable phones, dual-screen devices, and iPad multitasking.**

> If your app has to look right on a screen that gets wider (unfolded) or narrower (folded), this package handles it — safely, smoothly, and without rebuilding your views.

---

## Table of contents

1. [What this package does](#what-this-package-does)
2. [Is this for me?](#is-this-for-me)
3. [The problem we solve](#the-problem-we-solve)
4. [Requirements](#requirements)
5. [Installation](#installation)
6. [Five-minute quick start](#five-minute-quick-start)
7. [Core concepts (read once)](#core-concepts-read-once)
8. [Common patterns](#common-patterns)
9. [Preview both states in Xcode](#preview-both-states-in-xcode)
10. [Verified results (what to expect)](#verified-results-what-to-expect)
11. [Testing](#testing)
12. [Swapping the detector](#swapping-the-detector)
13. [Troubleshooting](#troubleshooting)
14. [Roadmap](#roadmap)
15. [License](#license)

---

## What this package does

It gives you four things:

| You want… | You use… |
|---|---|
| The correct margins automatically | `.foldableSafeArea()` |
| A navigation split view that adapts and preserves state | `FoldableNavigation` |
| Two panes that morph side-by-side ↔ stacked | `FoldableSplitView` |
| To read fold state in your own views | `@Environment(\.foldableDisplayPayload)` |

That's it. No `if sizeClass == .regular` branches scattered across your screens.

---

## Is this for me?

Yes, if **any** of these is true:

- Your app runs on **iPad and you support Split View, Slide Over, or Stage Manager** — the window size can change on the fly.
- You're building for **Apple's foldable iPhone** (or preparing for when it ships).
- You want to **test what your UI will look like** on a foldable, using Xcode previews.
- You're writing **a new SwiftUI app** and don't want to re-invent fold-aware layout.

**Not** for you if you only ship to older non-resizable devices. Skip this package; use a plain `NavigationStack`.

---

## The problem we solve

Look at the code every fold-aware app ends up writing:

```swift
// This is what everyone writes. It works… until it doesn't.
if horizontalSizeClass == .regular {
    NavigationSplitView {
        Sidebar()
    } detail: {
        Detail()
    }
} else {
    NavigationStack {
        Detail()
    }
}