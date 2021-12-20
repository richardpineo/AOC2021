
import AOCLib
import Foundation

class Solve20: PuzzleSolver {
	func solveAExamples() -> Bool {
		solve("Example20", iterations: 2) == 35
	}

	func solveBExamples() -> Bool {
		solve("Example20", iterations: 50) == 3351
	}

	var answerA = "4964"
	var answerB = "13202"

	func solveA() -> String {
		solve("Input20", iterations: 2).description
	}

	func solveB() -> String {
		solve("Input20", iterations: 50).description
	}

	var shouldTestB: Bool = false

	struct Image {
		var algorithm: String
		var image: [Position2D: Bool]

		func isLit(_ pos: Position2D, _ defaultVal: Bool) -> Bool {
			if let val = image[pos] {
				return val
			}
			return defaultVal
		}

		var bounds: (Position2D, Position2D) {
			// Find the bounds
			var minPos = Position2D.origin
			var maxPos = Position2D.origin

			image.forEach {
				minPos.x = min(minPos.x, $0.key.x)
				minPos.y = min(minPos.y, $0.key.y)

				maxPos.x = max(maxPos.x, $0.key.x)
				maxPos.y = max(maxPos.y, $0.key.y)
			}
			return (minPos, maxPos)
		}

		var description: String {
			let (minPos, maxPos) = bounds
			var s = ""
			for y in minPos.y ... maxPos.y {
				for x in minPos.x ... maxPos.x {
					s.append(isLit(.init(x, y), false) ? "#" : ".")
				}
				s.append("\n")
			}
			return s
		}
	}

	func load(_ fileName: String) -> Image {
		let lines = FileHelper.load(fileName)!.filter { !$0.isEmpty }

		var image = [Position2D: Bool]()
		for index in 1 ..< lines.count {
			let line = lines[index]
			for row in 0 ..< line.count {
				if line.character(at: row) == "#" {
					image[.init(row, index - 1)] = true
				}
			}
		}

		return Image(algorithm: lines[0], image: image)
	}

	func willBeLit(_ bits: [Bool], _ algorithm: String) -> Bool {
		let binary = bits.map { $0 ? "1" : "0" }.joined()
		let offset = Int(binary.binaryToNumber())
		return algorithm.character(at: offset) == "#"
	}

	func enhance(_ image: inout Image, _ background: Bool) {
		let (minPos, maxPos) = image.bounds

		var newImage = [Position2D: Bool]()
		for y in (minPos.y - 1) ... (maxPos.y + 1) {
			for x in (minPos.x - 1) ... (maxPos.x + 1) {
				let positions = Position2D(x, y).neighbors(includeSelf: true)
				let bits: [Bool] = positions.map { image.isLit($0, background) }
				newImage[.init(x, y)] = willBeLit(bits, image.algorithm)
			}
		}

		image.image = newImage

		// print(image.description)
	}

	func solve(_ fileName: String, iterations: Int) -> Int {
		var image = load(fileName)

		// print(image.description)
		let backgroundToggles = image.algorithm.character(at: 0) == "#"

		for i in 0 ..< iterations {
			let background = (i % 2) == 1 ? (backgroundToggles ? true : false) : false
			enhance(&image, background)
		}

		let count = image.image.reduce(0) {
			$0 + ($1.value ? 1 : 0)
		}
		return count
	}
}
