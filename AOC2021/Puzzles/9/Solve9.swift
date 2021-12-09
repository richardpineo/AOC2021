
import AOCLib
import Foundation

class Solve9: PuzzleSolver {
	func solveAExamples() -> Bool {
		solveA("Example9") == 15
	}

	func solveBExamples() -> Bool {
		solveB("Example9") == 1134
	}

	var answerA = "572"
	var answerB = "847044"

	func solveA() -> String {
		solveA("Input9").description
	}

	func solveB() -> String {
		solveB("Input9").description
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

		private func neighbors(_ pos: Position2D, includePos: Bool) -> [Position2D] {
			pos.neighbors(includeSelf: includePos)
				.filter { $0.cityDistance(pos) < 2 }
				.filter { valid($0) }
		}

		var lowPoints: [Position2D] {
			var lowest: [Position2D] = []
			for x in 0 ..< maxPos.x {
				for y in 0 ..< maxPos.y {
					if isLow(.init(x, y)) {
						lowest.append(.init(x, y))
					}
				}
			}
			return lowest
		}

		private func accumulateBasin(_ pos: Position2D, basin: inout Set<Position2D>) {
			basin.insert(pos)
			let toCheck = neighbors(pos, includePos: false)
			toCheck.forEach {
				if value($0) != 9, !basin.contains($0) {
					accumulateBasin($0, basin: &basin)
				}
			}
		}

		func basinFor(_ pos: Position2D) -> [Position2D] {
			var basin = Set<Position2D>()
			accumulateBasin(pos, basin: &basin)
			return Array(basin)
		}

		private var tubes: [Int]
	}

	func solveA(_ fileName: String) -> Int {
		let values = FileHelper.load(fileName)!.filter { !$0.isEmpty }
		let grid = Grid(values: values)
		let risk = grid.lowPoints.reduce(0) {
			$0 + 1 + grid.value($1)
		}
		return risk
	}

	func solveB(_ fileName: String) -> Int {
		let values = FileHelper.load(fileName)!.filter { !$0.isEmpty }
		let grid = Grid(values: values)
		let scores: [Int] = grid.lowPoints.map { lowPoint in
			let basin = grid.basinFor(lowPoint)
			return basin.count
		}
		let bestScores = scores.sorted().dropFirst(scores.count - 3)
		return bestScores.reduce(1) { $0 * $1 }
	}

	var inputGrid: Grid {
		let values = FileHelper.load("Input9")!.filter { !$0.isEmpty }
		let grid = Grid(values: values)
		return grid
	}
}
