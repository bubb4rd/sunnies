# Sunnies — Agent Context

## Project Identity

**Sunnies** is a native iOS eyewear discovery application built in Swift and SwiftUI.

The product helps people identify, understand, save, and shop for glasses or sunglasses they see in everyday life: on TV, in movies, social-media posts, screenshots, photos, advertisements, or on another person.

The app should answer one of two user needs:

1. **“What glasses are these?”**
2. **“Find glasses with this same look.”**

Sunnies must be useful even when it cannot determine the exact brand and model. The product should return transparent confidence states, useful style analysis, and genuinely relevant purchasable alternatives.

---

# Core Product Promise

> See glasses you like. Find the exact pair when possible—or find the closest pair you can buy.

Sunnies is best understood as:

- Shazam for glasses
- Pinterest-style saving and discovery for eyewear
- Visual product search specialized for frames
- A trustworthy personal eyewear wishlist and inspiration library

Sunnies is **not** a generic shopping app, generic fashion search engine, virtual try-on app, or broad social media application.

---

# Product Principles

## 1. Useful even without an exact match

The app must not depend entirely on identifying an exact model.

If an image is blurry, partially obstructed, old, edited, low-quality, or contains discontinued frames, Sunnies should still provide useful output:

- Frame shape
- Material estimate
- Color
- Lens color or tint
- Style descriptors
- Similar purchasable products
- Price-range alternatives
- Brand-style alternatives where appropriate

A failed exact identification must not feel like a failed user experience.

---

## 2. Be honest about uncertainty

Sunnies must clearly distinguish between these confidence levels:

| Confidence State | Meaning | User-Facing Label Example |
|---|---|---|
| Exact | Strong evidence supports a specific brand/model | “Exact match” |
| Likely | The model is plausible but not fully verified | “Likely match” |
| Similar | The app found visually comparable products | “Similar styles” |
| Style-only | The app can identify the visual style but not the product | “Style analysis” |
| No result | The image is not usable or contains no recognizable eyewear | “We couldn’t identify these frames” |

Never label an uncertain AI output as verified.

Do not display a brand, model number, celebrity association, or TV-show attribution as factual unless it has trustworthy evidence.

---

## 3. Fashion editorial, not generic AI utility

The visual experience should feel:

- Premium
- Warm
- Editorial
- Image-led
- Minimal
- Modern
- Trustworthy
- Friendly
- Tasteful
- Calm

Avoid visual language that feels like:

- A generic AI chatbot
- A corporate dashboard
- A marketplace with cluttered affiliate cards
- A cheap shopping aggregator
- A dense admin tool
- A gimmicky “magic AI” experience

Use generous spacing, image-forward cards, refined typography, subtle motion, and clear confidence communication.

---

## 4. Protect image privacy

Users may upload personal screenshots, photos, social-media content, or images containing faces.

Treat all uploaded media as sensitive.

Rules:

- Do not permanently retain original uploaded images by default.
- Do not log image bytes, raw OCR output, URLs, search history, or personal image metadata.
- Strip unnecessary metadata before upload where possible.
- Upload only the minimum resolution and crop needed for analysis.
- Do not expose third-party provider API keys in the iOS application.
- Remote recognition calls must eventually go through a secure backend or server-side proxy.
- Clearly communicate when an image will be processed remotely.
- Provide meaningful error states for upload or analysis failure.
- Do not silently retry expensive image analysis requests without user intent.

---

# Target Users

## Primary User: Fashion-Curious Consumer

A person who notices frames they like and wants to find them.

Examples:

- “What sunglasses was that actor wearing?”
- “I saw these glasses on TikTok. Where can I buy them?”
- “I like this style but not the $500 price.”
- “I want something similar for prescription lenses.”
- “I keep taking screenshots of frames I like and losing them.”

Needs:

- Fast discovery
- Visual inspiration
- Affordable alternatives
- A personal saved collection
- Retail links
- Trustworthy results
- Low-friction photo upload

---

## Secondary User: Eyewear Enthusiast

A user who knows brands, styles, materials, shapes, and trends.

Examples:

- “Are these Jacques Marie Mage, Moscot, Ray-Ban, or similar?”
- “Find vintage-inspired amber acetate frames.”
- “Show me similar square tortoise shell frames.”
- “I need a smaller bridge fit.”
- “I want a collection of oval wire frames.”

