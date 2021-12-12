
import AOCLib
import Foundation

class Solve12: PuzzleSolver {
	func solveAExamples() -> Bool {
		if solveA("Example12-1") != 10 {
			return false
		}
		if solveA("Example12-2") != 19 {
			return false
		}
		if solveA("Example12-3") != 226 {
			return false
		}
		return true
	}

	func solveBExamples() -> Bool {
		if solveB("Example12-1") != 36 {
			return false
		}
		if solveB("Example12-2") != 103 {
			return false
		}
		if solveB("Example12-3") != 3509 {
			return false
		}
		return true
	}

	var answerA = "4186"
	var answerB = "92111"

	var shouldTestB: Bool = false

	func solveA() -> String {
		solveA("Input12").description
	}

	func solveB() -> String {
		solveB("Input12").description
	}

	class Node {
		init(name: String) {
			self.name = name
		}

		var name: String
		var connections: [Node] = []

		var big: Bool {
			name.character(at: 0).isUppercase
		}
	}

	typealias Nodes = [Node]

	func load(_ fileName: String) -> Nodes {
		let values = FileHelper.load(fileName)!.filter { !$0.isEmpty }
		var nodes = [Node]()

		func addNode(_ name: String) -> Node {
			if let found = nodes.first(where: { name == $0.name }) {
				return found
			}
			let n = Node(name: name)
			nodes.append(n)
			return n
		}

		values.forEach { line in
			let tokens = line.components(separatedBy: "-")
			let n1 = addNode(tokens[0])
			let n2 = addNode(tokens[1])
			n1.connections.append(n2)
			n2.connections.append(n1)
		}
		return nodes
	}

	enum Options {
		case singleSmall
		case oneSmallRevisit(String?)
	}

	func traverse(_ nodes: Nodes, _ options: Options, current: Node, path: [String]) -> Int {
		if current.name == "end" {
			return 1
		}
		let currentPaths = current.connections.reduce(0) { paths, destination in
			var futureOptions = options

			if !destination.big, path.contains(where: { destination.name == $0 }) {
				switch options {
				case .singleSmall:
					return paths
				case let .oneSmallRevisit(revisited):
					if revisited != nil || destination.name == "start" {
						return paths
					}
					futureOptions = .oneSmallRevisit(destination.name)
				}
			}
			var visited = Array(path)
			visited.append(destination.name)
			return paths + traverse(nodes, futureOptions, current: destination, path: visited)
		}
		return currentPaths
	}

	func traverse(_ fileName: String, _ options: Options) -> Int {
		let nodes = load(fileName)
		let path = ["start"]
		let start = nodes.first(where: { $0.name == "start" })!
		return traverse(nodes, options, current: start, path: path)
	}

	func solveA(_ fileName: String) -> Int {
		traverse(fileName, .singleSmall)
	}

	func solveB(_ fileName: String) -> Int {
		traverse(fileName, .oneSmallRevisit(nil))
	}
}
