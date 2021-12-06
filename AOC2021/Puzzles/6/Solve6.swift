
import AOCLib
import Foundation

class Solve6: PuzzleSolver {
	func solveAExamples() -> Bool {
		solve("Example6", 18) == 26 && solve("Example6", 80) == 5934
	}

	func solveBExamples() -> Bool {
		true
//		solve("Example6", orthogonalOnly: false) == 12
	}

	var answerA = "395627"
	var answerB = ""

	func solveA() -> String {
		solve("Input6", 80).description
	}

	func solveB() -> String {
		""
	//	solve("Input5", orthogonalOnly: false).description
	}
	
	func evolve(_ fish: [Int]) -> [Int] {
		var newFish: Int = 0
		var evolvedFish: [Int] = fish.map {
			if $0 == 0 {
				newFish += 1
				return 6
			}
			return $0 - 1
		}
		
		evolvedFish.append(contentsOf: Array<Int>(repeating: 8, count: newFish))
		return evolvedFish
	}

	func solve(_ fileName: String, _ rounds: Int) -> Int {
		let input = FileHelper.load(fileName)!
		var fish = input[0].components(separatedBy: ",").map { Int($0)! }
		
		for _ in 0..<rounds {
			fish = evolve(fish)
		}

		return fish.count
	}
}
