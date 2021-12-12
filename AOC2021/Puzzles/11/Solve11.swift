
import AOCLib
import Foundation

class Solve11: PuzzleSolver {
	func solveAExamples() -> Bool {
		solveA("Example11") == 1656
	}

	func solveBExamples() -> Bool {
		solveB("Example11") == 195
	}

	var answerA = "1608"
	var answerB = "214"

	func solveA() -> String {
		solveA("Input11").description
	}

	func solveB() -> String {
		solveB("Input11").description
	}

	func increment(_ grid: inout Grid2D) {
		for x in 0 ..< grid.maxPos.x {
			for y in 0 ..< grid.maxPos.y {
				let pos = Position2D(x, y)
				grid.setValue(pos, grid.value(pos) + 1)
			}
		}
	}

	func flash(_ grid: inout Grid2D) -> Int {
		var flashCount = 0
		for x in 0 ..< grid.maxPos.x {
			for y in 0 ..< grid.maxPos.y {
				let pos = Position2D(x, y)
				if grid.value(pos) > 9 {
					flashCount += 1

					let neighbors = grid.neighbors(pos, includePos: false, includeDiagonals: true)
					neighbors.forEach {
						if grid.value($0) != 0 {
							grid.setValue($0, grid.value($0) + 1)
						}
					}

					grid.setValue(pos, 0)
				}
			}
		}
		return flashCount
	}

	func solveA(_ fileName: String) -> Int {
		var grid = Grid2D(fileName: fileName)

		var flashCount = 0
		for _ in 0 ..< 100 {
			increment(&grid)

			var didFlash = true
			while didFlash {
				let thisCount = flash(&grid)
				didFlash = thisCount > 0
				flashCount += thisCount
			}
		}

		return flashCount
	}

	func solveB(_ fileName: String) -> Int {
		var grid = Grid2D(fileName: fileName)

		let maxSteps = 1000
		let syncCount = grid.maxPos.x * grid.maxPos.y - 1
		for i in 0 ..< maxSteps {
			increment(&grid)

			var didFlash = true
			while didFlash {
				let thisCount = flash(&grid)
				if grid.allSatisfy({ $0 == 0 }) || thisCount == syncCount {
					return i + 1
				}
				didFlash = thisCount > 0
			}
		}

		return -666
	}
}
