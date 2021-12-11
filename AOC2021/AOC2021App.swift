
import AOCLib
import SwiftUI

@main
struct AOC2021App: App {
	let puzzles = Puzzles2021()
	var body: some Scene {
		WindowGroup {
			MainView(repo: puzzles)
				.environmentObject(PuzzleProcessing.application(puzzles: puzzles.puzzles))
		}
	}
}
