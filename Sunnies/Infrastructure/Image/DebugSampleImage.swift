#if DEBUG
import CoreGraphics
import Foundation
import ImageIO
import UniformTypeIdentifiers

/// Generated stand-in photo for UI tests and simulator runs, which can't
/// drive the system photo picker. DEBUG builds only.
nonisolated enum DebugSampleImage {
    static func pngData(width: Int = 1200, height: Int = 900) -> Data? {
        guard let context = CGContext(
            data: nil,
            width: width,
            height: height,
            bitsPerComponent: 8,
            bytesPerRow: 0,
            space: CGColorSpaceCreateDeviceRGB(),
            bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
        ) else { return nil }

        let w = CGFloat(width)
        let h = CGFloat(height)
        context.setFillColor(CGColor(red: 0.98, green: 0.97, blue: 0.94, alpha: 1))
        context.fill(CGRect(x: 0, y: 0, width: w, height: h))

        // A simple pair of round frames with a bridge.
        context.setStrokeColor(CGColor(red: 0.16, green: 0.11, blue: 0.02, alpha: 1))
        context.setLineWidth(w * 0.02)
        let lensSize = w * 0.26
        let lensY = (h - lensSize) / 2
        context.strokeEllipse(in: CGRect(x: w * 0.18, y: lensY, width: lensSize, height: lensSize))
        context.strokeEllipse(in: CGRect(x: w * 0.56, y: lensY, width: lensSize, height: lensSize))
        context.move(to: CGPoint(x: w * 0.44, y: h / 2))
        context.addLine(to: CGPoint(x: w * 0.56, y: h / 2))
        context.strokePath()

        guard let image = context.makeImage() else { return nil }
        let data = NSMutableData()
        guard let destination = CGImageDestinationCreateWithData(data, UTType.png.identifier as CFString, 1, nil) else {
            return nil
        }
        CGImageDestinationAddImage(destination, image, nil)
        guard CGImageDestinationFinalize(destination) else { return nil }
        return data as Data
    }
}
#endif
