
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

	var answerA = "814"
	var answerB = ""
	
	func solveA() -> String {
		solveA("Input13").description
	}

	func solveB() -> String {
		""
	}
	
	struct Instruction {
		var isX: Bool
		var index: Int
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
			instructions.append(.init(isX: tokens[0] == "x", index: Int(tokens[1])!))
			index += 1
		}
		
		return .init(instructions: instructions, dots: dots)
	}
	
	func fold(_ how: Instruction, _ dots: [Position2D]) -> [Position2D] {
		let folded: [Position2D] = dots.map { dot in
			if how.isX {
				if dot.x > how.index {
					return .init(how.index - (dot.x - how.index), dot.y)
				} else {
					return dot
				}
			} else {
				if dot.y > how.index {
					return .init(dot.x, how.index - (dot.y - how.index))
				} else {
					return dot
				}
			}
		}
		return Array(Set(folded))
	}

	func solveA(_ fileName: String) -> Int {
		let input = load(fileName)
		
		let folded = fold(input.instructions[0], input.dots)
		return folded.count
	}

	func solveB(_ fileName: String) -> Int {
		0
	}
}
