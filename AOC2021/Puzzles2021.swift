
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
		])
	}

	var title: String {
		"Advent of Code 2021"
	}

	var puzzles: Puzzles

	func hasDetails(id _: Int) -> Bool {
		false
	}

	@ViewBuilder
	func details(id _: Int) -> some View {
		EmptyView()
	}
}
