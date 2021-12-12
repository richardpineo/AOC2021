
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
		true
	}

	var answerA = "4186"
	var answerB = ""

	func solveA() -> String {
		solveA("Input12").description
	}

	func solveB() -> String {
//		solveB("Input12").description
		""
	}

	class Node {
		init(name: String) {
			self.name = name
		}

		var name: String
		var conections: [Node] = []

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
			n1.conections.append(n2)
			n2.conections.append(n1)
		}
		return nodes
	}

	func traverse(_ nodes: Nodes, current: Node, path: [String]) -> [[String]] {
		if current.name == "end" {
			return [path]
		}

		let currentPaths = current.conections.reduce([[String]]()) { paths, destination in
			if !destination.big, path.contains(where: { destination.name == $0 }) {
				return paths
			}
			var visited = Array(path)
			visited.append(destination.name)
			var newPaths = traverse(nodes, current: destination, path: visited)
			newPaths.append(contentsOf: paths)
			return newPaths
		}
		return currentPaths
	}

	func solveA(_ fileName: String) -> Int {
		let nodes = load(fileName)
		let path = ["start"]
		let start = nodes.first(where: { $0.name == "start" })!
		let paths = traverse(nodes, current: start, path: path)
		return paths.count
	}

	func solveB(_: String) -> Int {
		0
	}
}
