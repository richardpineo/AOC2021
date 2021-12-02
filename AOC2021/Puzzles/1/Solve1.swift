
import AOCLib
import Foundation

class Solve1: PuzzleSolver {
	func solveAExamples() -> Bool {
		solveA("Example1") == 7
	}

	func solveBExamples() -> Bool {
		solveB("Example1") == 5
	}

	var answerA = "1527"
	var answerB = "1575"

	func solveA() -> String {
		solveA("Input1").description
	}

	func solveB() -> String {
		solveB("Input1").description
	}

	func solveA(_ fileName: String) -> Int {
		solve(fileName, 1)
	}

	func solveB(_ fileName: String) -> Int {
		solve(fileName, 3)
	}

	func solve(_ fileName: String, _ offset: Int) -> Int {
		let input = FileHelper.load(fileName)!.filter { !$0.isEmpty }

		let values = input.map { Int($0)! }
		var score = 0
		for i in offset ..< input.count {
			if values[i] > values[i - offset] {
				score += 1
			}
		}
		return score
	}
}
