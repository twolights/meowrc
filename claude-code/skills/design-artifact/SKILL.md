---
name: design-artifact
description: Use when designing self-contained HTML artifacts — hi-fi clickable prototypes, slide decks, posters, animations, design canvases, or visual exploration files — where the user expects context-rooted design with multiple variations rather than a single from-scratch attempt.
---

# Design Artifact

## Overview

Produce thoughtful, well-crafted HTML design artifacts. HTML is the tool; the medium varies — slide deck, prototype, poster, animation, design canvas. Embody the relevant expertise (animator, slide designer, UX prototyper, editorial designer). Avoid generic web-design tropes unless the artifact is literally a web page.

## When to Use

**Triggers:** "design a", "prototype", "make a deck", "build a landing page", "interactive demo", "explore variations", "design canvas".

**Don't use for:**
- Production frontend code embedded in an app → use `frontend-design`.
- Pure CSS/component work without exploration.
- Technical documentation, README writing, etc.

## Core Workflow

1. **Ask before pixels.** For new or ambiguous work, ask focused questions in one round:
   - Output format and fidelity? (deck / prototype / poster / canvas of options)
   - Audience and tone?
   - Constraints (length, brand, deadline)?
   - **Existing design context** — UI kit, codebase, design system, screenshots, brand assets? *Always confirm a starting point.* Designing without context produces poor work.
   - How many variations, across what dimensions (visuals / interactions / copy / flow)?

2. **Gather context aggressively.** Hi-fi designs are rooted in existing context, never invented from scratch. If the user can't supply a UI kit / codebase / screenshots, say so explicitly and either ask again or proceed with assumptions stated visibly in the file.

3. **Sketch reasoning before pixels.** Open the HTML file with a short block of assumptions, design rationale, and visible placeholders. **Show this to the user early** — don't render a final prototype before agreeing on direction.

4. **Build, then iterate.** Write the artifact. Show the user. Append "Next steps" or open questions at the bottom. Iterate.

5. **Verify.** Open the file in a browser via the `playwright-cli` skill — check it loads cleanly, no console errors, visuals match intent. For decks, verify keyboard nav and slide-counter alignment.

## Variations Are the Default

For any design exploration: **give 3+ variations across different dimensions.** Mix conventional (matches existing patterns) with novel (interesting layouts, metaphors, type treatments, scale plays). Start basic; get more advanced and creative as you go.

When the user asks for a "new version" or change, **add it as a toggle inside the original file** — don't fork into multiple files. One canonical file with switchable variants is easier to compare and refine.

## Choosing Format

| Exploring | Format |
|---|---|
| Pure visual (color, type, single static layout) | Design canvas — lay options side by side in one file |
| Interactions, flows, multi-screen | Hi-fi clickable prototype with route/state |
| Pitch / story | Slide deck (one self-scaling HTML file) |
| Comparison of style options | Canvas of variants OR tabbed prototype |

## Aesthetic Guidelines

- **Typography**: distinctive display font + refined body font. Avoid Inter / Roboto / Arial / system fonts as the headline choice.
- **Color**: pull from the user's brand or design system. If too restrictive, use `oklch()` to define harmonious palettes that fit the existing tonality. Don't invent colors from scratch. Dominant colors with sharp accents > evenly distributed timid palettes.
- **Motion**: prefer CSS-only animation. Concentrate it on high-impact moments — one orchestrated page-load with staggered reveals beats scattered micro-interactions.
- **Spatial composition**: asymmetry, overlap, grid-breaking. Generous whitespace OR controlled density — pick a side.
- **Backgrounds**: gradient meshes, noise textures, geometric patterns, layered transparency, dramatic shadows. Don't default to solid white.
- **Emoji**: only if the existing design system uses them.
- **Missing icons / assets**: draw a labeled placeholder. A clear placeholder beats a bad attempt at the real thing.

