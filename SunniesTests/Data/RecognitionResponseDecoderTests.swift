import Foundation
import Testing
@testable import Sunnies

struct RecognitionResponseDecoderTests {
    @Test(arguments: MalformedResponseFixtures.all)
    func malformedPayloadMapsToMalformedResponse(payload: Data) {
        #expect(throws: RecognitionError.malformedResponse) {
            try RecognitionResponseDecoder.decode(payload)
        }
    }

    @Test func validPayloadDecodes() throws {
        let response = RecognitionFixtures.similarStyles(UUID())
        let decoded = try RecognitionResponseDecoder.decode(JSONEncoder().encode(response))
        #expect(decoded == response)
    }
}
