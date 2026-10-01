import Foundation

// Shared vocabulary for describing frames. Raw values are a persistence and
// API contract — rename cases only with a migration.

nonisolated enum FrameCategory: String, Codable, CaseIterable, Sendable {
    case sunglasses
    case optical
}

nonisolated enum FrameShape: String, Codable, CaseIterable, Sendable {
    case round
    case oval
    case square
    case rectangle
    case catEye
    case aviator
    case browline
    case wraparound
    case rimless
    case geometric
}

nonisolated enum FrameMaterial: String, Codable, CaseIterable, Sendable {
    case acetate
    case metal
    case mixed
    case rimless
    case plastic
    case unknown
}

nonisolated enum FrameColor: String, Codable, CaseIterable, Sendable {
    case black
    case tortoise
    case brown
    case clear
    case gold
    case silver
    case gunmetal
    case amber
    case transparent
    case multiColor
}

nonisolated enum LensCharacteristic: String, Codable, CaseIterable, Sendable {
    case clear
    case grey
    case brown
    case green
    case gradient
    case mirrored
    case tinted
}

nonisolated enum StyleDescriptor: String, Codable, CaseIterable, Sendable {
    case chunky
    case slim
    case oversized
    case narrow
    case angular
    case retro
    case minimal
    case vintageInspired
    case sporty
    case classic
    case bold
    case understated
}