Needs:

- More precise attributes
- Brand and model discovery
- Style tags
- Detailed frame metadata
- Vintage and independent-brand discovery
- Collection organization
- Better filters

---

## Future User: Prescription Shopper

A user who wants fashionable frames that will work for optical lenses.

Needs:

- Optical vs. sunglass filtering
- Prescription compatibility
- Lens width
- Bridge width
- Temple length
- Fit information
- High-prescription suitability
- Retailer/optician availability
- Price comparison

This is not required for the first MVP but should influence the data model.

---

# Main User Jobs

## Job 1: Identify frames

> When I see glasses I like in a photo, show, social post, or screenshot, I want to know what they are so I can find or buy them.

Inputs:

- Screenshot from TV or movie
- Photo from social media
- Picture of someone in public
- Fashion article image
- Product image
- Image from a creator or celebrity post

Desired outputs:

- Exact brand/model if supported
- Confidence level
- Evidence or reasoning
- Similar products
- Purchase links
- Save option

---

## Job 2: Find a similar style

> When I cannot find the exact pair, I want visually similar options so I can recreate the look.

Desired filters:

- Price range
- Sunglasses vs. optical
- Shape
- Color
- Material
- Brand
- Prescription compatibility
- Frame width or fit
- Lens tint
- New vs. used/vintage

---

## Job 3: Save eyewear inspiration

> When I see frames I like, I want to save them in one organized place so I can revisit them later.

Collection features:

- Save frame
- Save source image
- Add notes
- Create folders/boards
- Apply tags
- Mark status:
  - Want
  - Considering
  - Bought
  - Archived
- Link to retailer
- Share a saved item or board

---

## Job 4: Discover new styles

> When I do not have a specific image, I want to browse fashionable eyewear that fits my taste.

Future discovery examples:

- Trending sunglasses
- Classic optical frames
- 90s oval frames
- Chunky acetate frames
- Thin metal frames
- Tortoise shell styles
- Best frames under $150
- Prescription-friendly sunglasses
- Vintage-inspired styles
- Celebrity and TV-inspired collections only when sourced responsibly

---

# MVP Scope

## MVP Goal

Validate whether users find Sunnies valuable when it helps them go from an image to a relevant, attractive, saveable set of eyewear results.

The MVP does **not** need full exact-product recognition.

The MVP must support this core vertical slice:

```text
Select Image
→ Crop Eyewear Area
→ Choose Search Intent
→ Analyze Image
→ Receive Style Analysis and Mocked/Real Similar Results
→ View Frame Detail
→ Save Frame to Collection
```

---

## MVP Features

### 1. App Foundation

- Native SwiftUI application
- iOS 17+ target unless a requirement demands a lower target
- Modern Swift concurrency
- Clean feature-oriented project structure
- Strong local development mock environment
- Test targets enabled from the beginning
- Light and dark appearance support where practical
- Accessibility support from the beginning

---

### 2. Onboarding

The initial onboarding experience should explain the primary value quickly.

Key message:

> Upload a photo or screenshot of glasses you like. Sunnies will help you identify them or find similar styles you can shop.

Onboarding should collect only lightweight preferences, if needed:

- Interested in:
  - Sunglasses
  - Prescription frames
  - Both
- Price preference:
  - Under $100
  - $100–$250
  - $250–$500
  - Luxury
  - No preference
- Style interest:
  - Classic
  - Trendy
  - Vintage
  - Minimal
  - Bold
  - No preference

Do not require account creation before the user experiences value.

Authentication is not required for the initial MVP.

---

### 3. Home / Discover Screen

The Home screen should have one dominant action:

> Find these glasses

Primary actions:

- Choose Photo
- Take Photo
- Paste Image Link later, not required in the earliest build
- Browse Discover content
- View recently saved frames

Potential sections:

- Find glasses from an image
- Recent finds
- Saved collection preview
- Trending shapes
- Curated styles
- Browse by shape
- Browse by price

Avoid making the Home screen dense or marketplace-heavy.

---

### 4. Image Selection

Users must be able to select an image using:

- PhotosPicker
- Camera capture later if necessary
- Shared image extension later
- Paste image URL later

