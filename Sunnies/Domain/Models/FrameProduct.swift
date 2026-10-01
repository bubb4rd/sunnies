import Foundation

nonisolated struct FrameProduct: Identifiable, Codable, Hashable, Sendable {
    let id: String
    var brand: String
    var modelName: String?
    var modelNumber: String?
    var category: FrameCategory
    var imageURL: URL?
    var secondaryImageURL: URL?
    var retailerName: String?
    var retailerURL: URL?
    var price: Decimal?
    /// ISO 4217 code, e.g. "USD".
    var currency: String
    var originalPrice: Decimal?
    var availability: ProductAvailability
    var shape: FrameShape?
    var material: FrameMaterial?
    var frameColor: FrameColor?
    var lensColor: LensCharacteristic?
    var styleTags: [StyleDescriptor]
    /// `nil` means unknown, not incompatible.
    var prescriptionCompatible: Bool?
    var measurements: FrameMeasurements?
    var source: ProductSource
    var matchType: MatchType?
    /// Internal ranking signal in `0...1`. Never render this as a raw number.
    var matchScore: Double?

    init(
        id: String,
        brand: String,
        modelName: String? = nil,
        modelNumber: String? = nil,
        category: FrameCategory,
        imageURL: URL? = nil,
        secondaryImageURL: URL? = nil,
        retailerName: String? = nil,
        retailerURL: URL? = nil,
        price: Decimal? = nil,
        currency: String = "USD",
        originalPrice: Decimal? = nil,
        availability: ProductAvailability = .unknown,
        shape: FrameShape? = nil,
        material: FrameMaterial? = nil,
        frameColor: FrameColor? = nil,
        lensColor: LensCharacteristic? = nil,
        styleTags: [StyleDescriptor] = [],
        prescriptionCompatible: Bool? = nil,
        measurements: FrameMeasurements? = nil,
        source: ProductSource,
        matchType: MatchType? = nil,
        matchScore: Double? = nil
    ) {
        self.id = id
        self.brand = brand
        self.modelName = modelName
        self.modelNumber = modelNumber
        self.category = category
        self.imageURL = imageURL
        self.secondaryImageURL = secondaryImageURL
        self.retailerName = retailerName
        self.retailerURL = retailerURL
        self.price = price
        self.currency = currency
        self.originalPrice = originalPrice
        self.availability = availability
        self.shape = shape
        self.material = material
        self.frameColor = frameColor
        self.lensColor = lensColor
        self.styleTags = styleTags
        self.prescriptionCompatible = prescriptionCompatible
        self.measurements = measurements
        self.source = source
        self.matchType = matchType
        self.matchScore = matchScore
    }
}

nonisolated enum ProductAvailability: String, Codable, Sendable {
    case inStock
    case limited
    case outOfStock
    /// Default: live retailer availability is out of MVP scope.
    case unknown
}

nonisolated enum ProductSource: String, Codable, Sendable {
    /// Local fixture data for development. Brands are fictional.
    case developmentSeed
    case catalog
    case editorial
}

/// Fit measurements for future prescription shoppers. No UI in the MVP.
nonisolated struct FrameMeasurements: Codable, Hashable, Sendable {
    var lensWidthMM: Int?
    var bridgeWidthMM: Int?
    var templeLengthMM: Int?
}
