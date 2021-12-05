
import AOCLib
import Foundation

class Solve5: PuzzleSolver {
	func solveAExamples() -> Bool {
		solveA("Example5") == 5
	}

	func solveBExamples() -> Bool {
		solveB("Example5") == 0
	}

	var answerA = "4655"
	var answerB = ""

	func solveA() -> String {
		solveA("Input5").description
	}

	func solveB() -> String {
		solveB("Input5").description
	}
	
	struct Line {
		var p1: Position2D
		var p2: Position2D
	}
	
	
	func solveA(_ fileName: String) -> Int {
		let input = FileHelper.load(fileName)!.filter { !$0.isEmpty }
		
		let lines: [Line] = input.map {
			let tokens = $0.components(separatedBy: [" ", ","])
			return Line(
				p1: .init(Int(tokens[0])!, Int(tokens[1])!),
				p2: .init(Int(tokens[3])!, Int(tokens[4])!)
			)
		}
		
		let orthogonal = lines.filter { $0.p1.x == $0.p2.x || $0.p1.y == $0.p2.y }
		
		var coverage: Dictionary<Position2D, Int> = [:]

		func add(_ p: Position2D) {
			let c = coverage[p] ?? 0
			coverage[p] = c + 1
		}
		
		orthogonal.forEach {
			if $0.p1.x == $0.p2.x {
				let start = min($0.p1.y, $0.p2.y)
				let end = max($0.p1.y, $0.p2.y)
				for i in start...end {
					add(.init($0.p1.x, i))
				}
			} else {
				let start = min($0.p1.x, $0.p2.x)
				let end = max($0.p1.x, $0.p2.x)
				for i in start...end {
					add(.init(i, $0.p1.y))
				}
			}
		}
		
		let count = coverage.reduce(0) {
			$0 + ($1.value > 1 ? 1 : 0)
		}
		return count
	}

	func solveB(_ fileName: String) -> Int {
		return -666
	}
}
