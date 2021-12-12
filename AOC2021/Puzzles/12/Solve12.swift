
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

	var answerA = ""
	var answerB = ""
	
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
	
	struct Nodes {
		let nodes: [Node]
		let start: Node
		let end: Node
	}
	
	func load(_ fileName: String) -> Nodes {
		let values = FileHelper.load(fileName)!.filter { !$0.isEmpty }
		var rawNodes = [Node]()
		
		func addNode(_ name: String) -> Node {
			if let found = rawNodes.first(where: { name == $0.name }) {
				return found
			}
			let n = Node(name: name)
			rawNodes.append(n )
			return n
		}

		values.forEach { line in
			let tokens = line.components(separatedBy: "-")
			let n1 = addNode(tokens[0])
			let n2 = addNode(tokens[1])
			n1.conections.append(n2)
			n2.conections.append(n1)
		}
		
		let nodes = Nodes(nodes: rawNodes,
						  start: rawNodes.first(where:{$0.name == "start"})!,
						  end: rawNodes.first(where:{$0.name == "end"})!)
		
		return nodes
	}

	func solveA() -> String {
		""
//		solveA("Input12").description
	}

	func solveB() -> String {
//		solveB("Input12").description
		""
	}

	func solveA(_ fileName: String) -> Int {
		let nodes = load(fileName)
		return 0
	}

	func solveB(_: String) -> Int {
		0
	}
}
