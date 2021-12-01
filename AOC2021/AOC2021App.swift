
import AOCLib
import SwiftUI

@main
struct AOC2015App: App {
	let puzzles = Puzzles2021()
	var body: some Scene {
		WindowGroup {
			MainView(repo: puzzles)
				.environmentObject(PuzzleProcessing.application(puzzles: puzzles.puzzles))
		}
	}
}
