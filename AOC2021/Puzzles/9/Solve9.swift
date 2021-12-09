
import AOCLib
import Foundation

class Solve9: PuzzleSolver {
	func solveAExamples() -> Bool {
		solveA("Example9") == 15
	}

	func solveBExamples() -> Bool {
		true
	}

	var answerA = "572"
	var answerB = ""

	func solveA() -> String {
		solveA("Input9").description
	}

	func solveB() -> String {
		""
	}

	struct Grid {
		init(values: [String]) {
			maxPos = .init(values[0].count, values.count)
			tubes = []
			values.forEach {
				$0.forEach {
					tubes.append(Int(String($0))!)
				}
			}
		}

		var maxPos: Position2D

		func valid(_ pos: Position2D) -> Bool {
			pos.x >= 0 && pos.y >= 0 && pos.x < maxPos.x && pos.y < maxPos.y
		}

		func value(_ pos: Position2D) -> Int {
			tubes[pos.arrayIndex(numCols: maxPos.x)]
		}

		func isLow(_ pos: Position2D) -> Bool {
			let party = pos.neighbors(includeSelf: true)
				.filter { $0.cityDistance(pos) < 2 }
				.filter { valid($0) }
			let lowest = party.min { value($0) < value($1) }!
			return lowest == pos
		}

		private var tubes: [Int]
	}

	func solveA(_ fileName: String) -> Int {
		let values = FileHelper.load(fileName)!.filter { !$0.isEmpty }
		let grid = Grid(values: values)
		var lowest: [Position2D] = []
		for x in 0 ..< grid.maxPos.x {
			for y in 0 ..< grid.maxPos.y {
				if grid.isLow(.init(x, y)) {
					lowest.append(.init(x, y))
				}
			}
		}
		let risk = lowest.reduce(0) {
			$0 + 1 + grid.value($1)
		}
		return risk
	}
}
