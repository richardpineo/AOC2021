
import AOCLib
import Foundation

class Solve1: PuzzleSolver {
	func solveAExamples() -> Bool {
		true
	}

	func solveBExamples() -> Bool {
		true
	}

	var answerA = "0"
	var answerB = "0"

	func solveA() -> String {
		let file = FileHelper.load("Input1")
		return solveA(input: file?[0] ?? "").description
	}

	func solveB() -> String {
		let file = FileHelper.load("Input1")
		return solveB(input: file?[0] ?? "").description
	}

	func solveA(input: String) -> Int {
		0
	}

	func solveB(input: String) -> Int {
		0
	}
}
