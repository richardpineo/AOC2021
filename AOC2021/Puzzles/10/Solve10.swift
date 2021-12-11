
import AOCLib
import Foundation

class Solve10: PuzzleSolver {
	func solveAExamples() -> Bool {
		solveA("Example10") == 26397
	}

	func solveBExamples() -> Bool {
		solveB("Example10") == 288_957
	}

	var answerA = "319329"
	var answerB = "3515583998"

	func solveA() -> String {
		solveA("Input10").description
	}

	func solveB() -> String {
		solveB("Input10").description
	}

	private let pairs: [Character: Character] = [
		")": "(",
		"]": "[",
		"}": "{",
		">": "<",
	]

	private let invalidScores: [Character: Int] = [
		")": 3,
		"]": 57,
		"}": 1197,
		">": 25137,
	]

	private let completionScores: [Character: Int] = [
		")": 1,
		"]": 2,
		"}": 3,
		">": 4,
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

	func complete(_ s: String) -> String {
		var current = Stack<Character>()
		for c in s {
			switch c {
			case "(", "[", "{", "<":
				current.push(c)

			default:
				_ = current.pop()
			}
		}
		// what's left is our stuffs.
		var answer = ""
		while let c = current.pop() {
			let toAdd = pairs.first { $0.value == c }!.key
			answer.append(toAdd)
		}
		return answer
	}

	func solveA(_ fileName: String) -> Int {
		let values = FileHelper.load(fileName)!.filter { !$0.isEmpty }
		let invalid = values.compactMap { findInvalid($0) }
		let score = invalid.reduce(0) {
			$0 + invalidScores[$1]!
		}
		return score
	}

	func solveB(_ fileName: String) -> Int {
		let values = FileHelper.load(fileName)!.filter { !$0.isEmpty }
		let valid = values.compactMap { findInvalid($0) == nil ? $0 : nil }
		let completions = valid.map { complete($0) }
		let scores = completions.map {
			$0.reduce(0) {
				$0 * 5 + completionScores[$1]!
			}
		}.sorted()
		return scores[scores.count / 2]
	}
}
