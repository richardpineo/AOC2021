
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

	var answerA = "25410"
	var answerB = "0"
	
	class Board {
		struct Spot {
			var num: Int
			var marked: Bool
		}
		var spots: [Spot]
		
		init(spotStrs: [String]) {
			spots = []
			for row in 0..<spotStrs.count {
				let nums = spotStrs[row].components(separatedBy: " ").filter { !$0.isEmpty }
				let cols = nums.map { Spot(num: Int($0)!, marked: false) }
				spots.append(contentsOf: cols)
			}
		}
		
		func mark(num: Int) {
			guard let spotIndex = spots.firstIndex( where: { $0.num == num } ) else {
				return
			}
			spots[spotIndex] = .init(num: num, marked: true)
		}

		var bingo: Bool {
			for idx1 in 0...4 {
				let idx2 = 0...4
				if idx2.allSatisfy({ spots[Position2D(idx1, $0).arrayIndex(numCols: 5)].marked }) {
					return true
				}
				if idx2.allSatisfy({ spots[Position2D($0, idx1).arrayIndex(numCols: 5)].marked }) {
					return true
				}
			}
			return false
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
		
		func play() -> Int {
			for pullIndex in 0..<pulls.count {
				let pull = pulls[pullIndex]
				boards.forEach { $0.mark(num: pull)}
				
				if let bingo = boards.first(where: { $0.bingo }) {
					let sumUnmarked = bingo.spots.reduce(0 ) {
						$0 + ($1.marked ? 0 : $1.num)
					}
					return sumUnmarked * pull
				}
			}
			return -666
		}
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
		return game.play()
	}

	func solveB(_ fileName: String) -> Int {
		let input = FileHelper.load(fileName)!.filter { !$0.isEmpty }

		return 0
	}
}
