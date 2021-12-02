
import AOCLib
import Foundation

class Solve2: PuzzleSolver {
	func solveAExamples() -> Bool {
		solveA("Example2") == 150
	}

	func solveBExamples() -> Bool {
		solveB("Example2") == 0
	}

	var answerA = ""
	var answerB = ""

	func solveA() -> String {
		solveA("Input2").description
	}

	func solveB() -> String {
		solveB("Input2").description
	}

	func solveA(_ fileName: String) -> Int {
		solve(fileName)
	}
	
	func solveB(_ fileName: String) -> Int {
//		solve(fileName, 3)
		0
	}
	
	enum Command {
		case forward(Int)
		case down(Int)
		case up(Int)
	}
	
	func solve(_ fileName: String) -> Int {
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
				break;
			}
		}
		return horiz * vert
	}
}
