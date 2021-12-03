
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
	var answerB = "5736383"

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
		return Double(ones) >= Double(lines.count) / 2.0
	}
	
	func calcA(lines: [String], onesDominant: Bool) -> Int {
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
		let gamma = calcA(lines: input, onesDominant: true)
		let epsilon = calcA(lines: input, onesDominant: false)
		return gamma * epsilon
	}
		
	func filterB(lines: [String], bit: Int, keepDominant: Bool) -> [String] {
		let oneDom = isOneDominant(lines: lines, pos: bit)
		let matchChar: Character = keepDominant ?
		(oneDom ? "1" : "0") :
		(oneDom ? "0" : "1")
		return lines.filter { $0.character(at: bit) == matchChar }
	}

	func calcB(lines: [String], keepDominant: Bool) -> Int {
		var temp = lines
		var bitPos = 0
		while temp.count > 1 {
			temp = filterB(lines: temp, bit: bitPos, keepDominant: keepDominant)
			bitPos += 1
		}
		return Int(temp[0].binaryToNumber())
	}

	func solveB(_ fileName: String) -> Int {
		let input = FileHelper.load(fileName)!.filter { !$0.isEmpty }
		
		let oxygen = calcB(lines: input, keepDominant: true)
		let co2 = calcB(lines: input, keepDominant: false)
		return oxygen * co2
	}
}
