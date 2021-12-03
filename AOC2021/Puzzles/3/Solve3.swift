
import AOCLib
import Foundation

class Solve3: PuzzleSolver {
	func solveAExamples() -> Bool {
		solveA("Example3") == 198
	}

	func solveBExamples() -> Bool {
		solveB("Example3") == 230
	}

	var answerA = "3277364"
	var answerB = ""

	func solveA() -> String {
		solveA("Input3").description
	}

	func solveB() -> String {
		solveB("Input3").description
	}
	
	func isOneDominant(lines: [String], pos: Int) -> Bool {
		var ones = 0
		for line in 0..<lines.count {
			ones += lines[line].character(at: pos) == "1" ? 1 : 0
		}
		return ones >= lines.count / 2
	}
	
	func calc(lines: [String], onesDominant: Bool) -> Int {
		let bitCount = lines[0].count
		var final: [Int] = .init(repeating: 0, count: bitCount)
		for bit in 0..<bitCount {
			let dom = isOneDominant(lines: lines, pos: bit)
			if onesDominant {
				final[bit] = dom ? 1 : 0
			} else {
				final[bit] = dom ? 0 : 1
			}
		}
		
		let finalStr = final.map { $0.description }.joined()
		return Int(finalStr.binaryToNumber())
	}

	func solveA(_ fileName: String) -> Int {
		let input = FileHelper.load(fileName)!.filter { !$0.isEmpty }
		
		let gamma = calc(lines: input, onesDominant: true)
		let epsilon = calc(lines: input, onesDominant: false)
		return gamma * epsilon
	}

	func solveB(_ fileName: String) -> Int {
		0
	}
}
