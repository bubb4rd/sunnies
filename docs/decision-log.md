# Decision Log

## ADR-001: Use mock recognition services for MVP UI validation

Date: 2026-09-30
Status: Accepted

### Context

Exact eyewear recognition requires vendor research, backend services, image privacy decisions, catalog sourcing, and potentially ongoing API cost.

### Decision

The first vertical slice uses deterministic local mock recognition and catalog services (`MockEyewearRecognitionService`, `MockEyewearCatalogService`) covering all eight fixture scenarios.

### Reasoning

The product must first validate whether users understand and value the capture → results → save workflow before committing to provider infrastructure.

### Consequences

- UI depends on protocols, never provider APIs.
- Mock data covers every confidence and failure state.
- Real backend integration is deferred until M0–M6 form a polished loop.

### Follow-Up

Backend recognition proof of concept (M7) after user testing validates the flow.

---

## ADR-002: Keep the Xcode-native project with synchronized folders

Date: 2026-09-30
Status: Accepted

### Context

The project was created from the Xcode 26 template using `PBXFileSystemSynchronizedRootGroup`, so files added on disk join their target automatically.

### Decision

No project generator (XcodeGen/Tuist). The scheme is shared in `xcshareddata`.

### Reasoning

Synchronized folders remove the main pain a generator solves, and the project rules discourage unjustified dependencies.

### Consequences

- Any file under `Sunnies/` is bundled — keep docs and non-app files outside it.
- Build settings are edited in Xcode (or carefully in `project.pbxproj`).

### Follow-Up

Revisit if app extensions or multiple modules are added.

---

## ADR-003: Single app target with layered folders

Date: 2026-09-30
Status: Accepted

### Context

The architecture calls for Presentation / Domain / Data / Infrastructure separation.

### Decision

Layers are folders inside one target, not SPM modules.

### Reasoning

Lowest overhead for an MVP; boundaries are enforced by review and `.cursor/rules`.

### Consequences

The compiler doesn't enforce layer boundaries. Domain files must not import SwiftUI/UIKit.

### Follow-Up

Extract modules at M7 or the first app extension if boundaries erode.

---

## ADR-004: Dependency injection via `AppEnvironment`

Date: 2026-09-30
Status: Accepted

### Context

Mock and future remote services must be swappable without touching features.

### Decision

`AppEnvironment` holds the three service protocols and is injected with `EnvironmentValues.appEnvironment`. Feature view models receive services through `init`. The mock scenario is selected with `-SunniesMockScenario <name>` in DEBUG builds.

### Reasoning

Plain SwiftUI, no DI framework, and view models stay testable without SwiftUI.

### Consequences

Swapping to remote implementations only changes `App/`.

### Follow-Up

Add `.remote(...)` in M7.

---

## ADR-005: Swift 6, MainActor default isolation, `nonisolated` domain

Date: 2026-09-30
Status: Accepted

### Context

The template enabled MainActor default isolation; the codebase is empty, so strict concurrency is cheapest to adopt now.

### Decision

Swift 6 language mode on all targets. App and unit-test targets default to MainActor. Domain and Data types, protocols, and mocks are explicitly `nonisolated`; the repository is an `actor`.

### Reasoning

UI code is safe by default; domain values stay usable from actors (persistence, networking).

### Consequences

New domain/data types must be marked `nonisolated`.

### Follow-Up

None.

---

## ADR-006: Swift Testing for unit tests, XCTest for UI tests

Date: 2026-09-30
Status: Accepted

### Decision

Unit tests use Swift Testing (parameterized tests cover the mock scenarios). UI tests use XCTest/XCUITest, which Swift Testing does not replace.

---

## ADR-007: Client-side confidence policy

Date: 2026-09-30
Status: Accepted

### Context

The product must never display fictional certainty, and remote/AI output is untrusted.

### Decision

`ConfidencePolicy.validated` downgrades (never rejects) any claim the response can't support: `exact` needs a candidate plus brand/model-text or catalog-image evidence; a candidate below `likely` becomes an alternative; alternatives can't claim exact/likely. User-facing copy is written by the client from `confidence`; `userMessage` is optional and not shown verbatim.

### Consequences

Every response path, including fixtures, passes through the policy. Fixtures are tested to pass it unchanged.

---

## ADR-008: Development seed data uses fictional brands

Date: 2026-09-30
Status: Accepted

### Decision

All seed products use invented brands/models and `source = .developmentSeed`, avoiding implied real brand or model claims.

---

## ADR-009: Saved collection persists as a JSON file

Date: 2026-09-30
Status: Accepted

### Context

M5 needs local persistence across relaunch. Options: SwiftData or a Codable JSON file.

### Decision

A Codable JSON file in Application Support behind an `actor` implementing `SavedFramesRepository`. SwiftData template code was removed.

### Reasoning

Small dataset, fully unit-testable, fits `Sendable` value types, no model/record duplication.

### Consequences

Migrations are manual (versioned file format). `InMemorySavedFramesRepository` is used until M5.

### Follow-Up

Decide in M5 whether source images are saved with a frame.

---

## ADR-010: iPhone-only, portrait, iOS 17

Date: 2026-09-30
Status: Accepted

### Decision

Deployment target iOS 17.0, `TARGETED_DEVICE_FAMILY = 1`, portrait only. Bundle ID `com.bubb4rd.sunnies`.

### Follow-Up

Revisit iPad and landscape after the MVP.

---

## ADR-011: Normalize picked images with ImageIO, in memory only

Date: 2026-09-30
Status: Accepted

### Context

M1 needs orientation fixes, safe downscaling, and metadata removal without blocking the UI or retaining photos.

### Decision

`ImageNormalizer` uses ImageIO thumbnailing (`CreateThumbnailWithTransform`) off the main actor via `@concurrent`. Longest side capped at 2048px, shortest side must be ≥100px, input ≤60MB. Output is a `CGImage` (no EXIF/GPS) held in memory; nothing is persisted or uploaded.

### Reasoning

Thumbnailing avoids decoding full-resolution originals; a `CGImage` carries no metadata, so stripping is implicit.

### Consequences

- Loads run in `.task(id:)`, so a new selection or removal cancels the previous load.
- UI tests use the DEBUG-only `-SunniesSampleImage` argument because PhotosPicker can't be driven by XCUITest.

### Follow-Up

M2 crops the `CGImage`; JPEG encoding happens only when a request is built.
