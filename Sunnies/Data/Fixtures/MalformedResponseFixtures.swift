import Foundation

/// Synthetic invalid payloads for exercising the decode path.
nonisolated enum MalformedResponseFixtures {
    static let truncatedJSON = Data(#"{"requestID":"8F1C6E2A-1B7D-4C55-9E0A-3D2B1F4A6C7E","confidence":"sim"#.utf8)

    static let missingConfidence = Data(#"""
    {"requestID":"8F1C6E2A-1B7D-4C55-9E0A-3D2B1F4A6C7E","similarProducts":[],"evidence":[]}
    """#.utf8)

    static let unknownConfidence = Data(#"""
    {"requestID":"8F1C6E2A-1B7D-4C55-9E0A-3D2B1F4A6C7E","confidence":"certain","similarProducts":[],"evidence":[]}
    """#.utf8)

    static let empty = Data()

    static let all: [Data] = [truncatedJSON, missingConfidence, unknownConfidence, empty]
}
