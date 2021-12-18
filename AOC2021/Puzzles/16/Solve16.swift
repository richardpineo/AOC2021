
import AOCLib
import Foundation

class Solve16: PuzzleSolver {
	func solveAExamples() -> Bool {
		examples.allSatisfy {
			let answer = solveA($0.input)
			print("\($0.input): \(answer)")
			return answer == $0.versionSum
		}
	}

	func solveBExamples() -> Bool {
		true
	}

	var answerA = "0"
	var answerB = ""

	func solveA() -> String {
		let input = FileHelper.load("Input16")![0]
		return solveA(input).description
	}

	func solveB() -> String {
		""
	}

	struct Example {
		var input: String
		var versionSum: Int
	}

	let examples: [Example] = [
		.init(input: "D2FE28", versionSum: 6),
		.init(input: "38006F45291200", versionSum: 9),
		.init(input: "EE00D40C823060", versionSum: 14),
		.init(input: "8A004A801A8002F478", versionSum: 16),
		.init(input: "620080001611562C8802118E34", versionSum: 12),
		.init(input: "C0015000016115A2E0802F182340", versionSum: 23),
		.init(input: "A0016C880162017C3686B18A3D4780", versionSum: 31),
	]

	enum LengthType {
		case totalLength(Int)
		case subPackets(Int)
	}

	struct PacketOperator {
		var operatorType: Int
		var lengthType: LengthType
		var packets: [Packet]
	}

	enum PacketContents {
		case literal(Int)
		case oper(PacketOperator)
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

	func solveB(_: String) -> Int {
		0
	}
}
