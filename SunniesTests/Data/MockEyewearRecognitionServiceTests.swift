import Foundation
import Testing
@testable import Sunnies

struct MockEyewearRecognitionServiceTests {
    @Test(arguments: [
        (MockScenario.exactMatch, MatchConfidence.exact),
        (.likelyMatch, .likely),
        (.similarStyles, .similar),
        (.styleOnly, .styleOnly),
        (.noResults, .insufficientEvidence),
    ])
    func successfulScenarioReturnsExpectedConfidence(scenario: MockScenario, expected: MatchConfidence) async throws {
        let service = MockEyewearRecognitionService(scenario: scenario, latency: .zero)
        let response = try await service.analyze(request: .fixture())
        #expect(response.confidence == expected)
    }

    @Test(arguments: [
        (MockScenario.serviceFailure, RecognitionError.serviceUnavailable),
        (.timeout, .timeout),
        (.malformedResponse, .malformedResponse),
    ])
    func failingScenarioThrowsExpectedError(scenario: MockScenario, expected: RecognitionError) async {
        let service = MockEyewearRecognitionService(scenario: scenario, latency: .zero)
        await #expect(throws: expected) {
            try await service.analyze(request: .fixture())
        }
    }

    @Test func coversEveryScenario() {
        // Guards against adding a scenario without updating the tables above.
        #expect(MockScenario.allCases.count == 8)
    }

    @Test func responseEchoesRequestID() async throws {
        let id = UUID()
        let service = MockEyewearRecognitionService(scenario: .similarStyles, latency: .zero)
        let response = try await service.analyze(request: .fixture(id: id))
        #expect(response.requestID == id)
    }

    @Test func cancellationStopsAnalysis() async {
        let service = MockEyewearRecognitionService(scenario: .similarStyles, latency: .seconds(30))
        let task = Task { try await service.analyze(request: .fixture()) }
        task.cancel()
        await #expect(throws: CancellationError.self) {
            try await task.value
        }
    }
}
