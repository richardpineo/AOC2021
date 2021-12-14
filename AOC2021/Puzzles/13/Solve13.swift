
import AOCLib
import Foundation

class Solve13: PuzzleSolver {
	func solveAExamples() -> Bool {
		if solveA("Example13") != 17 {
			return false
		}
		return true
	}

	func solveBExamples() -> Bool {
		return true
	}

	var answerA = ""
	var answerB = ""
	
	func solveA() -> String {
		solveA("Input13").description
	}

	func solveB() -> String {
		""
	}
	
	struct Instruction {
		var isX: Bool
		var line: Int
	}
	
	struct Input {
		var instructions: [Instruction]
		var dots: [Position2D]
	}

	func load(_ fileName: String) -> Input {
		let values = FileHelper.load(fileName)!
		var dots: [Position2D] = []
		var index = 0
		while !values[index].isEmpty {
			let position = values[index].components(separatedBy: ",")
			dots.append(.init(Int(position[0])!, Int(position[1])!))
			index += 1
		}
		index += 1

		var instructions: [Instruction] = []
		while index < values.count && !values[index].isEmpty {
			let tokens = values[index].components(separatedBy: " ")[2].components(separatedBy: "=")
			instructions.append(.init(isX: tokens[0] == "x", line: Int(tokens[1])!))
			index += 1
		}
		
		return .init(instructions: instructions, dots: dots)
	}

	func solveA(_ fileName: String) -> Int {
		let input = load(fileName)
		
		return 0
	}

	func solveB(_ fileName: String) -> Int {
		0
	}
}
