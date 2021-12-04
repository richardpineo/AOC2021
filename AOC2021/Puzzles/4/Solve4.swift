
import AOCLib
import Foundation

class Solve4: PuzzleSolver {
	func solveAExamples() -> Bool {
		solveA("Example4") == 4512
	}

	func solveBExamples() -> Bool {
//		solveB("Example4") ==
		true
	}

	var answerA = "0"
	var answerB = "0"
	
	class Board {
		struct Spot {
			var num: Int
			var marked: Bool
		}
		private var spots: [Spot]
		
		init(spotStrs: [String]) {
			spots = []
			for col in 0..<spotStrs.count {
				let nums = spotStrs[col].components(separatedBy: " ").filter { !$0.isEmpty }
				let colSpots = nums.map { Spot(num: Int($0)!, marked: false) }
				spots.append(contentsOf: colSpots)
			}
		}
	}

	func solveA() -> String {
		solveA("Input4").description
	}

	func solveB() -> String {
		solveB("Input4").description
	}
	
	struct Game {
		let pulls: [Int]
		let boards: [Board]
	}

	private func loadGame(_ fileName: String) -> Game {
		let input = FileHelper.load(fileName)!.filter { !$0.isEmpty }
		
		let pulls = input[0].description.components(separatedBy: ",").map { Int($0)! }
		
		var boards: [Board] = []
		var lineNum = 1
		while lineNum < input.count {
			var spotStrs: [String] = []
			for boardLine in 0...4 {
				spotStrs.append(input[lineNum+boardLine])
			}
			let board = Board(spotStrs: spotStrs)
			boards.append(board)
			
			lineNum += 5
		}
		return .init(pulls: pulls, boards: boards)
	}
	
	func solveA(_ fileName: String) -> Int {

		let game = loadGame(fileName)
		return game.boards.count
	}

	func solveB(_ fileName: String) -> Int {
		let input = FileHelper.load(fileName)!.filter { !$0.isEmpty }

		return 0
	}
}
