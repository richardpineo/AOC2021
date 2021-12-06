
import AOCLib
import Foundation

class Solve6: PuzzleSolver {
	func solveAExamples() -> Bool {
		solve("Example6", 18) == 26 && solve("Example6", 80) == 5934
	}

	func solveBExamples() -> Bool {
		solve("Example6", 256) == 26_984_457_539
	}

	var answerA = "395627"
	var answerB = "1767323539209"

	func solveA() -> String {
		solve("Input6", 80).description
	}

	func solveB() -> String {
		solve("Input6", 256).description
	}

	func evolve(_ fish: [Int]) -> [Int] {
		var newAges = Array(repeating: 0, count: 9)

		for age in 1 ... 8 {
			newAges[age - 1] = fish[age]
		}
		newAges[6] += fish[0]
		newAges[8] = fish[0]
		return newAges
	}

	func solve(_ fileName: String, _ rounds: Int) -> Int {
		let input = FileHelper.load(fileName)!
		let fish = input[0].components(separatedBy: ",").map { Int($0)! }

		var ages = Array(repeating: 0, count: 9)
		fish.forEach {
			ages[$0] = ages[$0] + 1
		}

		for r in 0 ..< rounds {
			ages = evolve(ages)
			print("Round \(r): \(ages.reduce(0) { $0 + $1 })")
		}

		return ages.reduce(0) { $0 + $1 }
	}
}
