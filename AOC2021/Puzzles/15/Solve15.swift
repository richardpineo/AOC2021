
import AOCLib
import Foundation

class Solve15: PuzzleSolver {
	func solveAExamples() -> Bool {
		solveA("Example15") == 40
	}

	func solveBExamples() -> Bool {
		true
	}

	var answerA = "698"
	var answerB = ""

	func solveA() -> String {
		solveA("Input15").description
	}

	func solveB() -> String {
		""
	}
	
	func walk(risks: Grid2D) -> Int {
		let start = Position2D(0,0)
		var lowestCosts = Grid2D(maxPos: risks.maxPos, initialValue: Int.max)
		var toWalk = Queue<Position2D>()
		toWalk.enqueue(start)
		lowestCosts.setValue(start, 0)
		
		while let nextPos = toWalk.dequeue() {
			risks.neighbors(nextPos, includePos: false, includeDiagonals: false).forEach {
				let walkCost = lowestCosts.value(nextPos) + risks.value($0)
				if lowestCosts.value($0) > walkCost {
					lowestCosts.setValue($0, walkCost)
					toWalk.enqueue($0)
				}
			}
		}
		return lowestCosts.value(.init(risks.maxPos.x-1, risks.maxPos.y-1))
	}

	func solveA(_ fileName: String) -> Int {
		let risks = Grid2D(fileName: fileName)
		let cost = walk(risks: risks)
		return cost
	}

	func solveB(_ fileName: String) -> Int {
		0
	}
}
