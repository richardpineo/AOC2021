
import AOCLib
import Foundation

class Solve10: PuzzleSolver {
	func solveAExamples() -> Bool {
		solveA("Example10") == 26397
	}

	func solveBExamples() -> Bool {
		true
	}

	var answerA = ""
	var answerB = ""

	func solveA() -> String {
		solveA("Input10").description
	}

	func solveB() -> String {
		""
	}
	
	private let pairs: Dictionary<Character, Character> = [
		")" : "(",
		"]" : "[",
		"}" : "{",
		">" : "<",
	]
	
	private let scores: Dictionary<Character, Int> = [
		")" : 3,
		"]" : 57,
		"}" : 1197,
		">" : 25137,
	]
	
	func findInvalid(_ s: String) -> Character? {
		var current = Stack<Character>()
		for c in s {
			switch c {
			case "(", "[", "{", "<":
				current.push(c)
								
			default:
				let shouldBe = pairs[c]
				if shouldBe != current.pop() {
					return c
				}
			}
		}
		return nil
	}

	func solveA(_ fileName: String) -> Int {
		let values = FileHelper.load(fileName)!.filter { !$0.isEmpty }
		let invalid = values.compactMap { findInvalid($0) }
		let score = invalid.reduce(0) {
			$0 + scores[$1]!
		}
		return score
	}

	func solveB(_ fileName: String) -> Int {
		0
	}
}
