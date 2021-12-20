
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
			// print("\($0.input) -> \(e.description) : \($0.output)")
			return e.description == $0.output
		}
		if !exploded {
			return false
		}

		var node10 = Node(contents: .number(10), parent: nil)
		var node11 = Node(contents: .number(11), parent: nil)
		split(&node10)
		split(&node11)
		if node11.description != "[5,6]" || node10.description != "[5,5]" {
			return false
		}

		let summed = Self.sumTests.allSatisfy { test in
			let solved = solve(test.input)
			return solved.description == test.output
		}
		if !summed {
			return false
		}

		let magnituded = Self.magnitudeTests.allSatisfy {
			let n = load($0.input)
			return n.magnitude == $0.output
		}
		if !magnituded {
			return false
		}
		
		let n = solve(Self.bigFinal.input)
		return n.magnitude == Self.bigFinal.output
	}

	func solveBExamples() -> Bool {
		true
	}

	var answerA = ""
	var answerB = ""

	func solveA() -> String {
		solve(Self.puzzleInput).magnitude.description
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
			contents?.description ?? ""
		}

		var depth: Int {
			guard let p = parent else {
				return 0
			}
			return p.depth + 1
		}
		
		var magnitude: Int {
			switch contents {
			case let .number(v):
				return v
			case let .pair(n1, n2):
				return 3 * n1.magnitude + 2 * n2.magnitude
			default:
				return 0
			}
		}

		var root: Node {
			if let p = parent {
				return p.root
			}
			return self
		}

		func find(_ pred: (Int) -> Bool) -> Node? {
			switch contents {
			case let .number(v):
				if pred(v) {
					return self
				}
			case let .pair(n1, n2):
				if let f1 = n1.find(pred) {
					return f1
				}
				if let f2 = n2.find(pred) {
					return f2
				}
			default:
				break
			}
			return nil
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
				return String("[\(n1.description),\(n2.description)]")
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
			if n.depth >= 4,
			   case .number = n1.contents,
			   case .number = n2.contents {
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
			return sideMostChild(left ? n1 : n2, left: left)
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

		if let leftNode = sideOf(deep, left: true) {
			guard case let .number(curLeftVal) = leftNode.contents else {
				return nil
			}
			leftNode.contents = .number(curLeftVal + leftVal)
		}
		if let rightNode = sideOf(deep, left: false) {
			guard case let .number(curRightVal) = rightNode.contents else {
				return nil
			}
			rightNode.contents = .number(curRightVal + rightVal)
		}

		replace(existing: deep, with: Node(contents: .number(0), parent: nil))
		return n
	}

	func replace(existing: Node, with: Node) {
		guard let parent = existing.parent else {
			return
		}
		with.parent = parent
		guard case let .pair(n1, n2) = parent.contents else {
			return
		}
		if ObjectIdentifier(n1) == ObjectIdentifier(existing) {
			parent.contents = .pair(with, n2)
		} else {
			parent.contents = .pair(n1, with)
		}
	}

	func split(_ e: inout Node) {
		guard case let .number(n) = e.contents else {
			return
		}
		let leftVal = Int(floor(Double(n) / 2.0))
		let rightVal = Int(ceil(Double(n) / 2.0))
		let left = Node(contents: .number(leftVal), parent: e)
		let right = Node(contents: .number(rightVal), parent: e)
		e.contents = .pair(left, right)
	}

	func splitIfNeeded(_ n: Node) -> Bool {
		// find a value > 10
		guard var found = n.find({ $0 >= 10 }) else {
			return false
		}
		split(&found)
		return true
	}

	func add(_ e1: inout Node, _ e2: inout Node) -> Node {
		var node = Node(contents: .pair(e1, e2), parent: nil)
		e1.parent = node
		e2.parent = node
		print("  Add: \(node.description)")

		// Now that we have added, split and explode until it's all settled.
		while true {
			if let e = explode(node) {
				node = e.root
				// print("    Explode: \(node.description)")
				continue
			}

			if splitIfNeeded(node) {
				// print("    Split: \(node.description)")
				continue
			}

			return node
		}
	}
	
	func solve(_ s: String) -> Node {
		let inputs = s.components(separatedBy: "\n").filter { !$0.isEmpty }
		var answer = load(inputs[0])
		for i in 1 ..< inputs.count {
			var term = load(inputs[i])
			answer = add(&answer, &term)
		}
		return answer
	}
}
