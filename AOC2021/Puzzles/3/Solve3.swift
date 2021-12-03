
import AOCLib
import Foundation

class Solve3: PuzzleSolver {
	func solveAExamples() -> Bool {
		solveA("Example3") == 198
	}

	func solveBExamples() -> Bool {
		true
//		solveB("Example3") == 900
	}

	var answerA = "3277364"
	var answerB = ""

	func solveA() -> String {
		solveA("Input3").description
	}

	func solveB() -> String {
		solveB("Input3").description
	}

	func solveA(_ fileName: String) -> Int {
		let input = FileHelper.loadAndTokenize(fileName)
		let bitCount = input[0][0].count
		var gamma: [Int] = .init(repeating: 0, count: bitCount)
		var epsilon: [Int] = .init(repeating: 0, count: bitCount)
		for bit in 0..<bitCount {
			var ones = 0
			for line in 0..<input.count {
				ones += input[line][0].character(at: bit) == "1" ? 1 : 0
			}
			let isOneDominant = ones > input.count / 2
			gamma[bit] = isOneDominant ? 1 : 0
			epsilon[bit] = isOneDominant ? 0 : 1
		}
		
		let gammaStr = gamma.map { $0.description }.joined()
		let gammaNum = gammaStr.binaryToNumber()
		let epsilonStr = epsilon.map { $0.description }.joined()
		let epsilonNum = epsilonStr.binaryToNumber()
		return Int(epsilonNum) * Int(gammaNum)
	}

	func solveB(_ fileName: String) -> Int {
		0
	}
}
