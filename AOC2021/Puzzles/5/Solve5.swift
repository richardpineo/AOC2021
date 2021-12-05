
import AOCLib
import Foundation

class Solve5: PuzzleSolver {
	func solveAExamples() -> Bool {
		solve("Example5", orthogonalOnly: true) == 5
	}

	func solveBExamples() -> Bool {
		solve("Example5", orthogonalOnly: false) == 12
	}

	var answerA = "4655"
	var answerB = "20500"

	func solveA() -> String {
		solve("Input5", orthogonalOnly: true).description
	}

	func solveB() -> String {
		solve("Input5", orthogonalOnly: false).description
	}

	struct Line {
		var p1: Position2D
		var p2: Position2D
	}

	func solve(_ fileName: String, orthogonalOnly: Bool) -> Int {
		let input = FileHelper.load(fileName)!.filter { !$0.isEmpty }

		let lines: [Line] = input.map {
			let tokens = $0.components(separatedBy: [" ", ","])
			return Line(
				p1: .init(Int(tokens[0])!, Int(tokens[1])!),
				p2: .init(Int(tokens[3])!, Int(tokens[4])!)
			)
		}

		let filteredLines = orthogonalOnly ? lines.filter { $0.p1.x == $0.p2.x || $0.p1.y == $0.p2.y } : lines

		var coverage: [Position2D: Int] = [:]

		func add(_ p: Position2D) {
			let c = coverage[p] ?? 0
			coverage[p] = c + 1
		}

		filteredLines.forEach {
			let rangeX = $0.p2.x - $0.p1.x
			let rangeY = $0.p2.y - $0.p1.y
			let numSteps = max(abs(rangeX), abs(rangeY))
			let stepX = rangeX / numSteps
			let stepY = rangeY / numSteps

			for step in 0 ... numSteps {
				add(.init($0.p1.x + step * stepX, $0.p1.y + step * stepY))
			}
		}

		let count = coverage.reduce(0) {
			$0 + ($1.value > 1 ? 1 : 0)
		}
		return count

		/* Debug
		 func char(_ p: Position2D) -> String {
		 	if let v = coverage[p] {
		 		return v.description
		 	}
		 	return "."
		 }

		 for col in 0...9 {
		 	print((0...9).map( { char(.init($0, col)) }).joined())
		 } */
	}
}
