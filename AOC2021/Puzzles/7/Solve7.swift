
import AOCLib
import Foundation

class Solve7: PuzzleSolver {
	func solveAExamples() -> Bool {
		solve("Example7", fuelCalc: fuelCostA) == 37
	}

	func solveBExamples() -> Bool {
		true
	}

	var answerA = "342641"
	var answerB = ""

	func solveA() -> String {
		solve("Input7", fuelCalc: fuelCostA).description
	}

	func solveB() -> String {
		""
	}
	
	func fuelCostA(crabs: [Int], offset: Int) -> Int {
		crabs.reduce(0) { $0 + abs($1 - offset) }
	}

	func solve(_ fileName: String, fuelCalc: ([Int], Int) -> Int) -> Int {
		let input = FileHelper.load(fileName)!
		let crabs = input[0].components(separatedBy: ",").map { Int($0)! }.sorted()
		var leastFuel = Int.max
		for offset in crabs.min()! ... crabs.max()! {
			let fuel = fuelCalc(crabs, offset)
			// print("Distance for offset \(offset) is \(distance)")
			leastFuel = min(leastFuel, fuel)
		}
		return leastFuel
	}
}
