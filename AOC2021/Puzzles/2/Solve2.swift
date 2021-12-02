
import AOCLib
import Foundation

class Solve2: PuzzleSolver {
	func solveAExamples() -> Bool {
		solveA("Example2") == 150
	}

	func solveBExamples() -> Bool {
		solveB("Example2") == 900
	}

	var answerA = "1815044"
	var answerB = "1739283308"

	func solveA() -> String {
		solveA("Input2").description
	}

	func solveB() -> String {
		solveB("Input2").description
	}

	func solveA(_ fileName: String) -> Int {
		let input = FileHelper.loadAndTokenize(fileName)

		var horiz = 0
		var vert = 0

		input.forEach { line in
			let val = Int(line[1])!
			switch line[0] {
			case "forward":
				horiz += val
			case "up":
				vert -= val
			case "down":
				vert += val
			default:
				break
			}
		}
		return horiz * vert
	}

	func solveB(_ fileName: String) -> Int {
		let input = FileHelper.loadAndTokenize(fileName)

		var horiz = 0
		var vert = 0
		var aim = 0

		input.forEach { line in
			let val = Int(line[1])!
			switch line[0] {
			case "forward":
				horiz += val
				vert += val * aim
			case "up":
				aim -= val
			case "down":
				aim += val
			default:
				break
			}
		}
		return horiz * vert
	}
}
