import Foundation

/// Development seed catalog. Every brand and model here is fictional and
/// marked `.developmentSeed`; none of it describes a real product.
nonisolated enum SeedProducts {
    static let haldenArlo = FrameProduct(
        id: "seed-halden-arlo",
        brand: "Halden Optical",
        modelName: "Arlo",
        modelNumber: "HO-114",
        category: .optical,
        retailerName: "Sample Retailer",
        price: 320,
        shape: .round,
        material: .acetate,
        frameColor: .tortoise,
        lensColor: .clear,
        styleTags: [.classic, .vintageInspired],
        prescriptionCompatible: true,
        measurements: FrameMeasurements(lensWidthMM: 46, bridgeWidthMM: 24, templeLengthMM: 145),
        source: .developmentSeed,
        matchScore: 0.94
    )

    static let northlightWren = FrameProduct(
        id: "seed-northlight-wren",
        brand: "Northlight Eyewear",
        modelName: "Wren",
        category: .optical,
        retailerName: "Sample Retailer",
        price: 145,
        shape: .round,
        material: .acetate,
        frameColor: .tortoise,
        lensColor: .clear,
        styleTags: [.classic],
        prescriptionCompatible: true,
        source: .developmentSeed,
        matchScore: 0.88
    )

    static let verraPalma = FrameProduct(
        id: "seed-verra-palma",
        brand: "Verra Studio",
        modelName: "Palma",
        category: .optical,
        retailerName: "Sample Retailer",
        price: 89,
        shape: .oval,
        material: .acetate,
        frameColor: .amber,
        lensColor: .clear,
        styleTags: [.retro, .understated],
        prescriptionCompatible: true,
        source: .developmentSeed,
        matchScore: 0.81
    )

    static let marisolPikeDune = FrameProduct(
        id: "seed-marisol-pike-dune",
        brand: "Marisol & Pike",
        modelName: "Dune",
        category: .sunglasses,
        retailerName: "Sample Retailer",
        price: 210,
        originalPrice: 260,
        shape: .square,
        material: .acetate,
        frameColor: .black,
        lensColor: .grey,
        styleTags: [.chunky, .bold],
        prescriptionCompatible: false,
        source: .developmentSeed,
        matchScore: 0.9
    )

    static let okonFlint = FrameProduct(
        id: "seed-okon-flint",
        brand: "Okon",
        modelName: "Flint",
        category: .sunglasses,
        retailerName: "Sample Retailer",
        price: 68,
        shape: .square,
        material: .plastic,
        frameColor: .black,
        lensColor: .grey,
        styleTags: [.chunky],
        source: .developmentSeed,
        matchScore: 0.76
    )

    static let bellweatherSkyline = FrameProduct(
        id: "seed-bellweather-skyline",
        brand: "Bellweather",
        modelName: "Skyline",
        category: .sunglasses,
        retailerName: "Sample Retailer",
        price: 540,
        shape: .aviator,
        material: .metal,
        frameColor: .gold,
        lensColor: .gradient,
        styleTags: [.classic, .slim],
        prescriptionCompatible: true,
        source: .developmentSeed,
        matchScore: 0.85
    )

    static let ivoCorsa = FrameProduct(
        id: "seed-ivo-corsa",
        brand: "Ivo Lunetterie",
        modelName: "Corsa",
        category: .sunglasses,
        retailerName: "Sample Retailer",
        price: 185,
        shape: .aviator,
        material: .metal,
        frameColor: .silver,
        lensColor: .mirrored,
        styleTags: [.sporty, .angular],
        source: .developmentSeed,
        matchScore: 0.72
    )

    static let haldenMira = FrameProduct(
        id: "seed-halden-mira",
        brand: "Halden Optical",
        modelName: "Mira",
        category: .optical,
        retailerName: "Sample Retailer",
        price: 290,
        shape: .catEye,
        material: .acetate,
        frameColor: .black,
        lensColor: .clear,
        styleTags: [.retro, .bold],
        prescriptionCompatible: true,
        source: .developmentSeed,
        matchScore: 0.83
    )

    static let northlightLane = FrameProduct(
        id: "seed-northlight-lane",
        brand: "Northlight Eyewear",
        modelName: "Lane",
        category: .optical,
        retailerName: "Sample Retailer",
        price: 120,
        shape: .rectangle,
        material: .metal,
        frameColor: .gunmetal,
        lensColor: .clear,
        styleTags: [.minimal, .slim],
        prescriptionCompatible: true,
        source: .developmentSeed,
        matchScore: 0.7
    )

    static let verraSol = FrameProduct(
        id: "seed-verra-sol",
        brand: "Verra Studio",
        modelName: "Sol",
        category: .sunglasses,
        retailerName: "Sample Retailer",
        price: 95,
        shape: .round,
        material: .metal,
        frameColor: .gold,
        lensColor: .brown,
        styleTags: [.retro, .minimal],
        source: .developmentSeed,
        matchScore: 0.79
    )

    static let all: [FrameProduct] = [
        haldenArlo, northlightWren, verraPalma, marisolPikeDune, okonFlint,
        bellweatherSkyline, ivoCorsa, haldenMira, northlightLane, verraSol,
    ]
}
