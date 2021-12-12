
import AOCLib
import Foundation

class Solve12: PuzzleSolver {
	func solveAExamples() -> Bool {
		if solveA("Example12-1") != 10 {
			return false
		}
		if solveA("Example12-2") != 19 {
			return false
		}
		if solveA("Example12-3") != 226 {
			return false
		}
		return true
	}

	func solveBExamples() -> Bool {
		true
	}

	var answerA = ""
	var answerB = ""

	func solveA() -> String {
		""
//		solveA("Input12").description
	}

	func solveB() -> String {
//		solveB("Input12").description
		""
	}

	func solveA(_ fileName: String) -> Int {
		let values = FileHelper.load(fileName)!.filter { !$0.isEmpty }
		return 0
	}

	func solveB(_: String) -> Int {
		0
	}
}
