
import AOCLib
import Foundation

class Solve14: PuzzleSolver {
	func solveAExamples() -> Bool {
		solveA("Example14") == 1588
	}

	func solveBExamples() -> Bool {
		solveB("Example14") == 2_188_189_693_529
	}

	var answerA = "2509"
	var answerB = "2827627697643"

	func solveA() -> String {
		solveA("Input14").description
	}

	func solveB() -> String {
		solveB("Input14").description
	}

	struct Input {
		var templateRaw: String
		var template: [String: Int]
		var rules: [String: String]
	}

	func load(_ fileName: String) -> Input {
		let values = FileHelper.load(fileName)!

		var rules = [String: String]()
		for index in 2 ..< values.count - 1 {
			let tokens = values[index].components(separatedBy: [" ", "-", ">"])
			rules[tokens[0]] = tokens[4]
		}

		var template = [String: Int]()
		for i in 0 ..< values[0].count - 1 {
			template[values[0].subString(start: i, count: 2)] = 1
		}
		return .init(templateRaw: values[0], template: template, rules: rules)
	}

	func addOrIncrement(_ d: inout [String: Int], _ s: String, _ by: Int) {
		if let found = d[s] {
			d[s] = found + by
		} else {
			d[s] = by
		}
	}

	func transform(_ rules: [String: String], _ counts: [String: Int]) -> [String: Int] {
		var transformed = [String: Int]()

		counts.forEach { oldCount in
			// AB and rule AB->C yields
			// AC and CB
			let newChar = rules[oldCount.key]!
			let new1 = "\(oldCount.key.character(at: 0))\(newChar)"
			let new2 = "\(newChar)\(oldCount.key.character(at: 1))"
			addOrIncrement(&transformed, new1, oldCount.value)
			addOrIncrement(&transformed, new2, oldCount.value)
		}
		return transformed
	}

	func solve(_ fileName: String, count: Int) -> Int {
		let input = load(fileName)
		var output = input.template

		for _ in 0 ..< count {
			output = transform(input.rules, output)
		}

		var found = [String: Int]()
		output.forEach { pair in
			addOrIncrement(&found, String(pair.key.character(at: 0)), pair.value)
		}
		let lastChar = String(input.templateRaw.last!)
		addOrIncrement(&found, lastChar, 1)

		let minVal = found.min { $0.value < $1.value }
		let maxVal = found.max { $0.value < $1.value }
		return maxVal!.value - minVal!.value
	}

	func solveA(_ fileName: String) -> Int {
		solve(fileName, count: 10)
	}

	func solveB(_ fileName: String) -> Int {
		solve(fileName, count: 40)
	}
}
