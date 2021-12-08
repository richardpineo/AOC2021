
import AOCLib
import Foundation

class Solve8: PuzzleSolver {
	func solveAExamples() -> Bool {
		solveA("Example8") == 26
	}

	func solveBExamples() -> Bool {
		true
	}

	var answerA = "476"
	var answerB = ""

	func solveA() -> String {
		solveA("Input8").description
	}

	func solveB() -> String {
		""
	}
	
	struct Test {
		var signals: [String]
		var outputs: [String]
	}
	
	func load(_ fileName: String) -> [Test] {
		let input = FileHelper.load(fileName)!.filter { !$0.isEmpty }
		let tests: [Test] = input.map {
			let tokens = $0.components(separatedBy: "|")
			return Test(
				signals: tokens[0].components(separatedBy: " ").filter { !$0.isEmpty },
				outputs: tokens[1].components(separatedBy: " ").filter { !$0.isEmpty })
		}
		return tests
	}
	
	let digitCount = [ 6, 2, 5, 5, 4, 5, 6, 3, 7, 6 ]
	
	func solveA(_ fileName: String) -> Int {
		let tests = load(fileName)
		
		let searchCounts = [2, 3, 4, 7]
		let count = tests.reduce(0) { sum, test in
			let oneCount = test.outputs.reduce(0) { sum, output in
				return sum + (searchCounts.contains { $0 == output.count } ? 1 : 0)
			}
			return sum + oneCount
		}
		
		return count
	}
}
