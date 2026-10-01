import Foundation

nonisolated struct FrameSearchQuery: Hashable, Sendable {
    var attributes: FrameAttributes?
    var category: FrameCategory?
    var priceRange: PriceRange?
    var prescriptionCompatibleOnly: Bool
    var limit: Int

    init(
        attributes: FrameAttributes? = nil,
        category: FrameCategory? = nil,
        priceRange: PriceRange? = nil,
        prescriptionCompatibleOnly: Bool = false,
        limit: Int = 20
    ) {
        self.attributes = attributes
        self.category = category
        self.priceRange = priceRange
        self.prescriptionCompatibleOnly = prescriptionCompatibleOnly
        self.limit = limit
    }
}

nonisolated enum PriceRange: String, Codable, CaseIterable, Sendable {
    case under100
    case from100To250
    case from250To500
    case luxury

    func contains(_ price: Decimal) -> Bool {
        switch self {
        case .under100: price < 100
        case .from100To250: price >= 100 && price < 250
        case .from250To500: price >= 250 && price < 500
        case .luxury: price >= 500
        }
    }
}
