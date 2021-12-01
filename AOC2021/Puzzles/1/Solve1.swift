
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
	var answerB = "0"

	func solveA() -> String {
		solveA("Input1").description
	}

	func solveB() -> String {
		solveB("Input1").description
	}

	func solveA(_ fileName: String) -> Int {
		let input = FileHelper.load(fileName)!.filter { !$0.isEmpty }

		let values = input.map { Int($0)! }
		var score = 0
		for i in 1..<input.count {
			if values[i] > values[i-1] {
				score += 1
			}
		}
		return score
	}
	
	func solveB(_ fileName: String) -> Int {
		let input = FileHelper.load(fileName)!.filter { !$0.isEmpty }

		let values = input.map { Int($0)! }
		var score = 0
		for i in 3..<input.count {
			if values[i] > values[i-3] {
				score += 1
			}
		}
		return score
	}
}