Initial MVP priority:

```text
PhotosPicker
→ Preview selected photo
→ Replace photo
→ Remove photo
→ Continue to crop
```

Image selection requirements:

- Handle picker cancellation
- Handle image loading failure
- Show a recoverable error state
- Do not upload or persist the photo at this stage
- Avoid blocking the main thread while loading large images
- Normalize image orientation before processing
- Downscale oversized images safely

---

### 5. Image Crop

The user should crop the image around the eyewear region.

The crop screen should:

- Display the selected image
- Support pan and zoom
- Allow crop adjustment
- Provide a framing overlay
- Show helpful instruction:
  - “Center the glasses for better matches.”
- Allow skip/crop confirmation depending on implementation
- Produce a normalized cropped image for local/remote analysis

The crop state must not live permanently inside a SwiftUI `View`.

Crop processing should be isolated behind testable logic.

---

### 6. Search Intent

After selecting/cropping the image, the user should choose intent.

Initial options:

| Intent | Meaning |
|---|---|
| Find exact | Try to identify the brand/model if possible |
| Find similar | Focus on visually comparable alternatives |
| Analyze style | Describe the eyewear style and attributes |

The initial MVP can prioritize “Find similar” while still rendering mock confidence states for other intents.

---

### 7. Analysis Experience

The analysis screen should feel calm and intentional.

Potential analysis steps:

```text
Reading visible details
→ Identifying frame shape
→ Matching colors and materials
→ Finding similar styles
```

Do not claim that these are literal backend operations unless they are actually being performed.

The analysis process should support:

- Loading state
- Progress presentation
- Cancellation if feasible
- Retry after failure
- Offline/network failure messaging
- Low-confidence outcome
- No-result outcome

The MVP should use deterministic mock responses for development and UI validation.

---

### 8. Recognition Results

Results must communicate uncertainty accurately.

Potential result sections:

- Search image preview
- Result confidence badge
- Best match, if confidence supports it
- Style analysis
- Similar products
- Price alternatives
- Save action
- Search again action

Possible labels:

```text
Exact match
Likely match
Similar styles
Style analysis
Could not identify exact frames
```

Results must never display fictional certainty.

---

### 9. Style Attributes

The analysis response may include:

```text
Frame shape:
- Round
- Oval
- Square
- Rectangle
- Cat-eye
- Aviator
- Browline
- Wraparound
- Rimless
- Geometric

Frame material:
- Acetate
- Metal
- Mixed material
- Rimless
- Plastic
- Unknown

Frame color:
- Black
- Tortoise
- Brown
- Clear
- Gold
- Silver
- Gunmetal
- Amber
- Transparent
- Multi-color

Lens characteristics:
- Clear lenses
- Grey lenses
- Brown lenses
- Green lenses
- Gradient lenses
- Mirrored lenses
- Tinted lenses

Style descriptors:
- Chunky
- Slim
- Oversized
- Narrow
- Angular
- Retro
- Minimal
- Vintage-inspired
- Sporty
- Classic
- Bold
- Understated
```

Style attributes are probabilistic and should be treated as suggestions, not facts.

---

### 10. Product Results

Each product result should support:

```text
FrameProduct
- id
- brand
- modelName
- modelNumber
- category
- imageURL
- secondaryImageURL
- retailerName
- retailerURL
- price
- currency
- originalPrice
- availability
- shape
- material
- frameColor
- lensColor
- styleTags
- prescriptionCompatible
- source
- matchType
- matchScore
```

`matchType` should support:

```swift
enum MatchType: String, Codable, Sendable {
    case exact
    case likely
    case similar
    case editorial
}
```

`matchScore` should not be directly shown as a raw number unless product design explicitly approves it.

User-facing language should be qualitative:

```text
Best match
Very similar
Similar shape and color
Same style, lower price
```

---

### 11. Frame Detail

A frame detail screen should include:

- Primary image
- Brand
- Model name
- Category
- Price
- Retailer
- Style details
- Match explanation
- Confidence state
- Save button
- Share button later
- Similar alternatives
- Purchase CTA

Example details:

```text
Moscot
Lemtosh
Tortoiseshell Acetate
$360
Likely match

Why this result:
Similar rounded acetate silhouette, keyhole bridge, warm tortoise finish,
and visible frame proportions.
```

