
import AOCLib
import Foundation

class Solve18: PuzzleSolver {
	func solveAExamples() -> Bool {
		let loaded = Self.loadTests.allSatisfy {
			let n = load($0)
			// print("\($0) -> \(n.description)")
			return n.description == $0
		}
		if !loaded {
			return false
		}

		let exploded = Self.explodeTests.allSatisfy {
			let n = load($0.input)
			let e = explode(n)!
			print("\($0.input) -> \(e.description) : \($0.output)")
			return e.description == $0.output
		}
		if !exploded {
			return false
		}

		/*
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
		
		var depth: Int {
			guard let p = parent else {
				return 0
			}
			return p.depth + 1
		}
		
		var root: Node {
			if let p = parent {
				return p.root
			}
			return self
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
	
	func findDepth4(_ n: Node) -> Node? {
		if case let .pair(n1, n2) = n.contents {
			if n.depth >= 4 {
				return n
			}

			if let d1 = findDepth4(n1) {
				return d1
			}
			if let d2 = findDepth4(n2) {
				return d2
			}
		}
		return nil
	}
	
	func rightmostChild(_ n: Node) -> Node? {
		switch n.contents {
		case .number:
			return n
		case let .pair(_, n2):
			return rightmostChild(n2)
		case .none:
			return nil
		}
	}
	
	func sideMostChild(_ n: Node, left: Bool) -> Node? {
		switch n.contents {
		case .number:
			return n
		case let .pair(n1, n2):
			return sideMostChild(left ? n1: n2, left: left)
		case .none:
			return nil
		}
	}

	
	func sideOf(_ n: Node?, left: Bool) -> Node? {
		guard let parent = n?.parent else {
			return nil
		}
		if case let .pair(n1, n2) = parent.contents {
			let child = left ? n1 : n2
			if ObjectIdentifier(child) != ObjectIdentifier(n!) {
				return sideMostChild(child, left: !left)
			}
			return sideOf(parent, left: left)
		}
		return nil
	}
	
	func explode(_ n: Node) -> Node? {
		// Find one at depth 4
		guard let deep = findDepth4(n) else {
			return nil
		}

		guard case let .pair(left, right) = deep.contents,
			  case let .number(leftVal) = left.contents,
			  case let .number(rightVal) = right.contents
		else {
			return nil
		}
		
		if let leftNode = sideOf(deep, left: true),
		  case  let .number(curLeftVal) = leftNode.contents {
			leftNode.contents = .number(curLeftVal + leftVal)
		}
		if let rightNode = sideOf(deep, left: false),
		   case let .number(curRightVal) = rightNode.contents {
			rightNode.contents = .number(curRightVal + rightVal)
		}
		
		let parent = deep.parent!
		if case let .pair(n1, n2) = parent.contents {
			let newNode = Node(contents: .number(0), parent: parent)
			if ObjectIdentifier(n1) == ObjectIdentifier(deep) {
				parent.contents = .pair(newNode, n2)
			} else {
				parent.contents = .pair(n1, newNode)
			}
		}
		return parent.root
	}
	
	func add(_ e1: inout Node, _ e2: inout Node) -> Node {
		let node = Node(contents: .pair(e1, e2), parent: nil)
		e1.parent = node
		e2.parent = node
		return node
	}
}
