
import AOCLib
import Foundation

class Solve7: PuzzleSolver {
	func solveAExamples() -> Bool {
		solve("Example7") == 37
	}

	func solveBExamples() -> Bool {
		true
	}

	var answerA = "342641"
	var answerB = ""

	func solveA() -> String {
		solve("Input7").description
	}

	func solveB() -> String {
		""
	}
	
	func fuelCostA(crabs: [Int], offset: Int) -> Int {
		crabs.reduce(0) { $0 + abs($1 - offset) }
	}

	func solve(_ fileName: String) -> Int {
		let input = FileHelper.load(fileName)!
		let crabs = input[0].components(separatedBy: ",").map { Int($0)! }.sorted()
		var minDistance = Int.max
		for offset in crabs.min()! ... crabs.max()! {
			let distance = fuelCostA(crabs:)
			// print("Distance for offset \(offset) is \(distance)")
			minDistance = min(minDistance, distance)
		}
		return minDistance
	}
}
