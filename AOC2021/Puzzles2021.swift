
import AOCLib
import SwiftUI

class Puzzles2021: PuzzlesRepo {
	init() {
		let year = 2021

		puzzles = Puzzles(puzzles: [
			Puzzle(year: year, id: 1, name: "Sonar Sweep") { Solve1() },
			Puzzle(year: year, id: 2, name: "Dive!") { Solve2() },
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
