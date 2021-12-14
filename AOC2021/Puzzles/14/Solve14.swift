
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

	var answerA = "2509"
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
	
	func transform(_ s: String, _ rules: Dictionary<String, String>) -> String {
		var out = ""
		for i in 0..<s.count-1 {
			out += String(s.character(at: i))
			out += rules[s.subString(start: i, count: 2)]!
		}
		out += String(s.character(at: s.count-1))
		return out
	}

	func solveA(_ fileName: String) -> Int {
		let input = load(fileName)
		var output = input.template
		for _ in 0..<10 {
			output = transform(output, input.rules)
		}
		// find the counts.
		var found = Dictionary<Character, Int>()
		for c in Set(output) {
			found[c] = 0
		}
		for c in output {
			found[c]! += 1
		}
		let minVal = found.min { $0.value < $1.value }
		let maxVal = found.max { $0.value < $1.value }
		return maxVal!.value - minVal!.value
	}

	func solveB(_ fileName: String) -> Int {
		0
	}
}