Do not generate a fabricated explanation. Match reasoning should come from real structured data or valid analysis output.

---

### 12. Saved Collection

The initial saved collection should persist locally.

Users should be able to:

- Save a product
- Remove a product
- View saved products
- Add a note
- Mark status
- View product details
- Persist saved data across app relaunch

Initial statuses:

```swift
enum SavedFrameStatus: String, Codable, CaseIterable, Sendable {
    case want
    case considering
    case bought
    case archived
}
```

Future functionality:

- Boards
- Shared collections
- Price-drop alerts
- Stock alerts
- Cross-device sync
- User accounts
- Collaborative styling boards

---

# Explicit Non-Goals

Do not build these in the first MVP unless explicitly approved.

- Virtual try-on
- Face-shape recommendations
- AR fitting
- Real-time camera recognition
- User accounts
- Cloud sync
- Social feeds
- Messaging
- Creator profiles
- Complex affiliate networks
- Subscription billing
- Paywall
- Full product marketplace
- Checkout inside the app
- Price history
- Price-drop alerts
- Retail inventory synchronization
- Live retailer availability
- Advanced recommendation engine
- Full web scraping system
- Universal exact eyewear identification
- Celebrity or TV outfit database
- AI chatbot
- Broad fashion search beyond eyewear
- Android support
- Web application
- Admin dashboard

If an agent identifies one of these as necessary, it must stop and explain why before adding it.

---

# Technology Direction

## Client

- Swift
- SwiftUI
- iOS 17+
- Swift Concurrency
- `async` / `await`
- `@MainActor` for UI state where appropriate
- `Sendable` domain types where appropriate
- `PhotosPicker`
- Apple Vision for local preprocessing when practical
- URLSession or a defined network client
- Swift Testing or XCTest depending on target/toolchain requirements

---

## Architecture Direction

Use a feature-oriented, testable architecture.

Preferred layers:

```text
Presentation
- SwiftUI views
- Feature-scoped view models
- Reusable UI components
- Design system

Domain
- Models
- Business rules
- Confidence policy
- Protocols
- Use-case-level logic where needed

Data
- Mock services
- Remote service implementations
- Local persistence repositories
- DTO mapping
- API client

Infrastructure
- Image normalization
- Crop processing
- Secure configuration
- Logging
- Analytics abstraction
```

Do not put:

- Network calls directly in SwiftUI views
- Persistent storage logic directly in views
- Image processing directly in views
- API keys in the application
- Large amounts of business logic in one massive view model
- Third-party implementation details into domain models

---

# Service Boundaries

The UI must not depend directly on a specific visual-search provider.

Use protocol boundaries.

```swift
protocol EyewearRecognitionService: Sendable {
    func analyze(
        request: RecognitionRequest
    ) async throws -> RecognitionResponse
}

protocol EyewearCatalogService: Sendable {
    func search(
        query: FrameSearchQuery
    ) async throws -> [FrameProduct]
}

protocol SavedFramesRepository: Sendable {
    func fetchSavedFrames() async throws -> [SavedFrame]
    func save(_ frame: SavedFrame) async throws
    func update(_ frame: SavedFrame) async throws
    func delete(id: SavedFrame.ID) async throws
}
```

Initial implementations:

```text
MockEyewearRecognitionService
MockEyewearCatalogService
LocalSavedFramesRepository
```

Future implementations:

```text
RemoteEyewearRecognitionService
RemoteEyewearCatalogService
RemoteSavedFramesRepository
```

The full vertical slice must work using mock implementations without real APIs, external keys, paid vendors, or network connectivity.

---

# Recognition Response Requirements

A recognition result should support exact, likely, similar-only, style-only, and failure states.

Example domain direction:

```swift
enum MatchConfidence: String, Codable, Sendable {
    case exact
    case likely
    case similar
    case styleOnly
    case insufficientEvidence
}

struct RecognitionResponse: Codable, Sendable {
    let requestID: UUID
    let confidence: MatchConfidence
    let primaryCandidate: FrameProduct?
    let styleAttributes: FrameAttributes?
    let similarProducts: [FrameProduct]
    let evidence: [RecognitionEvidence]
    let userMessage: String
}
```