**Avoid generic AI aesthetics:** purple-on-white gradients, predictable layouts, cookie-cutter component patterns, system fonts as headline. Make context-specific choices.

## File Craft

- Descriptive filenames: `Landing Page.html`, `Onboarding Prototype v2.html`.
- For significant revisions, copy and version (`My Design.html`, `My Design v2.html`) so older versions are preserved.
- Files >1000 lines: split into smaller files and compose. Easier to edit and review.
- For decks/animations, persist current slide index or playback time in `localStorage` so refreshes don't lose context — critical during iterative design.

## React + Babel (inline JSX)

When writing inline-React prototypes, pin versions and use integrity hashes:

```html
<script src="https://unpkg.com/react@18.3.1/umd/react.development.js" integrity="sha384-hD6/rw4ppMLGNu3tX5cjIb+uRZ7UkRJ6BPkLpg4hAu/6onKUg4lLsHAs9EBPT82L" crossorigin="anonymous"></script>
<script src="https://unpkg.com/react-dom@18.3.1/umd/react-dom.development.js" integrity="sha384-u6aeetuaXnQ38mYT8rp6sbXaQe3NL9t+IBXmnYxwkUI2Hw4bsp2Wvmx4yRQF1uAm" crossorigin="anonymous"></script>
<script src="https://unpkg.com/@babel/standalone@7.29.0/babel.min.js" integrity="sha384-m08KidiNqLdpJqLq95G/LEi8Qvjl/xUYll3QILypMoQ65QorJ9Lvtp2RXYGBFj1y" crossorigin="anonymous"></script>
```

**Critical pitfalls:**

- **Style object collisions**: `const styles = { ... }` collides across multiple Babel script tags. Always use a component-prefixed name (`const terminalStyles = { ... }`) or inline styles.
- **Cross-script scope**: each `<script type="text/babel">` gets its own scope after transpilation. To share components, export to `window` at the end of the component file:
  ```js
  Object.assign(window, { Terminal, Line, Spacer });
  ```
- **No `type="module"`** on script imports — breaks Babel transpilation.

## Slide Decks

Build a deck as one self-scaling HTML file:
- Fixed canvas (default 1920×1080, 16:9) wrapped in a full-viewport stage.
- Stage scales the canvas via `transform: scale()` to fit, letterboxing on black.
- Prev / next controls live **outside** the scaled canvas so they stay usable on small screens.
- Persist current slide index in `localStorage`.

**Tag each slide with `[data-screen-label]`** — 1-indexed, padded:
```html
<section data-screen-label="01 Title">...</section>
<section data-screen-label="02 Agenda">...</section>
```
Humans don't speak 0-indexed. If labels are 0-indexed, every "slide 5" reference is off by one.

**Don't add a title screen to a prototype** unless explicitly asked. Center the prototype in the viewport instead. Speaker notes only when explicitly requested.

## Common Mistakes

| Mistake | Fix |
|---|---|
| Designing from scratch with no context | Stop. Ask for UI kit / codebase / screenshots first. |
| One variation, hoping it lands | Always 3+ across different axes. |
| Adding a "title" screen to every prototype | Don't. Center the prototype in the viewport. |
| Forking into `v1.html`, `v2.html`, `v3.html` | Single file with toggleable variants. |
| Inventing a color palette from scratch | Pull from brand/design system; `oklch()` from existing palette if needed. |
| Defaulting to Inter / Roboto for headlines | Pick something distinctive. |
| Generic gradients (purple-on-white) | No. |
| Skipping "show user early" | Show the assumptions/placeholder file BEFORE building the full thing. |
| Files exceeding 1000 lines | Split into smaller files and compose. |

## Verification

Use the `playwright-cli` skill to load and inspect the artifact before declaring done:
- No console errors on load.
- Visual rendering matches intent.
- For decks: keyboard navigation works; slide counter aligns with `data-screen-label` numbering.
- For prototypes: interactive states and route transitions behave as specified.

If you can't visually verify, say so explicitly rather than claiming success.
