import Foundation

/// Offline recognition service returning fixture responses for a fixed scenario.
/// Ignores the image bytes; the request only supplies the response's ID.
nonisolated struct MockEyewearRecognitionService: EyewearRecognitionService {
    let scenario: MockScenario
    let latency: Duration

    init(scenario: MockScenario, latency: Duration = .milliseconds(1200)) {
        self.scenario = scenario
        self.latency = latency
    }

    func analyze(request: RecognitionRequest) async throws -> RecognitionResponse {
        try await Task.sleep(for: latency)
        try Task.checkCancellation()

        switch scenario {
        case .serviceFailure:
            throw RecognitionError.serviceUnavailable
        case .timeout:
            throw RecognitionError.timeout
        case .malformedResponse:
            // Exercise the real decode path rather than throwing directly.
            return try RecognitionResponseDecoder.decode(MalformedResponseFixtures.truncatedJSON)
        case .exactMatch, .likelyMatch, .similarStyles, .styleOnly, .noResults:
            let fixture = try RecognitionFixtures.response(for: scenario, requestID: request.id)
            return ConfidencePolicy.validated(fixture)
        }
    }
}