Example evidence types:

```swift
enum RecognitionEvidenceType: String, Codable, Sendable {
    case visualSimilarity
    case visibleBrandText
    case visibleModelText
    case catalogImageMatch
    case webReference
    case userProvidedContext
}
```

Evidence should eventually allow the interface to explain why a match is shown.

Do not show opaque, unsupported reasoning.

---

# Failure States

Every major feature must define behavior for failure.

## Image Input Failures

- User cancels image picker
- Selected image cannot be loaded
- Image is too large
- Image is invalid
- No glasses are visible
- Image lacks sufficient detail

## Crop Failures

- Crop has no usable pixels
- Crop is too small
- Crop cannot be processed
- Crop output cannot be normalized

## Recognition Failures

- No internet connection
- Backend timeout
- Provider unavailable
- Invalid API response
- Rate limited
- Low confidence
- No exact match
- No similar product matches
- Service unavailable

## Persistence Failures

- Local storage unavailable
- Save fails
- Delete fails
- Migration issue
- Corrupt saved data

Never use a silent failure.

Every failure should include:

- A human-readable explanation
- A recovery action where possible
- A retry path when appropriate
- A way to return safely to the prior screen

---

# Design System

The app needs a small but deliberate design system before feature work expands.

## Visual Direction

Sunnies should feel like:

```text
Editorial eyewear magazine
+
premium fashion storefront
+
calm personal collection
+
trustworthy iOS utility
```

Not like:

```text
generic AI app
+
trading dashboard
+
e-commerce template
+
cheap deal aggregator
```

## Design Tokens Needed

```text
Colors
- Background primary
- Background secondary
- Surface
- Surface elevated
- Text primary
- Text secondary
- Text tertiary
- Accent
- Success
- Warning
- Error
- Exact confidence
- Likely confidence
- Similar confidence

Typography
- Large display
- Screen title
- Section title
- Body
- Caption
- Product metadata
- Badge text

Spacing
- XS
- S
- M
- L
- XL
- XXL

Corner Radius
- Small
- Medium
- Large
- Full pill

Shadows
- Card shadow
- Elevated shadow
- Image overlay shadow

Components
- Primary button
- Secondary button
- Tertiary/text button
- Search intent selector
- Confidence badge
- Filter chip
- Frame product card
- Image upload card
- Empty state
- Error state
- Loading state
- Saved indicator
- Section header
```

## Accessibility Requirements

- Support Dynamic Type
- Use semantic colors
- Do not rely on color alone for confidence state
- Provide VoiceOver labels for every interactive control
- Use adequate tap targets
- Maintain readable contrast
- Respect reduced motion preferences where animation is used
- Ensure error messages are announced accessibly
- Ensure images have meaningful accessibility labels when possible

---

# Data and Privacy Requirements

## Image Lifecycle

The expected lifecycle for an MVP image:

```text
User selects image
→ App normalizes/downscales locally
→ User crops eyewear region
→ App shows what will be analyzed
→ User confirms analysis
→ Cropped/processed image is sent to mock service or future backend
→ Result is returned
→ Image is discarded unless user explicitly saves it with a collection item
```

## Logging Rules

Never log:

- Raw image data
- Base64 image strings
- OCR output containing sensitive information
- Image URLs from private sources
- Authentication tokens
- Full user search history
- User notes without explicit debugging consent
- Provider credentials
- Personally identifying metadata

Logging may include safe event-level metadata such as:

```text
analysis_started
analysis_completed
analysis_failed
analysis_confidence_exact
analysis_confidence_similar
saved_frame_created
saved_frame_removed
```

Analytics must remain abstracted and optional.

---

# Agent Working Rules

## Before Editing Code

Before editing files, the agent must:

1. Read relevant project documentation.
2. Read all applicable `.cursor/rules` files.
3. Inspect existing related code.
4. State the task scope.
5. State acceptance criteria.
6. Identify affected files.
7. Identify test strategy.
8. Identify risks or decisions that need approval.

For multi-file features, produce an implementation plan before coding.

Do not begin broad implementation based on vague user requests.

---

## During Implementation

The agent must:

