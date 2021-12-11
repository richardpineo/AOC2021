
import AOCLib
import Foundation

class Solve11: PuzzleSolver {
	func solveAExamples() -> Bool {
		solveA("Example11") == 1656
	}

	func solveBExamples() -> Bool {
		true
	}

	var answerA = "1608"
	var answerB = ""

	func solveA() -> String {
		solveA("Input11").description
	}

	func solveB() -> String {
		solveB("").description
	}

	func increment(_ grid: inout Grid2D) {
		for x in 0 ..< grid.maxPos.x {
			for y in 0 ..< grid.maxPos.y {
				let pos = Position2D(x,y)
				let val = grid.value(pos)
				grid.setValue(pos, val + 1)
			}
		}
	}
	
	func flash(_ grid: inout Grid2D) -> Int {
		var flashCount = 0
		for x in 0 ..< grid.maxPos.x {
			for y in 0 ..< grid.maxPos.y {
				let pos = Position2D(x,y)
				let val = grid.value(pos)
				if val > 9 {
					flashCount += 1
					// increment all the neighbors
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
		
		// Turn off to hide printing.
		let debug = true
		
		print("Before any steps:\n\(grid.debugDisplay)")

		var flashCount = 0
		for i in 0..<100 {

			if debug {
			if i == 10 {
				print("After 10, \(flashCount) flashes (expect 204)")
			}
			}
			
			increment(&grid)

			var didFlash = true
			while didFlash {
				let thisCount = flash(&grid)
				didFlash = thisCount > 0
				flashCount += thisCount
			}

			if debug {
			print("After step \(i+1):\n\(grid.debugDisplay)")
			}
		}
		
		return flashCount
	}

	func solveB(_ fileName: String) -> Int {
		0
	}
}
