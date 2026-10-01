import Testing
@testable import Sunnies

struct ConfidenceBadgeContentTests {
    // Confidence must never be conveyed by color alone.
    @Test func everyConfidenceHasDistinctLabelAndSymbol() {
        let contents = MatchConfidence.allCases.map(ConfidenceBadge.content(for:))
        #expect(Set(contents.map(\.label)).count == MatchConfidence.allCases.count)
        #expect(Set(contents.map(\.systemImage)).count == MatchConfidence.allCases.count)
    }

    @Test func usesDocumentedLabels() {
        #expect(ConfidenceBadge.content(for: .exact).label == "Exact match")
        #expect(ConfidenceBadge.content(for: .likely).label == "Likely match")
        #expect(ConfidenceBadge.content(for: .similar).label == "Similar styles")
        #expect(ConfidenceBadge.content(for: .styleOnly).label == "Style analysis")
    }
}
