
import AOCLib
import Foundation

class Solve14: PuzzleSolver {
	func solveAExamples() -> Bool {
		if solveA("Example14") != 1588 {
			return false
		}
		return true
	}

	func solveBExamples() -> Bool {
//		solveB("Example14")
		return true
	}

	var answerA = ""
	var answerB = ""
	
	func solveA() -> String {
		solveA("Input14").description
	}

	func solveB() -> String {
		""
//		solveB("Input14")
	}
	
	struct Input {
		var template: String
		var rules: Dictionary<String, String>
	}
	
	func load(_ fileName: String) -> Input {
		let values = FileHelper.load(fileName)!
		
		var rules = Dictionary<String, String>()
		for index in 2..<values.count-1 {
			let tokens = values[index].components(separatedBy: [" ", "-", ">"])
			rules[tokens[0]] = tokens[4]
		}
		return .init(template: values[0], rules: rules)
	}

	func solveA(_ fileName: String) -> Int {
		let input = load(fileName)
		return 0
	}

	func solveB(_ fileName: String) -> Int {
		0
	}
}
