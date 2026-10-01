import Foundation

/// Offline catalog search over the development seed products.
nonisolated struct MockEyewearCatalogService: EyewearCatalogService {
    let products: [FrameProduct]

    init(products: [FrameProduct] = SeedProducts.all) {
        self.products = products
    }

    func search(query: FrameSearchQuery) async throws -> [FrameProduct] {
        let filtered = products.filter { matches($0, query) }
        let sorted = filtered.sorted { lhs, rhs in
            let left = lhs.matchScore ?? 0
            let right = rhs.matchScore ?? 0
            return left == right ? lhs.id < rhs.id : left > right
        }
        return Array(sorted.prefix(max(query.limit, 0)))
    }

    private func matches(_ product: FrameProduct, _ query: FrameSearchQuery) -> Bool {
        if let category = query.category, product.category != category { return false }
        if let shape = query.attributes?.shape, product.shape != shape { return false }
        if let material = query.attributes?.material, product.material != material { return false }
        if let color = query.attributes?.frameColor, product.frameColor != color { return false }
        if query.prescriptionCompatibleOnly, product.prescriptionCompatible != true { return false }
        if let range = query.priceRange {
            guard let price = product.price, range.contains(price) else { return false }
        }
        return true
    }
}
