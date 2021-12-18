
import AOCLib
import Foundation

class Solve16: PuzzleSolver {
	func solveAExamples() -> Bool {
		examplesA.allSatisfy {
			let answer = solveA($0.input)
			// print("A: \($0.input): \(answer)")
			return answer == $0.answer
		}
	}

	func solveBExamples() -> Bool {
		examplesB.allSatisfy {
			let answer = solveB($0.input)
			print("B: \($0.input): \(answer)")
			return answer == $0.answer
		}
	}

	var answerA = "991"
	var answerB = "1264485568252"

	func solveA() -> String {
		let input = FileHelper.load("Input16")![0]
		return solveA(input).description
	}

	func solveB() -> String {
		let input = FileHelper.load("Input16")![0]
		return solveB(input).description
	}

	struct Example {
		var input: String
		var answer: Int
	}

	let examplesA: [Example] = [
		.init(input: "D2FE28", answer: 6),
		.init(input: "38006F45291200", answer: 9),
		.init(input: "EE00D40C823060", answer: 14),
		.init(input: "8A004A801A8002F478", answer: 16),
		.init(input: "620080001611562C8802118E34", answer: 12),
		.init(input: "C0015000016115A2E0802F182340", answer: 23),
		.init(input: "A0016C880162017C3686B18A3D4780", answer: 31),
	]

	let examplesB: [Example] = [
		.init(input: "C200B40A82", answer: 3),
		.init(input: "04005AC33890", answer: 54),
		.init(input: "880086C3E88112", answer: 7),
		.init(input: "CE00C43D881120", answer: 9),
		.init(input: "D8005AC2A8F0", answer: 1),
		.init(input: "F600BC2D8F", answer: 0),
		.init(input: "9C005AC2F8F0", answer: 0),
		.init(input: "9C0141080250320F1802104A08", answer: 1),
	]
	
	enum LengthType {
		case totalLength(Int)
		case subPackets(Int)
	}

	struct PacketOperator {
		var operatorType: Int
		var lengthType: LengthType
		var packets: [Packet]
		
		var evaluate: Int {
			switch operatorType {
			case 0:
				return packets.reduce(0) { $0 + $1.contents.evaluate }
			case 1:
				return packets.reduce(1) { $0 * $1.contents.evaluate }
			case 2:
				return packets.min { $0.contents.evaluate < $1.contents.evaluate }!.contents.evaluate
			case 3:
				return packets.max { $0.contents.evaluate < $1.contents.evaluate }!.contents.evaluate
			case 5:
				return packets[0].contents.evaluate > packets[1].contents.evaluate ? 1 : 0
			case 6:
				return packets[0].contents.evaluate < packets[1].contents.evaluate ? 1 : 0
			case 7:
				return packets[0].contents.evaluate == packets[1].contents.evaluate ? 1 : 0
			default:
				return -666
			}
		}
	}

	enum PacketContents {
		case literal(Int)
		case oper(PacketOperator)
		
		var evaluate: Int {
			switch self {
			case let .literal(v):
				return v
			case let .oper(o):
				return o.evaluate
			}
		}
	}

	struct Packet {
		var version: Int
		var contents: PacketContents
	}

	func binToNum(_ b: String) -> Int {
		Int(b.binaryToNumber())
	}

	func readOperator(operType: Int, pos: inout Int, stream: String) -> PacketContents {
		let lenType = stream.character(at: pos)
		pos += 1
		if lenType == "0" {
			// Next 15 bits
			let len = binToNum(stream.subString(start: pos, count: 15))
			let subStr = stream.subString(start: pos + 15, count: len)
			pos += len + 15
			var subPos = 0
			var packets: [Packet] = []
			while subPos < len {
				packets.append(readPacket(&subPos, stream: subStr))
			}
			return .oper(.init(operatorType: operType, lengthType: .totalLength(len), packets: packets))
		} else {
			let len = binToNum(stream.subString(start: pos, count: 11))
			pos += 11
			var packets: [Packet] = []
			for _ in 0 ..< len {
				packets.append(readPacket(&pos, stream: stream))
			}
			return .oper(.init(operatorType: operType, lengthType: .subPackets(len), packets: packets))
		}
	}

	func readLiteral(_ pos: inout Int, stream: String) -> PacketContents {
		// read in groups of 5
		var isMore = true
		var totalVal = ""
		while isMore {
			isMore = stream.character(at: pos) == "1"
			totalVal.append(stream.subString(start: pos + 1, count: 4))
			pos += 5
		}
		return .literal(binToNum(totalVal))
	}

	func readPacketContents(_ pos: inout Int, stream: String) -> PacketContents {
		let type = binToNum(stream.subString(start: pos, count: 3))
		pos += 3
		if type == 4 {
			// This is a literal packet
			return readLiteral(&pos, stream: stream)
		} else {
			// This is an operator packet
			return readOperator(operType: type, pos: &pos, stream: stream)
		}
	}

	func readPacket(_ pos: inout Int, stream: String) -> Packet {
		let version = binToNum(stream.subString(start: pos, count: 3))
		pos += 3
		let contents = readPacketContents(&pos, stream: stream)
		return .init(version: version, contents: contents)
	}

	func sumVersions(_ p: Packet) -> Int {
		var subValue = 0
		if case let .oper(op) = p.contents {
			subValue = op.packets.reduce(0) { $0 + sumVersions($1) }
		}
		return p.version + subValue
	}

	func solveA(_ input: String) -> Int {
		let bin = input.hexToBinary()
		var pos = 0
		let p = readPacket(&pos, stream: bin)
		return sumVersions(p)
	}

	func solveB(_ input: String) -> Int {
		let bin = input.hexToBinary()
		var pos = 0
		let p = readPacket(&pos, stream: bin)
		return p.contents.evaluate
	}
}
