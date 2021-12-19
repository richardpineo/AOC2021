
import AOCLib
import Foundation

class Solve18: PuzzleSolver {
	func solveAExamples() -> Bool {
		Self.loadTests.forEach {
			let p = load($0)
			print(p)
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
	}

	struct Pair {
		var first: Element
		var second: Element
	}

	/*
	 func load(_ s: String, pos: inout Int) -> Element {
	 	switch s.character(at: pos) {
	 		case "[":
	 			pos += 1
	 			return load(s, pos: &pos)
	 		case "]"
	 			// start a new pair
	 		}

	 	}
	 }
	  */
	func load(_: String) -> Pair {
		.init(first: .number(0), second: .number(1))
	}

	func add(_: String) -> String {
		""
	}
}
