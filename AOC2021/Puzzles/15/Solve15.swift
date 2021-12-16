
import AOCLib
import Foundation

class Solve15: PuzzleSolver {
	func solveAExamples() -> Bool {
		solveA("Example15") == 40
	}

	func solveBExamples() -> Bool {
		true
	}

	var answerA = ""
	var answerB = ""

	func solveA() -> String {
		solveA("Input15").description
	}

	func solveB() -> String {
		""
	}

	func solveA(_ fileName: String) -> Int {
		var grid = Grid2D(fileName: fileName)
		return 0
	}

	func solveB(_ fileName: String) -> Int {
		0
	}
}
