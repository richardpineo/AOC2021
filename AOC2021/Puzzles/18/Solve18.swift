
import AOCLib
import Foundation

class Solve18: PuzzleSolver {
	func solveAExamples() -> Bool {
		let loaded = Self.loadTests.allSatisfy {
			let n = load($0)
			print("\($0) -> \(n.description)")
			return n.description == $0
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
	
	class Node {
		init(contents: Element?, parent: Node?) {
			self.contents = contents
			self.parent = parent
		}
		var parent: Node?
		var contents: Element?
		
		var description: String {
			return contents?.description ?? ""
		}
	}

	indirect enum Element {
		case number(Int)
		case pair(Node, Node)
		
		var description: String {
			switch self {
			case let .number(n):
				return String(n)
			case let .pair(n1, n2):
				return  String("[\(n1.description),\(n2.description)]")
			}
		}
	}

	func load(_ s: String, parent: Node?, pos: inout Int) -> Node {
		switch s.character(at: pos) {
		case "[":
			let child = Node(contents: nil, parent: parent)
			pos += 1
			let first = load(s, parent: child, pos: &pos)
			pos += 1
			let second = load(s, parent: child, pos: &pos)
			pos += 1
			child.contents = .pair(first, second)
			return child
			
		case "0" ... "9":
			let val = Int(String(s.character(at: pos)))!
			pos += 1
			return .init(contents: .number(val), parent: parent)

		default:
			break
		}
		return .init(contents: .number(-666), parent: parent)
	}

	func load(_ s: String) -> Node {
		var pos = 0
		return load(s, parent: nil, pos: &pos)
	}
	
	func add(_ e1: inout Node, _ e2: inout Node) -> Node {
		let node = Node(contents: .pair(e1, e2), parent: nil)
		e1.parent = node
		e2.parent = node
		return node
	}
}
