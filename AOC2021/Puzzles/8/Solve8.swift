
import AOCLib
import Foundation

class Solve8: PuzzleSolver {
	func solveAExamples() -> Bool {
		solveA("Example8") == 26
	}

	func solveBExamples() -> Bool {
		solveB("Example8") == 61229
	}

	var answerA = "476"
	var answerB = "1011823"

	func solveA() -> String {
		solveA("Input8").description
	}

	func solveB() -> String {
		solveB("Input8").description
	}

	// Counts of digits:
	// 2: 1
	// 3: 7
	// 4: 4
	// 5: 2, 3, 5
	// 6: 0, 6, 9
	// 7: 8

	struct Test {
		var signals: [String]
		var outputs: [String]

		var output: Int {
			// map the signals to their values.
			var signalMap: [Int: Set<Character>] = [:]

			// first pass, do the easy ones.
			signalMap[1] = Set(signals.first { $0.count == 2 }!)
			signalMap[7] = Set(signals.first { $0.count == 3 }!)
			signalMap[4] = Set(signals.first { $0.count == 4 }!)
			signalMap[8] = Set(signals.first { $0.count == 7 }!)

			// 6 digits: 6, 9, 0
			let sixes = signals.filter { $0.count == 6 }.map { Set($0) }
			sixes.forEach {
				// if not superset of 1, then value is 6
				if !Set($0).isSuperset(of: Set(signalMap[1]!)) {
					signalMap[6] = $0
					// if superset of 4, then value is 9
				} else if Set($0).isSuperset(of: Set(signalMap[4]!)) {
					signalMap[9] = $0
				} else {
					// otherwise, value is 0
					signalMap[0] = $0
				}
			}

			// 5 digits: 2, 3, 5
			let fives = signals.filter { $0.count == 5 }.map { Set($0) }
			fives.forEach {
				//  if superset of 1, then value is 3
				if Set($0).isSuperset(of: Set(signalMap[1]!)) {
					signalMap[3] = $0
					// if 6 is superset of us, then value is 5
				} else if Set(signalMap[6]!).isSuperset(of: Set($0)) {
					signalMap[5] = $0
				} else {
					signalMap[2] = $0
				}
			}

			func digitFor(_ s: String) -> Int {
				signalMap.first { $0.value == Set(s) }!.key
			}

			// Got all the digits, now just convert.
			return
				digitFor(outputs[3]) +
				digitFor(outputs[2]) * 10 +
				digitFor(outputs[1]) * 100 +
				digitFor(outputs[0]) * 1000
		}
	}

	func load(_ fileName: String) -> [Test] {
		let input = FileHelper.load(fileName)!.filter { !$0.isEmpty }
		let tests: [Test] = input.map {
			let tokens = $0.components(separatedBy: "|")
			return Test(
				signals: tokens[0].components(separatedBy: " ").filter { !$0.isEmpty },
				outputs: tokens[1].components(separatedBy: " ").filter { !$0.isEmpty }
			)
		}
		return tests
	}

	func solveA(_ fileName: String) -> Int {
		let tests = load(fileName)

		let searchCounts = [2, 3, 4, 7]
		let count = tests.reduce(0) { sum, test in
			let oneCount = test.outputs.reduce(0) { sum, output in
				sum + (searchCounts.contains { $0 == output.count } ? 1 : 0)
			}
			return sum + oneCount
		}

		return count
	}

	func solveB(_ fileName: String) -> Int {
		let tests = load(fileName)
		let answer = tests.reduce(0) {
			$0 + $1.output
		}
		return answer
	}
}
