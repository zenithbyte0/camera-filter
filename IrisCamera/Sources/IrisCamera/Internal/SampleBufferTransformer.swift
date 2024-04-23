import AVFoundation
import CoreImage
import Foundation

struct SampleBufferTransformer {
	private let context = CIContext()

    func transform(videoSampleBuffer: CMSampleBuffer) -> CMSampleBuffer {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(videoSampleBuffer) else {
            print("failed to get pixel buffer")
            fatalError()
        }

		let ciImage = CIImage(cvPixelBuffer: pixelBuffer)

		guard let filter = CIFilter(name: "CIColorInvert") else {
			print("failed to create CIColorInvert filter")
			fatalError()
		}

		filter.setValue(ciImage, forKey: kCIInputImageKey)

		guard let outputImage = filter.outputImage else {
			print("failed to get output image from filter")
			fatalError()
		}

		context.render(outputImage, to: pixelBuffer)

		return videoSampleBuffer
    }
}