- Make the smallest change that satisfies the approved scope.
- Preserve existing architectural boundaries.
- Avoid unrelated refactors.
- Avoid deleting working code unless necessary.
- Prefer explicit and readable code over clever abstractions.
- Reuse design-system components.
- Reuse existing models and service protocols where appropriate.
- Add dependencies only when explicitly justified.
- Avoid force unwraps unless failure is provably impossible.
- Avoid `try!`.
- Avoid unbounded `Task` creation.
- Avoid leaking `self` through long-lived asynchronous work.
- Keep image operations off the main thread when practical.
- Keep UI state updates on the main actor.
- Treat all external/AI/API responses as untrusted input.
- Validate empty, malformed, and partial responses.

---

## After Implementation

After each task, the agent must report:

```text
1. Summary of work completed
2. Files added
3. Files modified
4. Files deleted
5. Architecture decisions made
6. Tests added or updated
7. Tests run and results
8. Build command and result
9. Manual verification steps
10. Known limitations
11. Deferred work
12. Risks or follow-up recommendations
```

The agent must not claim the feature is complete unless it has successfully built and run relevant tests.

---

# Quality Gates

A feature is not done merely because it compiles.

A feature is complete only when:

- It satisfies acceptance criteria.
- It builds successfully.
- Relevant tests pass.
- Error states exist.
- Loading states exist.
- Empty states exist where relevant.
- Accessibility has been considered.
- Privacy implications have been considered.
- It fits the design system.
- It does not introduce obvious architecture drift.
- It has been manually tested in the iOS simulator.
- It has no known critical regressions.

---

# Testing Expectations

## Unit Tests

Unit tests should cover:

- Confidence state mapping
- Recognition response mapping
- Frame filtering
- Search intent behavior
- Image validation logic
- Crop output validation
- View model state transitions
- Error mapping
- Local persistence behavior
- Saved frame status changes
- Product result sorting
- Low-confidence result rendering rules

## UI Tests

UI tests should eventually cover:

```text
Launch app
→ Select fixture/mock image
→ Continue to crop
→ Confirm crop
→ View analysis state
→ Receive mocked result
→ Open product detail
→ Save product
→ Open saved collection
→ Confirm saved item exists
```

## Manual Tests

Every major image workflow should be manually tested with:

- Clear product image
- Blurry screenshot
- Large photo
- Non-eyewear photo
- Image with multiple people
- Image with small glasses
- Image with no visible glasses
- Light mode
- Dark mode if supported
- Large Dynamic Type
- VoiceOver enabled
- Offline mode
- Provider failure fixture
- Low-confidence fixture
- No-results fixture

---

# Mock Data Requirements

Mock data must be realistic enough to test the product.

The mock service should include fixtures for:

```text
1. Exact Match
- Strong product candidate
- Evidence included
- Exact confidence state

2. Likely Match
- Plausible candidate
- Clear uncertainty label
- Similar alternatives

3. Similar Styles
- No exact candidate
- Style attributes
- Several product alternatives

4. Style-Only Result
- No purchase-ready exact candidate
- Frame shape/material/color analysis
- User-facing explanation

5. No Results
- Image does not show usable glasses
- Helpful retry guidance

6. Service Failure
- Temporary service error
- Retry action

7. Timeout
- Network/provider timeout
- Recovery path

8. Malformed Response
- Safe handling
- Human-readable fallback error
```

Mock fixtures should not use fabricated real-world brand/model claims unless they are clearly marked as development seed data.

---

# Build Order

## Milestone 0: Foundation

Deliverables:

- Xcode project
- SwiftUI app shell
- Design tokens
- Basic navigation
- Test target
- Project docs
- Cursor rules
- Mock service interfaces
- Fixture data

## Milestone 1: Image Input

Deliverables:

- PhotosPicker integration
- Image preview
- Replace image action
- Remove image action
- Loading and failure states
- Image normalization
- Unit tests for image-loading logic where possible

## Milestone 2: Crop

Deliverables:

- Crop interface
- Crop state model
- Pan/zoom support
- Crop confirmation
- Image crop output
- Crop validation
- Error state
- Tests for crop calculations/validation

## Milestone 3: Mock Analysis

Deliverables:

- Search intent selection
- Analysis state
- Mock recognition response
- Exact/likely/similar/style-only/no-result states
- Error/retry handling
- Unit tests for state transitions

