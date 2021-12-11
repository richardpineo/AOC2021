
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

	func isLow(_ grid: Grid2D, _ pos: Position2D) -> Bool {
		let party = pos.neighbors(includeSelf: true)
			.filter { $0.cityDistance(pos) < 2 }
			.filter { grid.valid($0) }
		let lowest = party.min { grid.value($0) < grid.value($1) }!
		return lowest == pos
	}

	func lowPoints(_ grid: Grid2D ) -> [Position2D] {
		var lowest: [Position2D] = []
		for x in 0 ..< grid.maxPos.x {
			for y in 0 ..< grid.maxPos.y {
				if isLow(grid, .init(x, y)) {
					lowest.append(.init(x, y))
				}
			}
		}
		return lowest
	}

	private func accumulateBasin(_ grid: Grid2D, _ pos: Position2D, basin: inout Set<Position2D>) {
		basin.insert(pos)
		let toCheck = grid.neighbors(pos, includePos: false)
		toCheck.forEach {
			if grid.value($0) != 9, !basin.contains($0) {
				accumulateBasin(grid, $0, basin: &basin)
			}
		}
	}

	func basinFor(_ grid: Grid2D, _ pos: Position2D) -> [Position2D] {
		var basin = Set<Position2D>()
		accumulateBasin(grid, pos, basin: &basin)
		return Array(basin)
	}

	func solveA(_ fileName: String) -> Int {
		let grid = Grid2D(fileName: fileName)
		let risk = lowPoints(grid).reduce(0) {
			$0 + 1 + grid.value($1)
		}
		return risk
	}

	func solveB(_ fileName: String) -> Int {
		let grid = Grid2D(fileName: fileName)
		let scores: [Int] = lowPoints(grid).map { lowPoint in
			let basin = basinFor(grid, lowPoint)
			return basin.count
		}
		let bestScores = scores.sorted().dropFirst(scores.count - 3)
		return bestScores.reduce(1) { $0 * $1 }
	}

	var inputGrid: Grid2D {
		let grid = Grid2D(fileName: "Input9")
		return grid
	}
}
