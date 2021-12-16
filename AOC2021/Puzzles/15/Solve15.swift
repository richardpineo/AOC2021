
import AOCLib
import Foundation

class Solve15: PuzzleSolver {
	func solveAExamples() -> Bool {
		solveA("Example15") == 40
	}

	func solveBExamples() -> Bool {
		solveB("Example15") == 315
	}

	var answerA = "698"
	var answerB = "3022"

	var shouldTestB: Bool = false
	
	func solveA() -> String {
		solveA("Input15").description
	}

	func solveB() -> String {
		solveB("Input15").description
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
		let risks = Grid2D(fileName: fileName)
		var megaRisks = Grid2D(maxPos: .init(risks.maxPos.x*5, risks.maxPos.y*5), initialValue: -1)
		for x in 0..<risks.maxPos.x {
			for y in 0..<risks.maxPos.y {
				for mx in 0..<5 {
					for my in 0..<5 {
						let val = risks.value(.init(x,y))
						var megaVal = val + mx + my
						if megaVal > 9 {
							megaVal -= 9
						}
						megaRisks.setValue(.init(x + (mx * risks.maxPos.x), y + (my * risks.maxPos.y)), megaVal)
					}
				}
			}
		}
		let cost = walk(risks: megaRisks)
		return cost
	}
}
