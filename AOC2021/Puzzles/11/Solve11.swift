
import AOCLib
import Foundation

class Solve11: PuzzleSolver {
	func solveAExamples() -> Bool {
		solveA("Example11") == 1656
	}

	func solveBExamples() -> Bool {
		true
	}

	var answerA = ""
	var answerB = ""

	func solveA() -> String {
		solveA("Input11").description
	}

	func solveB() -> String {
		solveB("").description
	}

	func solveA(_ fileName: String) -> Int {
		let grid = Grid2D(fileName: fileName)
		return 0
	}

	func solveB(_ fileName: String) -> Int {
		0
	}
}
