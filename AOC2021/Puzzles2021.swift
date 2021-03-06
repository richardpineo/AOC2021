
import AOCLib
import SwiftUI

class Puzzles2021: PuzzlesRepo {
	init() {
		let year = 2021

		puzzles = Puzzles(puzzles: [
			Puzzle(year: year, id: 1, name: "Sonar Sweep") { Solve1() },
			Puzzle(year: year, id: 2, name: "Dive!") { Solve2() },
			Puzzle(year: year, id: 3, name: "Binary Diagnostic") { Solve3() },
			Puzzle(year: year, id: 4, name: "Giant Squid") { Solve4() },
			Puzzle(year: year, id: 5, name: "Hydrothermal Venture") { Solve5() },
			Puzzle(year: year, id: 6, name: "Lanternfish") { Solve6() },
			Puzzle(year: year, id: 7, name: "The Treachery of Whales") { Solve7() },
			Puzzle(year: year, id: 8, name: "Seven Segment Search") { Solve8() },
			Puzzle(year: year, id: 9, name: "Smoke Basin") { Solve9() },
			Puzzle(year: year, id: 10, name: "Syntax Scoring") { Solve10() },
			Puzzle(year: year, id: 11, name: "Dumbo Octopus") { Solve11() },
			Puzzle(year: year, id: 12, name: "Passage Pathing") { Solve12() },
			Puzzle(year: year, id: 13, name: "Transparent Origami") { Solve13() },
			Puzzle(year: year, id: 14, name: "Extended Polymerization") { Solve14() },
			Puzzle(year: year, id: 15, name: "Chiton") { Solve15() },
			Puzzle(year: year, id: 16, name: "Packet Decoder") { Solve16() },
			Puzzle(year: year, id: 17, name: "Trick Shot") { Solve17() },
			Puzzle(year: year, id: 18, name: "Snailfish") { Solve18() },
			Puzzle(year: year, id: 19, name: "Beacon Scanner") { Solve19() },
			Puzzle(year: year, id: 20, name: "Trench Map") { Solve20() },
		])
	}

	var title: String {
		"Advent of Code 2021"
	}

	var puzzles: Puzzles

	func hasDetails(id: Int) -> Bool {
		id == 9
	}

	@ViewBuilder
	func details(id: Int) -> some View {
		switch id {
		case 9:
			Puzzle9View()

		default:
			EmptyView()
		}
	}
}
