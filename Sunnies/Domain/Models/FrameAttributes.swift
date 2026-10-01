import Foundation

/// Visual attributes estimated from an image.
///
/// These are probabilistic suggestions from analysis, not verified facts.
/// Present them as "looks like", never as product specifications.
nonisolated struct FrameAttributes: Codable, Hashable, Sendable {
    var shape: FrameShape?
    var material: FrameMaterial?
    var frameColor: FrameColor?
    var lensCharacteristics: [LensCharacteristic]
    var styleDescriptors: [StyleDescriptor]

    init(
        shape: FrameShape? = nil,
        material: FrameMaterial? = nil,
        frameColor: FrameColor? = nil,
        lensCharacteristics: [LensCharacteristic] = [],
        styleDescriptors: [StyleDescriptor] = []
    ) {
        self.shape = shape
        self.material = material
        self.frameColor = frameColor
        self.lensCharacteristics = lensCharacteristics
        self.styleDescriptors = styleDescriptors
    }
}
