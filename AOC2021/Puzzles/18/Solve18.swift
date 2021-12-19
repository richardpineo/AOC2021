
import AOCLib
import Foundation

class Solve18: PuzzleSolver {
	func solveAExamples() -> Bool {
		let loaded = Self.loadTests.allSatisfy {
			// print("\($0) -> \(p.debugDescription)")
			return load($0).description == $0
		}
		if !loaded {
			return false
		}

		if add(Self.addTest.input) != Self.addTest.output {
			return false
		}

		/*
		 explodeTests

		 reduceTests

		 sumTests

		 magnitudeTests

		 bigFinal
		  */

		return true
	}

	func solveBExamples() -> Bool {
		true
	}

	var answerA = "0"
	var answerB = ""

	func solveA() -> String {
		// puzzleInput
		""
	}

	func solveB() -> String {
		""
	}

	indirect enum Element {
		case number(Int)
		case pair(Pair)
		
		var debugDescription: String {
			switch self {
			case let .number(n):
				return String(n)
			case let .pair(p):
				return p.description
			}
		}
	}

	struct Pair {
		var first: Element
		var second: Element
		
		var description: String {
			return String("[\(first.debugDescription),\(second.debugDescription)]")
		}
	}

	func load(_ s: String, pos: inout Int) -> Element {
		switch s.character(at: pos) {
		case "[":
			pos += 1
			let first = load(s, pos: &pos)
			pos += 1
			let second = load(s, pos: &pos)
			pos += 1
			return .pair(.init(first: first, second: second))
			
		case "0" ... "9":
			let val = Int(String(s.character(at: pos)))!
			pos += 1
			return .number(val)

		default:
			break
		}
		return .number(-666)
	}

	func load(_ s: String) -> Pair {
		var pos = 0
		if case let .pair(p) = load(s, pos: &pos) {
			return p
		}
		return .init(first: .number(-666), second: .number(-666))
	}

	func add(_: String) -> String {
		""
	}
}
