
import AOCLib
import Foundation

class Solve18: PuzzleSolver {
	func solveAExamples() -> Bool {
		let loaded = Self.loadTests.allSatisfy {
			let tree = load($0)
			print("\($0) -> \(tree.description)")
			return tree.description == $0
		}
		if !loaded {
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

	var answerA = ""
	var answerB = ""

	func solveA() -> String {
		// puzzleInput
		""
	}

	func solveB() -> String {
		""
	}
	
	typealias SnailTree = BinaryTree<Int>


	/*
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
	 */

	func add(_ e1: SnailTree, _ e2: SnailTree) -> SnailTree {
		.node(e1, 0, e2)
	}

	func explode(e _: SnailTree) -> Bool{
		// Find the first one at depth 4
		return false
	}
/*
	struct Pair {
		var first: Element
		var second: Element

		var description: String {
			String("[\(first.debugDescription),\(second.debugDescription)]")
		}
	}
 */

	func load(_ s: String, pos: inout Int) -> SnailTree {
		switch s.character(at: pos) {
		case "[":
			pos += 1
			let first = load(s, pos: &pos)
			pos += 1
			let second = load(s, pos: &pos)
			pos += 1
			return .node(first, 0, second)

		case "0" ... "9":
			let val = Int(String(s.character(at: pos)))!
			pos += 1
			return .node(.empty, val, .empty)

		default:
			break
		}
		return .empty
	}

	func load(_ s: String) -> SnailTree {
		var pos = 0
		return load(s, pos: &pos)
	}
}