## Milestone 4: Results

Deliverables:

- Results screen
- Style attributes
- Product cards
- Confidence badges
- Product detail navigation
- Match explanation
- Similar products section

## Milestone 5: Saved Collection

Deliverables:

- Local persistence
- Save frame
- Remove frame
- Saved collection screen
- Status update
- Relaunch persistence test

## Milestone 6: Quality Pass

Deliverables:

- Accessibility improvements
- Dynamic Type validation
- UI tests for core flow
- Image performance validation
- Empty/error/loading state review
- Privacy audit
- Design polish

## Milestone 7: Real Backend Spike

Deliverables:

- Backend API contract
- Secure provider proxy
- Image upload lifecycle
- Provider adapter
- Remote recognition proof of concept
- Privacy review
- Failure mapping
- Observability without sensitive logging

Do not start Milestone 7 until Milestones 0–6 form a polished, demoable core loop.

---

# Definition of Done: MVP Vertical Slice

The first complete Sunnies vertical slice is complete when a user can:

1. Launch the app.
2. Understand the core value proposition.
3. Select a photo from their iPhone library.
4. Preview, replace, or remove the selected image.
5. Crop around the eyewear.
6. Choose “Find Similar.”
7. See an intentional analysis/loading state.
8. Receive a mocked style analysis and relevant mock products.
9. Clearly understand whether the result is exact, likely, similar, or style-only.
10. Open a frame detail page.
11. Save a product to a local collection.
12. Relaunch the app and see the saved product.
13. Encounter graceful error/no-result states without a crash.
14. Use the core experience with reasonable Dynamic Type and VoiceOver support.
15. Complete the flow without needing authentication, real APIs, or payment.

---

# Decision Log Format

Document major decisions in `docs/decision-log.md`.

Use this format:

```md
## ADR-001: [Decision Title]

Date: YYYY-MM-DD
Status: Proposed | Accepted | Superseded | Rejected

### Context

What problem or constraint prompted the decision?

### Decision

What was chosen?

### Reasoning

Why was this option chosen over alternatives?

### Consequences

What does this enable, constrain, or defer?

### Follow-Up

What future decision or validation is required?
```

Example:

```md
## ADR-001: Use mock recognition services for MVP UI validation

Date: 2026-09-30
Status: Accepted

### Context

Exact eyewear recognition requires vendor research, backend services,
image privacy decisions, catalog sourcing, and potentially ongoing API cost.

### Decision

The first vertical slice will use deterministic local mock recognition and catalog services.

### Reasoning

The product must first validate whether users understand and value the
capture-to-results-to-save workflow before committing to external provider infrastructure.

### Consequences

- UI must depend on protocols rather than provider-specific APIs.
- Mock data must include every major confidence and failure state.
- Real backend integration is deferred until the MVP loop is polished.

### Follow-Up

Run a backend recognition proof of concept after user testing validates the MVP flow.
```

---

# Preferred Agent Response Format

When asked to plan a feature, respond with:

```md
## Goal

[What user outcome is being implemented]

## Scope

[Included work]

## Non-Goals

[Explicitly excluded work]

## Files

[Files to create or change]

## Implementation Plan

1. [Step]
2. [Step]
3. [Step]

## Acceptance Criteria

- [Criterion]
- [Criterion]

## Test Plan

- [Test]
- [Test]

## Risks / Decisions Needed

- [Risk or question]
```

When asked to implement a feature, respond with:

```md
## Summary

[What was implemented]

## Changed Files

- `path/to/file.swift` — [description]

## Verification

- Build: [result]
- Tests: [result]
- Manual testing: [steps performed]

## Limitations

- [Known limitation]

## Deferred

- [Deferred work]
```

---

# Final Agent Instruction

Prioritize building a polished, trustworthy, testable **image-to-eyewear-discovery loop**.

Do not optimize for feature count.

Do not invent certainty.

Do not add broad infrastructure before the user-facing experience is validated.

Do not allow incomplete loading, error, empty, privacy, or accessibility states to become permanent debt.

When uncertain, choose the smallest implementation that:

1. Improves the primary user loop.
2. Preserves the architecture.
3. Can be tested.
4. Can be removed or replaced later.
5. Does not mislead the user.
